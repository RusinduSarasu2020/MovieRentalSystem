package com.cinerent.controller;

import com.cinerent.model.Movie;
import com.cinerent.model.User;
import com.cinerent.service.MovieService;
import com.cinerent.service.ReviewService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class MovieController {
    @Autowired private MovieService movieService;
    @Autowired private ReviewService reviewService;

    @GetMapping("/admin/movies")
    public String list(HttpSession s, Model m) {
        User u = (User) s.getAttribute("user");
        if (u == null || !"ADMIN".equals(u.getRole())) return "redirect:/admin/login";
        m.addAttribute("movies", movieService.all());
        return "admin/manageMovies";
    }

    @PostMapping("/admin/movies/add")
    public String add(@ModelAttribute Movie movie) { movieService.addMovie(movie); return "redirect:/admin/movies"; }

    @PostMapping("/admin/movies/{id}/delete")
    public String delete(@PathVariable Long id) { movieService.delete(id); return "redirect:/admin/movies"; }

    @PostMapping("/admin/movies/{id}/edit")
    public String edit(@PathVariable Long id, @ModelAttribute Movie movie) {
        movie.setId(id); movieService.update(movie); return "redirect:/admin/movies";
    }

    @GetMapping("/movie/{id}")
    public String details(@PathVariable Long id, HttpSession s, Model m) {
        if (s.getAttribute("user") == null) return "redirect:/login";
        Movie movie = movieService.findById(id).orElseThrow();
        m.addAttribute("movie", movie);
        m.addAttribute("reviews", reviewService.forMovie(movie));
        return "movieDetails";
    }
}