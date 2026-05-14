package com.cinerent.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "rentals")
public class Rental {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne private User user;
    @ManyToOne private Movie movie;

    private LocalDate rentalDate;
    private LocalDate dueDate;
    private LocalDate returnDate;
    private String status = "ACTIVE";  // ACTIVE / RETURNED
    private double lateFee = 0.0;

    public Rental() {}
    public Rental(User u, Movie m) {
        this.user = u; this.movie = m;
        this.rentalDate = LocalDate.now();
        this.dueDate = rentalDate.plusDays(7);
    }

    // getters / setters
    public Long getId() { return id; } public void setId(Long id) { this.id = id; }
    public User getUser() { return user; } public void setUser(User u) { this.user = u; }
    public Movie getMovie() { return movie; } public void setMovie(Movie m) { this.movie = m; }
    public LocalDate getRentalDate() { return rentalDate; } public void setRentalDate(LocalDate d) { this.rentalDate = d; }
    public LocalDate getDueDate() { return dueDate; } public void setDueDate(LocalDate d) { this.dueDate = d; }
    public LocalDate getReturnDate() { return returnDate; } public void setReturnDate(LocalDate d) { this.returnDate = d; }
    public String getStatus() { return status; } public void setStatus(String s) { this.status = s; }
    public double getLateFee() { return lateFee; } public void setLateFee(double f) { this.lateFee = f; }

    public double calculateLateFee() {
        if (returnDate != null && returnDate.isAfter(dueDate)) {
            long days = java.time.temporal.ChronoUnit.DAYS.between(dueDate, returnDate);
            this.lateFee = days * 50.0;   // Rs 50/day
        }
        return lateFee;
    }
}