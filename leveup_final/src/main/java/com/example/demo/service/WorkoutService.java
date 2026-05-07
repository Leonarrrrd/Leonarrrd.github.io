package com.example.demo.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.dto.XpResult;
import com.example.demo.entity.Exercise;
import com.example.demo.entity.TemplateExercise;
import com.example.demo.entity.User;
import com.example.demo.entity.WorkoutExercise;
import com.example.demo.entity.WorkoutPlan;
import com.example.demo.repository.ExerciseRepository;
import com.example.demo.repository.TemplateExerciseRepository;
import com.example.demo.repository.UserRepository;
import com.example.demo.repository.WorkoutExerciseRepository;
import com.example.demo.repository.WorkoutPlanRepository;

@Service
public class WorkoutService {
    @Autowired private WorkoutPlanRepository planRepo;
    @Autowired private WorkoutExerciseRepository exerciseRepo;
    @Autowired private UserRepository userRepo;
    @Autowired private TemplateExerciseRepository templateExerciseRepo;
    @Autowired private AchievementService achievementService;
    @Autowired private ExerciseRepository exerciseDb;
    @Autowired private PetService petService;

    

    public List<WorkoutExercise> getExercisesForToday(Long userId) {
    LocalDate today = LocalDate.now();
    
    
    WorkoutPlan plan = planRepo.findByUserIdAndPlanDate(userId, today)
            .orElseGet(() -> {
                
                WorkoutPlan newPlan = new WorkoutPlan();
                newPlan.setUserId(userId);
                newPlan.setPlanDate(today);
                newPlan.setIsFinished(false);
                return planRepo.save(newPlan); // 保存并返回新计划
            });
    
    
    List<WorkoutExercise> exercises = exerciseRepo.findByPlanIdOrderByOrderIndexAsc(plan.getId());
    
    
    if (exercises.isEmpty()) {
       
    }
    
    return exercises;
}

    @Transactional
    public void generatePlanFromTemplate(Long userId, Long templateId) {
        LocalDate today = LocalDate.now();
    
    
    planRepo.findByUserIdAndPlanDate(userId, today).ifPresent(p -> {
        

        planRepo.delete(p);
    });
        
        WorkoutPlan newPlan = new WorkoutPlan();
        newPlan.setUserId(userId);
        newPlan.setPlanDate(LocalDate.now());
        newPlan.setIsFinished(false);
        WorkoutPlan savedPlan = planRepo.save(newPlan);

        
        List<TemplateExercise> templates = templateExerciseRepo.findByTemplateIdOrderByOrderIndexAsc(templateId);
        
        for (TemplateExercise te : templates) {
            WorkoutExercise we = new WorkoutExercise();
            we.setPlanId(savedPlan.getId());
            we.setExerciseName(te.getExerciseName());
            we.setSets(te.getSets());
            we.setReps(te.getReps());
            we.setWeightKg(te.getWeightKg());
            we.setOrderIndex(te.getOrderIndex());
            exerciseRepo.save(we);
        }
    }


@Transactional
public XpResult completeWorkout(Long userId) {
    
    WorkoutPlan plan = planRepo.findByUserIdAndPlanDate(userId, LocalDate.now())
            .orElseThrow(() -> new RuntimeException("No plan found"));
    plan.setIsFinished(true);
    planRepo.save(plan);
    
    
    User user = userRepo.findById(userId).orElseThrow();
    
    
    int currentXp = (user.getXp() == null) ? 0 : user.getXp();
    int currentStreak = (user.getStreakDays() == null) ? 0 : user.getStreakDays();
    
    int oldLevel = (currentXp / 100) + 1;
    int addedXp = 20;
    int newXp = currentXp + addedXp;
    int newLevel = (newXp / 100) + 1;
    
    user.setXp(newXp);
    user.setStreakDays(currentStreak + 1);
    userRepo.save(user);

    
    achievementService.checkAndGrant(user, LocalDateTime.now());

    // 🐾 更新宠物状态
    if (user.getPetType() != null) {
        petService.onWorkoutComplete(user);
    }

    
    XpResult result = new XpResult();
    result.setOldLevel(oldLevel);
    result.setNewLevel(newLevel);
    result.setAddedXp(addedXp);
    result.setLevelUp(newLevel > oldLevel);
    return result;
}

