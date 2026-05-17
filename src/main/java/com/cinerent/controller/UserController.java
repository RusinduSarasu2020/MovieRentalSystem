package com.cinerent.controller;

import com.cinerent.model.Movie;
import com.cinerent.model.User;
import com.cinerent.service.MovieService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Collections;
import java.util.List;
import com.cinerent.service.UserService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.bind.annotation.RequestHeader;

@Controller
public class UserController {
    @Autowired private MovieService movieService;
    @Autowired private UserService userService;

    @GetMapping("/home")
    public String home(@RequestParam(required=false) String q,
                       @RequestParam(required=false) String genre,
                       @RequestParam(required=false) String quality,
                       @RequestParam(required=false) Double minRating,
                       @RequestParam(required=false) Integer maxDuration,
                       HttpSession session, Model model) {
        if (session.getAttribute("user") == null) return "redirect:/login";
        model.addAttribute("movies", movieService.filter(q, genre, quality, minRating, maxDuration));
        model.addAttribute("user", session.getAttribute("user"));
        return "home";
    }

    @GetMapping("/new-releases")
    public String newReleases(HttpSession session, Model model) {
        if (session.getAttribute("user") == null) return "redirect:/login";
        List<Movie> movies = movieService.all();
        Collections.reverse(movies);
        model.addAttribute("movies", movies);
        model.addAttribute("user", session.getAttribute("user"));
        return "home";
    }

    @PostMapping("/user/update")
    public String updateUser(@RequestParam String username,
                             @RequestParam String email,
                             @RequestParam(required = false) String password,
                             @RequestHeader(value = "Referer", required = false) String referer,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser == null) return "redirect:/login";

        User u = userService.findById(sessionUser.getId()).orElse(null);
        if (u != null) {
            u.setUsername(username);
            u.setEmail(email);
            if (password != null && !password.trim().isEmpty()) {
                u.setPassword(password);
            }
            userService.register(u);
            session.setAttribute("user", u);
            redirectAttributes.addFlashAttribute("successMessage", "update successfully");
        }
        return "redirect:" + (referer != null ? referer : "/home");
    }
}
