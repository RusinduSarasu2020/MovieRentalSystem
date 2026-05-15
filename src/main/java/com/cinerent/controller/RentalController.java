package com.cinerent.controller;

import com.cinerent.model.User;
import com.cinerent.service.RentalService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class RentalController {
    @Autowired private RentalService rentalService;

    @GetMapping("/my-rentals")
    public String myRentals(HttpSession s, Model m) {
        User u = (User) s.getAttribute("user");
        if (u == null) return "redirect:/login";
        m.addAttribute("rentals", rentalService.byUser(u));
        return "myRentals";
    }
}