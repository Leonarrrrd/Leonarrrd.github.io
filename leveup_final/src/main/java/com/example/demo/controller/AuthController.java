package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.entity.User;
import com.example.demo.repository.UserRepository;
import com.example.demo.service.UserService;
import com.example.demo.service.WeightLogService;

import java.time.LocalDate;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class AuthController {

    @Autowired private UserService userService;
    @Autowired private UserRepository userRepository;
    @Autowired private WeightLogService weightLogService;

    // 页面跳转
    @GetMapping("/")
    public String welcomePage() { return "welcome"; }

    @GetMapping("/signup")
    public String signupPage() { return "signup"; }

    @GetMapping("/signin")
    public String signinPage() { return "signin"; }

    @GetMapping("/explore")
    public String explorePage() { return "explore"; }

    @GetMapping("/person")
    public String personPage(HttpSession session, Model model,
                            @RequestParam(required = false) Integer year,
                            @RequestParam(required = false) Integer month) {
        User sessionUser = (User) session.getAttribute("loggedInUser");
        if (sessionUser == null) return "redirect:/signin";
        User freshUser = userRepository.findById(sessionUser.getId()).get();
        model.addAttribute("user", freshUser);

        LocalDate today = LocalDate.now();
        int viewYear = (year != null) ? year : today.getYear();
        int viewMonth = (month != null) ? month : today.getMonthValue();
        model.addAttribute("viewYear", viewYear);
        model.addAttribute("viewMonth", viewMonth);
        model.addAttribute("todayYear", today.getYear());
        model.addAttribute("todayMonth", today.getMonthValue());
        model.addAttribute("todayDay", today.getDayOfMonth());

        // 传入该用户所有体重记录（前端按月份过滤，保证跨月也能算差值）
        var allWeightLogs = weightLogService.getAllWeightLogs(freshUser.getId());
        model.addAttribute("weightLogs", allWeightLogs);
        return "person";
    }

    @PostMapping("/save-weight")
    public String saveWeight(@RequestParam Float weight,
                             @RequestParam String date,
                             HttpSession session) {
        User sessionUser = (User) session.getAttribute("loggedInUser");
        if (sessionUser == null) return "redirect:/signin";
        weightLogService.saveWeight(sessionUser.getId(), LocalDate.parse(date), weight);
        return "redirect:/person";
    }

    // 跳转到 goal 选择页面
    @GetMapping("/goal")
    public String goalPage(HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/signin";
        }
        return "goal";
    }

    // 保存 goal 后跳转频率选择页面
    @PostMapping("/register-goal")
    public String registerGoal(@RequestParam String goal,
                              HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        user.setGoal(goal);
        userRepository.save(user);
        return "redirect:/frequency";
    }

    // 跳转到频率选择页面
    @GetMapping("/frequency")
    public String frequencyPage(HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/signin";
        }
        return "frequency";
    }

    // 保存频率后跳转主页
    @PostMapping("/register-frequency")
    public String registerFrequency(@RequestParam Double trainingFrequency,
                                    HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");

        // 计算 BMR
        double bmr;
        if ("man".equals(user.getGender())) {
            bmr = (10 * user.getWeight()) + (6.25 * user.getHeight())
                  - (5 * user.getAge()) + 5;
        } else {
            bmr = (10 * user.getWeight()) + (6.25 * user.getHeight())
                  - (5 * user.getAge()) - 161;
        }

        // 计算 TDEE = BMR × 活动系数
        int tdee = (int)(bmr * trainingFrequency);

        user.setTrainingFrequency(trainingFrequency);
        user.setTdee(tdee);
        userRepository.save(user);
        return "redirect:/pet/choose";
    }

    // 检查邮箱是否已被注册（AJAX调用）
    @GetMapping("/check-email")
    @ResponseBody
    public String checkEmail(@RequestParam String email) {
        if (userRepository.findByEmail(email).isPresent()) {
            return "exists";
        }
        return "ok";
    }

    @GetMapping("/home")
public String homepage(HttpSession session, Model model) {
    User sessionUser = (User) session.getAttribute("loggedInUser");
    if (sessionUser == null) return "redirect:/signin";
    
    // 每次进入首页，都强制从数据库刷一遍最新数据，保证显示准确
    User freshUser = userRepository.findById(sessionUser.getId()).get();
    model.addAttribute("user", freshUser);
    
    return "homepage";
}
    


    // 注册处理（完整版）
    @PostMapping("/register")
    public String processRegister(@Valid User user, BindingResult result,
                                  @RequestParam String confirmPassword,
                                  Model model, HttpSession session) {
        // 1. 基础格式校验
        if (result.hasErrors()) {
            model.addAttribute("error", result.getFieldError().getDefaultMessage());
            model.addAttribute("user", user);
            return "signup";
        }

        // 2. 确认密码一致性
        if (!user.getPassword().equals(confirmPassword)) {
            model.addAttribute("error", "Passwords do not match");
            model.addAttribute("user", user);
            return "signup";
        }

        // 3. 调用 Service 注册（包含邮箱唯一性检查和密码加密）
        try {
            userService.registerUser(user);
            // 4. 注册成功后从数据库重新查询用户（获取自动生成的ID等）
            User savedUser = userRepository.findByEmail(user.getEmail())
                    .orElseThrow(() -> new Exception("User not found after registration"));
            // 5. 把注册时的体重写入体重日志
            weightLogService.saveWeight(savedUser.getId(), LocalDate.now(), savedUser.getWeight());
            // 6. 存入 session
            session.setAttribute("loggedInUser", savedUser);
            return "redirect:/goal";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("user", user);
            return "signup";
        }
    }

    // 登录处理
    @PostMapping("/signin")
    public String handleLogin(@RequestParam String email,
                              @RequestParam String password,
                              HttpSession session,
                              Model model) {
        User user = userService.authenticate(email, password);
        if (user != null) {
            session.setAttribute("loggedInUser", user);
            return "redirect:/home";
        } else {
            model.addAttribute("error", "Invalid email or password");
            return "signin";
        }
    }

    // 退出登录
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/signin";
    }
}