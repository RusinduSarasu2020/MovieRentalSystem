package com.cinerent.repository;

import com.cinerent.model.Movie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;

public interface MovieRepository extends JpaRepository<Movie, Long> {
    List<Movie> findByTitleContainingIgnoreCase(String title);

    @Query("SELECT m FROM Movie m WHERE " +
            "(:q IS NULL OR LOWER(m.title) LIKE LOWER(CONCAT('%',:q,'%'))) AND " +
            "(:genre IS NULL OR :genre = '' OR m.genre = :genre) AND " +
            "(:quality IS NULL OR :quality = '' OR m.quality = :quality) AND " +
            "(:minRating IS NULL OR m.rating >= :minRating) AND " +
            "(:maxDuration IS NULL OR m.duration <= :maxDuration)")
    List<Movie> filter(@Param("q") String q,
                       @Param("genre") String genre,
                       @Param("quality") String quality,
                       @Param("minRating") Double minRating,
                       @Param("maxDuration") Integer maxDuration);
}