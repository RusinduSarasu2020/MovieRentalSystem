package com.cinerent.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "payment_type")
@Table(name = "payments")
public abstract class Payment {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    protected Long paymentId;

    protected double amount;
    protected String status = "PENDING";   // SUCCESS / FAILED / PENDING
    protected LocalDateTime createdAt = LocalDateTime.now();

    @ManyToOne protected User user;
    @ManyToOne protected Movie movie;

    public Payment() {}

    // POLYMORPHIC method — overridden in CardPayment
    public abstract boolean processPayment();

    public Long getPaymentId() { return paymentId; } public void setPaymentId(Long p) { this.paymentId = p; }
    public double getAmount() { return amount; } public void setAmount(double a) { this.amount = a; }
    public String getStatus() { return status; } public void setStatus(String s) { this.status = s; }
    public LocalDateTime getCreatedAt() { return createdAt; } public void setCreatedAt(LocalDateTime c) { this.createdAt = c; }
    public User getUser() { return user; } public void setUser(User u) { this.user = u; }
    public Movie getMovie() { return movie; } public void setMovie(Movie m) { this.movie = m; }
}