package com.cinerent.controller;

import com.cinerent.model.Movie;
import com.cinerent.model.User;
import com.cinerent.service.MovieService;
import com.cinerent.service.ReviewService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

@Controller
public class MovieController {
    @Autowired private MovieService movieService;
    @Autowired private ReviewService reviewService;

    @Value("${app.upload.dir:uploads}")
    private String uploadDir;

    @GetMapping("/admin/movies")
    public String list(HttpSession s, Model m) {
        User u = (User) s.getAttribute("user");
        if (u == null || !"ADMIN".equals(u.getRole())) return "redirect:/admin/login";
        m.addAttribute("movies", movieService.all());
        return "admin/manageMovies";
    }

    @PostMapping("/admin/movies/add")
    public String add(@ModelAttribute Movie movie) { movieService.addMovie(movie); return "redirect:/admin/movies"; }

    @PostMapping("/admin/movies/{id}/delete")
    public String delete(@PathVariable Long id) { movieService.delete(id); return "redirect:/admin/movies"; }

    @PostMapping("/admin/movies/{id}/edit")
    public String edit(@PathVariable Long id, @ModelAttribute Movie movie) {
        movie.setId(id); movieService.update(movie); return "redirect:/admin/movies";
    }

    /**
     * Update the banner/poster image for a movie.
     * Accepts a multipart file, saves it to the uploads directory, and
     * updates the movie's posterUrl in the database.
     */
    @PostMapping("/admin/movies/{id}/update-banner")
    public String updateBanner(@PathVariable Long id,
                               @RequestParam("bannerFile") MultipartFile bannerFile,
                               HttpSession s) throws IOException {
        // Admin guard
        User u = (User) s.getAttribute("user");
        if (u == null || !"ADMIN".equals(u.getRole())) return "redirect:/admin/login";

        if (!bannerFile.isEmpty()) {
            // Resolve absolute path for the uploads folder
            String absUploadDir = new File(uploadDir).isAbsolute()
                    ? uploadDir
                    : new File(System.getProperty("user.dir"), uploadDir).getAbsolutePath();

            Path dirPath = Paths.get(absUploadDir);
            Files.createDirectories(dirPath);

            // Build a unique filename preserving the original extension
            String original = bannerFile.getOriginalFilename();
            String ext = (original != null && original.contains("."))
                    ? original.substring(original.lastIndexOf('.'))
                    : ".jpg";
            String filename = "movie_" + id + "_" + UUID.randomUUID().toString().substring(0, 8) + ext;

            Path dest = dirPath.resolve(filename);
            bannerFile.transferTo(dest.toFile());

            // Update posterUrl in DB — served via /uploads/** static mapping
            Movie movie = movieService.findById(id).orElseThrow();
            movie.setPosterUrl("/uploads/" + filename);
            movieService.update(movie);
        }

        return "redirect:/admin/movies";
    }

    @GetMapping("/movie/{id}")
    public String details(@PathVariable Long id, HttpSession s, Model m) {
        if (s.getAttribute("user") == null) return "redirect:/login";
        Movie movie = movieService.findById(id).orElseThrow();
        m.addAttribute("movie", movie);
        m.addAttribute("reviews", reviewService.forMovie(movie));
        return "movieDetails";
    }
}
