package com.example.demo.controller;

import com.example.demo.dto.FoodDto;
import com.example.demo.entity.User;
import com.example.demo.service.DietService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;
import java.util.Map;

@Controller
public class DietController {

    @Autowired
    private DietService dietService;

    @GetMapping("/diet")
    public String showDietPage(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/signin";
        }

        String target = dietService.determineTarget(user);
        Map<String, List<FoodDto>> meals = dietService.generateDailyMeals(target);

        model.addAttribute("meals", meals);
        model.addAttribute("target", target.equals("bulk") ? "Muscle Gain" : "Fat Loss");
        return "diet";
    }
}