package com.cinerent.repository;

import com.cinerent.model.Rental;
import com.cinerent.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RentalRepository extends JpaRepository<Rental, Long> {

    List<Rental> findByUser(User user);

    List<Rental> findByStatus(String status);
}
