package com.example.demo.service;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.entity.User;
import com.example.demo.repository.UserRepository;

/**
 * Pet Service - Handles all pet-related business logic
 *
 * Pet Evolution System:
 * - Pet has 4 appearance stages: Baby (0) -> Teen (1) -> Adult (2) -> Full Grown (3)
 * - Evolution requires reaching specific level thresholds:
 *   Stage 0 -> 1: Requires Level 5
 *   Stage 1 -> 2: Requires Level 10
 *   Stage 2: Maximum stage, no further evolution
 *
 * Pet Attributes:
 * - Level: 1-20 (determines evolution readiness)
 * - Stage: 0-3 (determines appearance, persists after evolution)
 * - Mood: 0-100 (decreases when user doesn't work out)
 * - Energy: 0-100 (consumed during workouts, recovers over time)
 */
@Service
public class PetService {

    @Autowired
    private UserRepository userRepository;

    /**
     * Available pet elemental types
     */
    public static final String[] PET_TYPES = {"fire", "water", "grass", "electric"};

    /**
     * Cumulative experience thresholds for each level
     * Index represents level, value represents total EXP required
     */
    private static final int[] LEVEL_EXP_THRESHOLDS = {
        0,      // Level 1
        50,     // Level 2
        120,    // Level 3
        250,    // Level 4
        450,    // Level 5 (Evolution Point)
        700,    // Level 6
        1000,   // Level 7
        1350,   // Level 8
        1750,   // Level 9
        2200,   // Level 10 (Evolution Point)
        2700,   // Level 11
        3250,   // Level 12
        3850,   // Level 13
        4500,   // Level 14
        5200,   // Level 15
        5950,   // Level 16
        6750,   // Level 17
        7600,   // Level 18
        8500,   // Level 19
        9500    // Level 20 (Max Level)
    };

    /**
     * Initialize a new pet for a user upon registration
     *
     * @param user    The user who is initializing the pet
     * @param petType The elemental type of the pet (fire/water/grass/electric)
     */
    public void initPet(User user, String petType) {
        user.setPetType(petType);
        user.setPetLevel(1);
        user.setPetExp(0);
        user.setPetMood(100);
        user.setPetEnergy(100);
        user.setPetStage(0);  // Initial stage: Baby
        userRepository.save(user);
    }

    /**
     * Update pet stats when a workout is completed
     * - Adds experience points (base + streak bonus)
     * - Increases mood
     * - Decreases energy
     * - Checks for level up
     * - Updates last active timestamp
     *
     * @param user The user whose pet needs to be updated
     */
      public void onWorkoutComplete(User user) {
        // 1. 防御 Null (兼容旧数据库数据)
        int currentStreak = user.getStreakDays() != null ? user.getStreakDays() : 0;
        int currentExp = user.getPetExp() != null ? user.getPetExp() : 0;
        int currentMood = user.getPetMood() != null ? user.getPetMood() : 100;
        int currentEnergy = user.getPetEnergy() != null ? user.getPetEnergy() : 100;

        // 2. 增加经验
        int baseExp = 20;
        int streakBonus = Math.min(currentStreak, 10) * 2; 
        int addedExp = baseExp + streakBonus;
        user.setPetExp(currentExp + addedExp);

        // 3. 更新心情与体力
        user.setPetMood(Math.min(100, currentMood + 10));
        user.setPetEnergy(Math.max(0, currentEnergy - 30));

        // 4. 检查升级
        checkLevelUp(user);

        user.setPetLastActive(LocalDateTime.now());
        userRepository.save(user);
    }

    /**
     * Check if pet has enough experience to level up
     * Note: Evolution stages (level 5, 10) do NOT auto-level up
     *
     * @param user The user whose pet needs level check
     */
    private void checkLevelUp(User user) {
        int level = user.getPetLevel() != null ? user.getPetLevel() : 1;
        int currentExp = user.getPetExp() != null ? user.getPetExp() : 0;

        // 当经验达到下一级要求，并且还没满级时，持续升级
        while (level < 20 && currentExp >= LEVEL_EXP_THRESHOLDS[level]) {
            level++;
        }
        user.setPetLevel(level);
    }

