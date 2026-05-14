package com.cinerent.service;

import com.cinerent.model.Movie;
import com.cinerent.model.Review;
import com.cinerent.repository.ReviewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ReviewService {
    @Autowired private ReviewRepository repo;

    public Review add(Review r) { return repo.save(r); }
    public List<Review> all() { return repo.findAll(); }
    public List<Review> forMovie(Movie m) { return repo.findByMovie(m); }
    public void delete(Long id) { repo.deleteById(id); }
}