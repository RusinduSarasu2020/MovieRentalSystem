package com.cinerent.service;

import com.cinerent.model.Movie;
import com.cinerent.repository.MovieRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class MovieService {
    @Autowired private MovieRepository repo;

    public Movie addMovie(Movie m) { return repo.save(m); }
    public List<Movie> all() { return repo.findAll(); }
    public Optional<Movie> findById(Long id) { return repo.findById(id); }
    public void delete(Long id) { repo.deleteById(id); }
    public Movie update(Movie m) { return repo.save(m); }
    public List<Movie> filter(String q, String genre, String quality, Double minRating, Integer maxDuration) {
        return repo.filter(q, genre, quality, minRating, maxDuration);
    }
}