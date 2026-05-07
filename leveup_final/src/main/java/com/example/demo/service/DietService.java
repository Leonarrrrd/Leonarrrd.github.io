package com.example.demo.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Random;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dto.FoodDto;
import com.example.demo.entity.Food;
import com.example.demo.entity.User;
import com.example.demo.repository.FoodRepository;

@Service
public class DietService {

    @Autowired
    private FoodRepository foodRepository;

    public String determineTarget(User user) {
        float heightM = user.getHeight() / 100f;
        float bmi = user.getWeight() / (heightM * heightM);
        if (bmi > 24) {
            return "cut";
        } else {
            return "bulk";
        }
    }

    public Map<String, List<FoodDto>> generateDailyMeals(String target) {
        List<String> targets = Arrays.asList(target, "both");

        List<Food> breakfast = new ArrayList<>();
        breakfast.add(getRandomFoodByCategoryAndTarget("protein", targets));
        breakfast.add(getRandomFoodByCategoryAndTarget("carb", targets));
        breakfast.add(getRandomFoodByCategoryAndTarget("fruit", targets));
        breakfast.removeIf(Objects::isNull);

        List<Food> lunch = new ArrayList<>();
        lunch.add(getRandomFoodByCategoryAndTarget("protein", targets));
        lunch.add(getRandomFoodByCategoryAndTarget("carb", targets));
        lunch.add(getRandomFoodByCategoryAndTarget("vegetable", targets));
        lunch.removeIf(Objects::isNull);

        List<Food> dinner = new ArrayList<>();
        dinner.add(getRandomFoodByCategoryAndTarget("protein", targets));
        dinner.add(getRandomFoodByCategoryAndTarget("vegetable", targets));
        dinner.add(getRandomFoodByCategoryAndTarget("fat", targets));
        dinner.removeIf(Objects::isNull);

        Map<String, List<FoodDto>> meals = new LinkedHashMap<>();
        meals.put("breakfast", toDtoList(breakfast));
        meals.put("lunch", toDtoList(lunch));
        meals.put("dinner", toDtoList(dinner));
        return meals;
    }

    private Food getRandomFoodByCategoryAndTarget(String category, List<String> targets) {
        List<Food> foods = foodRepository.findByCategoryAndTargetIn(category, targets);
        if (foods.isEmpty()) return null;
        Random rand = new Random();
        return foods.get(rand.nextInt(foods.size()));
    }

    private List<FoodDto> toDtoList(List<Food> foods) {
        return foods.stream()
                .map(f -> new FoodDto(f.getName(), f.getCalories(), f.getProtein(), f.getCarbs(), f.getFat(), f.getServingSize()))
                .collect(Collectors.toCollection(ArrayList::new));
    }
}