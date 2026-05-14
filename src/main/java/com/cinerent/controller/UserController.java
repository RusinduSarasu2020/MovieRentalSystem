package com.cinerent.controller;

import com.cinerent.model.User;
import com.cinerent.service.MovieService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class UserController {
    @Autowired private MovieService movieService;

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
}