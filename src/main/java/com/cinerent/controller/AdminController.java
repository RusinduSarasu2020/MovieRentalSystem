package com.cinerent.controller;

import com.cinerent.model.User;
import com.cinerent.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired private MovieService movieService;
    @Autowired private UserService userService;
    @Autowired private RentalService rentalService;
    @Autowired private PaymentService paymentService;
    @Autowired private ReviewService reviewService;

    private boolean notAdmin(HttpSession s) {
        User u = (User) s.getAttribute("user");
        return u == null || !"ADMIN".equals(u.getRole());
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession s, Model m) {
        if (notAdmin(s)) return "redirect:/admin/login";
        m.addAttribute("totalMovies", movieService.all().size());
        m.addAttribute("totalUsers", userService.all().size());
        m.addAttribute("activeRentals", rentalService.activeCount());
        m.addAttribute("returnedRentals", rentalService.returnedCount());
        m.addAttribute("totalRevenue", paymentService.totalRevenue());
        return "admin/dashboard";
    }

    @GetMapping("/users")
    public String users(@RequestParam(required=false) String q, HttpSession s, Model m) {
        if (notAdmin(s)) return "redirect:/admin/login";
        m.addAttribute("users", q == null ? userService.all() : userService.search(q));
        return "admin/manageUsers";
    }
    @PostMapping("/users/{id}/toggle") public String toggle(@PathVariable Long id) { userService.toggleBlock(id); return "redirect:/admin/users"; }
    @PostMapping("/users/{id}/delete") public String delUser(@PathVariable Long id) { userService.delete(id); return "redirect:/admin/users"; }

    @GetMapping("/rentals")
    public String rentals(HttpSession s, Model m) {
        if (notAdmin(s)) return "redirect:/admin/login";
        m.addAttribute("rentals", rentalService.all());
        return "admin/manageRentals";
    }
    @PostMapping("/rentals/{id}/return") public String ret(@PathVariable Long id) { rentalService.returnMovie(id); return "redirect:/admin/rentals"; }

    @GetMapping("/payments")
    public String payments(HttpSession s, Model m) {
        if (notAdmin(s)) return "redirect:/admin/login";
        m.addAttribute("payments", paymentService.all());
        return "admin/managePayments";
    }

    @GetMapping("/reviews")
    public String reviews(HttpSession s, Model m) {
        if (notAdmin(s)) return "redirect:/admin/login";
        m.addAttribute("reviews", reviewService.all());
        return "admin/manageReviews";
    }
    @PostMapping("/reviews/{id}/delete") public String delRev(@PathVariable Long id) { reviewService.delete(id); return "redirect:/admin/reviews"; }

    @GetMapping("/reports")
    public String reports(HttpSession s, Model m) {
        if (notAdmin(s)) return "redirect:/admin/login";
        m.addAttribute("revenue", paymentService.totalRevenue());
        m.addAttribute("movies", movieService.all());
        m.addAttribute("users", userService.all());
        return "admin/reports";
    }

    @GetMapping("/settings")
    public String settings(HttpSession s) { return notAdmin(s) ? "redirect:/admin/login" : "admin/settings"; }
}