package com.cinerent.controller;

import com.cinerent.model.User;
import com.cinerent.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class AuthController {
    @Autowired private UserService userService;

    @GetMapping("/login") public String loginPage() { return "login"; }
    @GetMapping("/signup") public String signupPage() { return "signup"; }
    @GetMapping("/admin/login") public String adminLoginPage() { return "adminLogin"; }

    @PostMapping("/signup")
    public String signup(@RequestParam String username, @RequestParam String email,
                         @RequestParam String phone, @RequestParam String password,
                         @RequestParam String password2, Model model) {
        if (!password.equals(password2)) { model.addAttribute("error","Passwords don't match"); return "signup"; }
        if (userService.existsByUsername(username)) { model.addAttribute("error","Username taken"); return "signup"; }
        if (userService.existsByEmail(email)) { model.addAttribute("error","Email already in use"); return "signup"; }
        userService.register(new User(username, email, phone, password));
        return "redirect:/login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username, @RequestParam String password,
                        HttpSession session, Model model) {
        return userService.login(username, password).map(u -> {
            session.setAttribute("user", u);
            return "ADMIN".equals(u.getRole()) ? "redirect:/admin/dashboard" : "redirect:/home";
        }).orElseGet(() -> { model.addAttribute("error","Invalid credentials"); return "login"; });
    }

    @PostMapping("/admin/login")
    public String adminLogin(@RequestParam String username, @RequestParam String password,
                             HttpSession session, Model model) {
        return userService.login(username, password)
                .filter(u -> "ADMIN".equals(u.getRole()))
                .map(u -> { session.setAttribute("user", u); return "redirect:/admin/dashboard"; })
                .orElseGet(() -> { model.addAttribute("error","Invalid admin credentials"); return "adminLogin"; });
    }

    @GetMapping("/logout")
    public String logout(HttpSession s) { s.invalidate(); return "redirect:/"; }
}
