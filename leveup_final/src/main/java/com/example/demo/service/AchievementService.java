package com.example.demo.service;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.TemporalAdjusters;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.entity.Trophy;
import com.example.demo.entity.User;
import com.example.demo.entity.UserTrophy;
import com.example.demo.repository.TrophyRepository;
import com.example.demo.repository.UserTrophyRepository;
import com.example.demo.repository.WorkoutPlanRepository;

@Service
public class AchievementService {
    @Autowired
    private TrophyRepository trophyRepo;
    @Autowired
    private UserTrophyRepository userTrophyRepo;
    @Autowired
    private WorkoutPlanRepository planRepo;

    @Transactional
    public void checkAndGrant(User user, LocalDateTime workoutTime) {
        List<Trophy> allTrophies = trophyRepo.findAll();
        Long userId = user.getId();

        for (Trophy t : allTrophies) {
            if (userTrophyRepo.existsByUserIdAndTrophyId(userId, t.getId())) continue;

            boolean earned = false;
            switch (t.getRequirementType()) {
                case "STREAK_DAYS":
                    earned = (user.getStreakDays() != null && user.getStreakDays() >= t.getRequirementValue());
                    break;
                case "TOTAL_XP":
                    earned = (user.getXp() != null && user.getXp() >= t.getRequirementValue());
                    break;
                case "WORKOUT_COUNT":
                    long count = planRepo.countByUserIdAndIsFinished(userId, true);
                    earned = (count >= t.getRequirementValue());
                    break;
                case "MORNING_WORKOUT":
                    earned = workoutTime.getHour() < 8;
                    break;
                case "WEEKLY_FREQUENCY":
                    LocalDate today = workoutTime.toLocalDate();
                    LocalDate startOfWeek = today.with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY));
                    LocalDate endOfWeek = today.with(TemporalAdjusters.nextOrSame(DayOfWeek.SUNDAY));
                    long weeklyCount = planRepo.countByUserIdAndIsFinishedAndPlanDateBetween(userId, true, startOfWeek, endOfWeek);
                    earned = weeklyCount >= t.getRequirementValue();
                    break;
            }

            if (earned) {
                UserTrophy ut = new UserTrophy();
                ut.setUserId(userId);
                ut.setTrophyId(t.getId());
                ut.setEarnedAt(LocalDateTime.now());
                userTrophyRepo.save(ut);
            }
        }
    }
}