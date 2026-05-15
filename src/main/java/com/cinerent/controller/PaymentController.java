package com.cinerent.controller;

import com.cinerent.model.*;
import com.cinerent.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class PaymentController {
    @Autowired private MovieService movieService;
    @Autowired private PaymentService paymentService;
    @Autowired private RentalService rentalService;

    @GetMapping("/payment/{movieId}")
    public String form(@PathVariable Long movieId, HttpSession s, Model m) {
        if (s.getAttribute("user") == null) return "redirect:/login";
        m.addAttribute("movie", movieService.findById(movieId).orElseThrow());
        return "payment";
    }

    @PostMapping("/payment/{movieId}")
    public String pay(@PathVariable Long movieId,
                      @RequestParam String cardNumber, @RequestParam String cardHolderName,
                      @RequestParam String expiryDate, @RequestParam String cvv,
                      HttpSession s, Model m) {
        User user = (User) s.getAttribute("user");
        if (user == null) return "redirect:/login";
        Movie movie = movieService.findById(movieId).orElseThrow();

        CardPayment cp = new CardPayment();
        cp.setUser(user); cp.setMovie(movie);
        cp.setAmount(movie.getPrice());
        cp.setCardNumber(cardNumber); cp.setCardHolderName(cardHolderName);
        cp.setExpiryDate(expiryDate); cp.setCvv(cvv);

        Payment saved = paymentService.process(cp);
        if ("SUCCESS".equals(saved.getStatus())) {
            rentalService.rentMovie(user, movie);
            m.addAttribute("payment", saved);
            m.addAttribute("movie", movie);
            return "paymentSuccess";
        }
        m.addAttribute("movie", movie);
        m.addAttribute("error","Card validation failed. Check card number (16 digits), CVV (3 digits), expiry MM/YY.");
        return "paymentFail";
    }

    @GetMapping("/watch/{movieId}")
    public String watch(@PathVariable Long movieId, HttpSession s, Model m) {
        if (s.getAttribute("user") == null) return "redirect:/login";
        m.addAttribute("movie", movieService.findById(movieId).orElseThrow());
        return "watch";
    }
}