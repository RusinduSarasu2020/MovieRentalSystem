package com.cinerent.controller;

import com.cinerent.model.*;
import com.cinerent.service.MovieService;
import com.cinerent.service.ReviewService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
public class ReviewController {
    @Autowired private ReviewService reviewService;
    @Autowired private MovieService movieService;

    @PostMapping("/review/{movieId}")
    public String addReview(@PathVariable Long movieId, @RequestParam int rating,
                            @RequestParam String comment, HttpSession s) {
        User u = (User) s.getAttribute("user");
        if (u == null) return "redirect:/login";
        Movie m = movieService.findById(movieId).orElseThrow();
        Review r = new Review();
        r.setUser(u); r.setMovie(m); r.setRating(rating); r.setComment(comment);
        reviewService.add(r);
        return "redirect:/movie/" + movieId;
    }
}