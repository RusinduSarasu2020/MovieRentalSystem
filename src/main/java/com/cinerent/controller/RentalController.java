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

    @Autowired
    private RentalService rentalService;

    // Connects the Spring web app to the "/my-rentals" URL in the browser.
    @GetMapping("/my-rentals")
    public String myRentals(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        }

        model.addAttribute("rentals", rentalService.byUser(user));
        return "myRentals";
    }
}
