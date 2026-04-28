package com.example.demo.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.dto.XpResult;
import com.example.demo.entity.Exercise;
import com.example.demo.entity.Trophy;
import com.example.demo.entity.User;
import com.example.demo.entity.UserTrophy;
import com.example.demo.entity.WorkoutPlan;
import com.example.demo.entity.WorkoutTemplate;
import com.example.demo.repository.TrophyRepository;
import com.example.demo.repository.UserRepository;
import com.example.demo.repository.UserTrophyRepository;
import com.example.demo.repository.WorkoutExerciseRepository;
import com.example.demo.repository.WorkoutPlanRepository;
import com.example.demo.repository.WorkoutTemplateRepository;
import com.example.demo.repository.ExerciseRepository;
import com.example.demo.service.WorkoutService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/workouts")
public class WorkoutController {

    @Autowired private WorkoutService workoutService;
    @Autowired private WorkoutPlanRepository planRepo;
    @Autowired private WorkoutExerciseRepository exerciseRepo;
    @Autowired private WorkoutTemplateRepository templateRepo;
    @Autowired private UserRepository userRepository;
    @Autowired private TrophyRepository trophyRepo;
    @Autowired private UserTrophyRepository userTrophyRepo;
    @Autowired private ExerciseRepository exerciseDb;

    @GetMapping("")
    public String showWorkout(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/signin";

        Optional<WorkoutPlan> todayPlan = planRepo.findByUserIdAndPlanDate(user.getId(), LocalDate.now());

        if (todayPlan.isEmpty()) {
            return "redirect:/workouts/templates";
        }

        model.addAttribute("exercises", exerciseRepo.findByPlanIdOrderByOrderIndexAsc(todayPlan.get().getId()));
        model.addAttribute("isFinished", todayPlan.get().getIsFinished());
        return "workouts";
    }

    @GetMapping("/templates")
    public String showTemplates(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/signin";

        List<WorkoutTemplate> templates;
        if (user.getGoal() != null) {
            templates = templateRepo.findTop3ByGoal(user.getGoal());
        } else {
            templates = templateRepo.findAll();
        }

        model.addAttribute("templates", templates);
        return "templates";
    }

    @PostMapping("/generate")
    public String generateFromTemplate(@RequestParam Long templateId, HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/signin";

        workoutService.generatePlanFromTemplate(user.getId(), templateId);
        return "redirect:/workouts";
    }

    @PostMapping("/complete")
    public String finish(HttpSession session, RedirectAttributes redirectAttrs) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/signin";

        XpResult result = workoutService.completeWorkout(user.getId());

        User updatedUser = userRepository.findById(user.getId()).orElse(user);
        session.setAttribute("loggedInUser", updatedUser);

        redirectAttrs.addFlashAttribute("showAnimation", true);
        redirectAttrs.addFlashAttribute("levelUp", result.isLevelUp());

