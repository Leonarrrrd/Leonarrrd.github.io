package com.example.demo.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.entity.User;
import com.example.demo.service.PetService;

import jakarta.servlet.http.HttpSession;

/**
 * Pet Controller - Handles pet-related HTTP requests
 */
@Controller
public class PetController {

    @Autowired
    private PetService petService;

    /**
     * Display pet selection page for new users
     * Redirects to pet page if user already has a pet
     */
    @GetMapping("/pet/choose")
    public String choosePetPage(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/signin";

        // Redirect to pet page if user already has a pet
        if (user.getPetType() != null) {
            return "redirect:/pet";
        }

        model.addAttribute("petTypes", PetService.PET_TYPES);
        return "pet-choose";
    }

    /**
     * Handle pet type selection and initialization
     * Creates a new pet for the user with selected elemental type
     */
    @PostMapping("/pet/choose")
    public String choosePet(@RequestParam String petType, HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/signin";

        // Validate pet type
        boolean validType = false;
        for (String type : PetService.PET_TYPES) {
            if (type.equals(petType)) {
                validType = true;
                break;
            }
        }
        if (!validType) {
            return "redirect:/pet/choose";
        }

        // Initialize pet with selected type
        petService.initPet(user, petType);

        // Update session with pet data
        user.setPetType(petType);
        user.setPetLevel(1);
        user.setPetExp(0);
        user.setPetMood(100);
        user.setPetEnergy(100);
        session.setAttribute("loggedInUser", user);

        return "redirect:/home";
    }

    /**
     * Display main pet page with current pet status
     * Updates mood decay and energy recovery on each visit
     */
    @GetMapping("/pet")
    public String petPage(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/signin";

        // Redirect to pet selection if user doesn't have a pet yet
        if (user.getPetType() == null) {
            return "redirect:/pet/choose";
        }

        // Apply mood decay and energy recovery based on time elapsed
        petService.updateMoodDecay(user);
        petService.recoverEnergy(user);

        // Refresh user data and calculate progress
        User freshUser = user;
        model.addAttribute("user", freshUser);
        model.addAttribute("expProgress", petService.getExpProgress(freshUser));
        model.addAttribute("shouldEvolve", petService.shouldEvolve(freshUser));

        return "pet";
    }

    /**
     * Manual evolution endpoint - triggered when user clicks "Evolve Now" button
     * Only succeeds if level requirements are met
     *
     * @return JSON response with success status and evolution result
     */
    @PostMapping("/pet/evolve")
    @ResponseBody
    public Map<String, Object> evolvePet(HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            return Map.of("success", false, "message", "Not logged in");
        }

        // Pre-check if evolution is possible
        if (!petService.shouldEvolve(user)) {
            return Map.of("success", false, "message", "Cannot evolve yet");
        }

        // Attempt evolution
        int oldStage = user.getPetStage() != null ? user.getPetStage() : 0;
        int result = petService.evolvePet(user);

        if (result == -1) {
            return Map.of("success", false, "message", "Level not enough");
        }
        if (result == -2) {
            return Map.of("success", false, "message", "Already at max stage");
        }

        // Update session with new stage
        user.setPetStage(result);
        session.setAttribute("loggedInUser", user);

        return Map.of("success", true, "oldStage", oldStage, "newStage", result);
    }
}
