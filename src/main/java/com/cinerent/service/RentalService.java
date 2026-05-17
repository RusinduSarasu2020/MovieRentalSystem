package com.cinerent.service;

import com.cinerent.model.Movie;
import com.cinerent.model.Rental;
import com.cinerent.model.User;
import com.cinerent.repository.RentalRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class RentalService {

    @Autowired
    private RentalRepository repo;

    @Autowired
    private MovieService movieService;

    public Rental rentMovie(User user, Movie movie) {
        movie.setAvailable(false);
        movieService.update(movie);

        return repo.save(new Rental(user, movie));
    }

    public Rental returnMovie(Long rentalId) {
        Rental rental = repo.findById(rentalId).orElseThrow();

        rental.setReturnDate(LocalDate.now());
        rental.setStatus("RETURNED");
        rental.calculateLateFee();

        Movie movie = rental.getMovie();
        movie.setAvailable(true);
        movieService.update(movie);

        return repo.save(rental);
    }

    public List<Rental> all() {
        return repo.findAll();
    }

    public List<Rental> byUser(User user) {
        return repo.findByUser(user);
    }

    public long activeCount() {
        return repo.findByStatus("ACTIVE").size();
    }

    public long returnedCount() {
        return repo.findByStatus("RETURNED").size();
    }
}