    /**
     * Manually trigger evolution via user action
     * Evolution only changes appearance (petStage), not level
     *
     * Return values:
     * -1 = Level requirement not met
     * -2 = Already at maximum stage (stage 2)
     * >= 0 = New stage value after successful evolution
     *
     * @param user The user triggering evolution
     * @return Evolution result code
     */
    public int evolvePet(User user) {
        int stage = user.getPetStage() != null ? user.getPetStage() : 0;

        // Cannot evolve beyond stage 2 (Maximum stage)
        if (stage >= 2) {
            return -2;
        }

        // Check level requirements for evolution
        int level = user.getPetLevel();
        if (stage == 0 && level < 5) {
            return -1; // Need level 5 to evolve from Baby to Teen
        }
        if (stage == 1 && level < 10) {
            return -1; // Need level 10 to evolve from Teen to Adult
        }

        // Perform evolution - increment stage
        int newStage = stage + 1;
        user.setPetStage(newStage);
        userRepository.save(user);

        return newStage;
    }

    /**
     * Calculate mood decay when user doesn't work out
     * Mood decreases by 20 points for each full day of inactivity
     *
     * @param user The user whose pet mood needs to decay
     */
    public void updateMoodDecay(User user) {
        if (user.getPetLastActive() == null) {
            user.setPetLastActive(LocalDateTime.now());
            userRepository.save(user);
            return;
        }

        try {
            long hoursSinceActive = ChronoUnit.HOURS.between(user.getPetLastActive(), LocalDateTime.now());

            // Mood decreases by 20 for each full day of inactivity
            if (hoursSinceActive >= 24) {
                int daysInactive = (int) (hoursSinceActive / 24);
                int moodLoss = daysInactive * 20;
                user.setPetMood(Math.max(0, user.getPetMood() - moodLoss));
                user.setPetLastActive(LocalDateTime.now()); // Prevent repeated decay
                userRepository.save(user);
            }
        } catch (Exception e) {
            // Reset timestamp on error
            user.setPetLastActive(LocalDateTime.now());
        }
    }

    /**
     * Recover pet energy over time
     * Energy recovers 10 points per 6 hours of inactivity
     *
     * @param user The user whose pet energy needs to recover
     */
    public void recoverEnergy(User user) {
        if (user.getPetLastActive() == null) {
            user.setPetLastActive(LocalDateTime.now());
            userRepository.save(user);
            return;
        }

        try {
            long hoursSinceActive = ChronoUnit.HOURS.between(user.getPetLastActive(), LocalDateTime.now());

            if (hoursSinceActive >= 6) {
                int energyGain = (int) (hoursSinceActive / 6) * 10;
                user.setPetEnergy(Math.min(100, user.getPetEnergy() + energyGain));
                userRepository.save(user);
            }
        } catch (Exception e) {
            // Reset timestamp on error
            user.setPetLastActive(LocalDateTime.now());
        }
    }

    /**
     * Calculate experience progress percentage within current evolution stage
     * Progress is relative to the EXP required for the next evolution point
     *
     * @param user The user whose pet progress needs calculation
     * @return Progress percentage (0-100)
     */
     public int getExpProgress(User user) {
        int level = user.getPetLevel() != null ? user.getPetLevel() : 1;
        if (level >= 20) return 100; // 满级满进度

        int currentExp = user.getPetExp() != null ? user.getPetExp() : 0;
        
        // 获取当前等级的基准经验和下一级的目标经验
        int baseExpForCurrentLevel = LEVEL_EXP_THRESHOLDS[level - 1];
        int expNeededForNextLevel = LEVEL_EXP_THRESHOLDS[level];

        // 计算当前级内的进度比例
        int expInLevel = Math.max(0, currentExp - baseExpForCurrentLevel);
        int levelExpRange = expNeededForNextLevel - baseExpForCurrentLevel;

        return (int) ((expInLevel * 100.0) / levelExpRange);
    }

    /**
     * Check if pet is eligible for evolution
     * Evolution requires meeting both stage and level requirements
     *
     * @param user The user whose pet needs evolution check
     * @return true if evolution is possible, false otherwise
     */
    public boolean shouldEvolve(User user) {
        int stage = user.getPetStage() != null ? user.getPetStage() : 0;
        int level = user.getPetLevel();

        // Stage 0: Can evolve at level 5
        if (stage == 0 && level >= 5) return true;
        // Stage 1: Can evolve at level 10
        if (stage == 1 && level >= 10) return true;
        // Stage 2: Maximum stage reached, cannot evolve
        return false;
    }
}
