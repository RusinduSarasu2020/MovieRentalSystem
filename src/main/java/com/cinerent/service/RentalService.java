package com.cinerent.service;

import com.cinerent.model.*;
import com.cinerent.repository.RentalRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDate;
import java.util.List;

@Service
public class RentalService {
    @Autowired private RentalRepository repo;
    @Autowired private MovieService movieService;

    public Rental rentMovie(User u, Movie m) {
        m.setAvailable(false);
        movieService.update(m);
        return repo.save(new Rental(u, m));
    }
    public Rental returnMovie(Long rentalId) {
        Rental r = repo.findById(rentalId).orElseThrow();
        r.setReturnDate(LocalDate.now());
        r.setStatus("RETURNED");
        r.calculateLateFee();
        Movie m = r.getMovie();
        m.setAvailable(true);
        movieService.update(m);
        return repo.save(r);
    }
    public List<Rental> all() { return repo.findAll(); }
    public List<Rental> byUser(User u) { return repo.findByUser(u); }
    public long activeCount() { return repo.findByStatus("ACTIVE").size(); }
    public long returnedCount() { return repo.findByStatus("RETURNED").size(); }
}