        return "redirect:/home";
    }

    @GetMapping("/trophy")
    public String showTrophies(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/signin";

        List<Trophy> allTrophies = trophyRepo.findAll();

        // 按 requirementType 分组，每组内再按 tier (bronze/silver/gold) 排序
        Map<String, Map<String, List<Trophy>>> grouped = new LinkedHashMap<>();

        for (Trophy t : allTrophies) {
            String type = t.getRequirementType();
            String tier = t.getTier() != null ? t.getTier() : "bronze";
            grouped.computeIfAbsent(type, k -> new LinkedHashMap<>());
            grouped.get(type).computeIfAbsent(tier, k -> new ArrayList<>()).add(t);
        }

        model.addAttribute("trophyGroups", grouped);

        List<UserTrophy> userTrophies = userTrophyRepo.findByUserId(user.getId());
        List<Long> earnedIds = userTrophies.stream()
                                          .map(ut -> ut.getTrophyId())
                                          .toList();
        model.addAttribute("userTrophyIds", earnedIds != null ? earnedIds : new ArrayList<Long>());

        return "trophy";
    }

    @GetMapping("/generate")
    public String showGenerate(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/signin";
        return "generate";
    }

    @PostMapping("/generate-preview")
    public String generatePreview(@RequestParam Long templateId, HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/signin";

        // 根据 templateId 确定部位
        Map<Long, String> templateToMuscle = Map.of(
            1L, "Chest",
            2L, "Back",
            3L, "Shoulders",
            4L, "Legs",
            5L, "Arms",
            6L, "Abs"
        );

        String muscleGroup = templateToMuscle.getOrDefault(templateId, "Chest");
        List<Exercise> exercises = exerciseDb.findByMuscleGroupOrderByName(muscleGroup);

        // 按分类分组
        Map<String, List<Exercise>> byCategory = new LinkedHashMap<>();
        for (Exercise e : exercises) {
            byCategory.computeIfAbsent(e.getCategory(), k -> new ArrayList<>()).add(e);
        }

        // 根据部位确定目标数量和比例
        int[] config = getMuscleConfig(muscleGroup);
        int totalCount = config[0];
        int[] ratios = getCategoryRatios(muscleGroup);

        // 计算每个分类选几个
        List<Exercise> selected = new ArrayList<>();
        int remaining = totalCount;
        int catIdx = 0;
        for (int r : ratios) {
            if (catIdx >= byCategory.size()) break;
            int count = Math.min(r, remaining);
            if (count <= 0) { catIdx++; continue; }
            List<String> keys = new ArrayList<>(byCategory.keySet());
            List<Exercise> catList = byCategory.get(keys.get(catIdx));
            java.util.Collections.shuffle(catList);
            for (int i = 0; i < count && i < catList.size(); i++) {
                selected.add(catList.get(i));
            }
            remaining -= count;
            catIdx++;
        }

        model.addAttribute("muscleGroup", muscleGroup);
        model.addAttribute("exercises", selected);
        model.addAttribute("totalCount", totalCount);
        return "generate";
    }

    private int[] getMuscleConfig(String mg) {
        switch (mg) {
            case "Chest": return new int[]{4, 4, 11};
            case "Abs": return new int[]{5, 3, 11};
            case "Shoulders": return new int[]{6, 3, 11};
            case "Legs": return new int[]{4, 4, 11};
            case "Back": return new int[]{5, 3, 11};
            case "Arms": return new int[]{5, 3, 11};
            default: return new int[]{3, 3, 11};
        }
    }

    private int[] getCategoryRatios(String mg) {
        switch (mg) {
            case "Chest": return new int[]{2, 1, 1};
            case "Abs": return new int[]{2, 2, 1};
            case "Shoulders": return new int[]{1, 2, 2, 1};
            case "Legs": return new int[]{2, 2};
            case "Back": return new int[]{4, 1};
            case "Arms": return new int[]{3, 2};
            default: return new int[]{3};
        }
    }

    @PostMapping("/generate-auto")
    public String generateAuto(@RequestParam List<String> muscleGroups, HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/signin";

        workoutService.generatePlanByMuscleGroups(user.getId(), muscleGroups);
        return "redirect:/workouts";
    }

    @PostMapping("/generate-confirm")
    public String generateConfirm(@RequestParam Long templateId, 
                                  @RequestParam(required = false) List<Long> exerciseIds, // 【新增】接收具体的动作ID
                                  HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/signin";

        
        if (exerciseIds != null && !exerciseIds.isEmpty()) {
            workoutService.generatePlanFromExercises(user.getId(), exerciseIds);
        } else {
            
            Map<Long, String> templateToMuscle = Map.of(
                1L, "Chest", 2L, "Back", 3L, "Shoulders",
                4L, "Legs", 5L, "Arms", 6L, "Abs"
            );
            String mg = templateToMuscle.getOrDefault(templateId, "Chest");
            workoutService.generatePlanByMuscleGroups(user.getId(), List.of(mg));
        }
        
        return "redirect:/workouts";
    }
}
