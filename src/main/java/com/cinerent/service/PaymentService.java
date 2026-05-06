package com.cinerent.service;

import com.cinerent.model.Payment;
import com.cinerent.repository.PaymentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class PaymentService {
    @Autowired private PaymentRepository repo;

    // Polymorphism — accepts ANY Payment subclass
    public Payment process(Payment p) {
        p.processPayment();
        return repo.save(p);
    }
    public List<Payment> all() { return repo.findAll(); }
    public double totalRevenue() {
        return repo.findAll().stream()
                .filter(p -> "SUCCESS".equals(p.getStatus()))
                .mapToDouble(Payment::getAmount).sum();
    }
}