package com.cinerent.repository;

import com.cinerent.model.Review;
import com.cinerent.model.Movie;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ReviewRepository extends JpaRepository<Review, Long> {
    List<Review> findByMovie(Movie movie);
}