    @Transactional
    public void generatePlanFromExercises(Long userId, List<Long> exerciseIds) {
        LocalDate today = LocalDate.now();

        planRepo.findByUserIdAndPlanDate(userId, today).ifPresent(p -> planRepo.delete(p));

        WorkoutPlan newPlan = new WorkoutPlan();
        newPlan.setUserId(userId);
        newPlan.setPlanDate(today);
        newPlan.setIsFinished(false);
        WorkoutPlan savedPlan = planRepo.save(newPlan);

        Map<String, int[]> config = Map.of(
            "Chest",     new int[]{4, 4},
            "Abs",       new int[]{3, 3},
            "Shoulders", new int[]{3, 3},
            "Legs",      new int[]{4, 4},
            "Back",      new int[]{3, 3}
        );

        int orderIndex = 0;
        for (Long id : exerciseIds) {
            Exercise ex = exerciseDb.findById(id).orElse(null);
            if (ex == null) continue;

            int[] sr = config.getOrDefault(ex.getMuscleGroup(), new int[]{3, 3});
            WorkoutExercise we = new WorkoutExercise();
            we.setPlanId(savedPlan.getId());
            we.setExerciseName(ex.getName());
            we.setSets(sr[0]);
            we.setReps(sr[1]);
            we.setWeightKg(0f);
            we.setOrderIndex(orderIndex++);
            exerciseRepo.save(we);
        }
    }

    @Transactional
    public void generatePlanByMuscleGroups(Long userId, List<String> muscleGroups) {
        LocalDate today = LocalDate.now();

        planRepo.findByUserIdAndPlanDate(userId, today).ifPresent(p -> planRepo.delete(p));

        WorkoutPlan newPlan = new WorkoutPlan();
        newPlan.setUserId(userId);
        newPlan.setPlanDate(today);
        newPlan.setIsFinished(false);
        WorkoutPlan savedPlan = planRepo.save(newPlan);

        
        Map<String, int[]> muscleConfig = Map.of(
            "Chest",     new int[]{4, 4, 11},
            "Abs",       new int[]{5, 3, 11},
            "Shoulders", new int[]{6, 3, 11},
            "Legs",      new int[]{4, 4, 11},
            "Back",      new int[]{5, 3, 11}
        );

        
        Map<String, int[]> categoryRatios = Map.of(
            "Chest",     new int[]{2, 1, 1},
            "Abs",       new int[]{2, 2, 1},
            "Shoulders", new int[]{1, 2, 2, 1},
            "Legs",      new int[]{1, 1},
            "Back",      new int[]{4, 1}
        );

        int orderIndex = 0;
        for (String mg : muscleGroups) {
            int[] cfg = muscleConfig.getOrDefault(mg, new int[]{3, 3, 3});
            int totalCount = cfg[0], sets = cfg[1], reps = cfg[2];
            int[] ratios = categoryRatios.getOrDefault(mg, new int[]{totalCount});

            
            List<Exercise> allEx = exerciseDb.findByMuscleGroupOrderByName(mg);
            java.util.Map<String, java.util.List<Exercise>> byCategory = new java.util.LinkedHashMap<>();
            for (Exercise e : allEx) {
                byCategory.computeIfAbsent(e.getCategory(), k -> new java.util.ArrayList<>()).add(e);
            }

            
            java.util.List<String> cats = new java.util.ArrayList<>(byCategory.keySet());
            int remaining = totalCount;
            int catIdx = 0;
            for (int r : ratios) {
                if (catIdx >= cats.size()) break;
                int count = Math.min(r, remaining);
                if (count <= 0) { catIdx++; continue; }

                java.util.List<Exercise> catList = byCategory.get(cats.get(catIdx));
               
                java.util.Collections.shuffle(catList);
                for (int i = 0; i < count && i < catList.size(); i++) {
                    Exercise ex = catList.get(i);
                    WorkoutExercise we = new WorkoutExercise();
                    we.setPlanId(savedPlan.getId());
                    we.setExerciseName(ex.getName());
                    we.setSets(sets);
                    we.setReps(reps);
                    we.setWeightKg(0f);
                    we.setOrderIndex(orderIndex++);
                    exerciseRepo.save(we);
                }
                remaining -= count;
                catIdx++;
            }
        }
    }
}