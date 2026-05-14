package com.cinerent.config;

import com.cinerent.model.Admin;
import com.cinerent.model.Movie;
import com.cinerent.repository.MovieRepository;
import com.cinerent.repository.UserRepository;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class DataInitializer {
    @Autowired private UserRepository userRepo;
    @Autowired private MovieRepository movieRepo;

    @PostConstruct
    public void init() {
        if (userRepo.findByUsername("admin").isEmpty()) {
            Admin a = new Admin();
            a.setUsername("admin"); a.setEmail("admin@cinerent.com");
            a.setPhone("0000000000"); a.setPassword("admin123");
            userRepo.save(a);
            System.out.println("✅ Default admin created → username: admin / password: admin123");
        }
        if (movieRepo.count() == 0) {
            String[][] data = {
                    {"Inception","Scifi","148","1080p","8.8","250"},
                    {"The Conjuring","Horror","112","1080p","7.5","200"},
                    {"Planet Earth","Documentary","300","4K","9.5","300"},
                    {"Toy Story","Family","81","1080p","8.3","180"},
                    {"Frozen","Child","102","1080p","7.4","200"},
                    {"The Hangover","Comedy","100","720p","7.7","150"},
                    {"Indiana Jones","Adventure","115","720p","7.6","180"},
                    {"The Godfather","Crime","175","1080p","9.2","250"},
                    {"Se7en","Thriller","127","1080p","8.6","220"},
                    {"Shutter Island","Psychological","138","1080p","8.2","220"}
            };
            for (String[] d : data) {
                Movie m = new Movie();
                m.setTitle(d[0]); m.setGenre(d[1]); m.setDuration(Integer.parseInt(d[2]));
                m.setQuality(d[3]); m.setRating(Double.parseDouble(d[4])); m.setPrice(Double.parseDouble(d[5]));
                m.setAvailable(true);
                m.setPosterUrl("https://picsum.photos/seed/" + d[0].replace(" ","") + "/300/450");
                m.setDescription(d[0] + " — a great " + d[1] + " movie.");
                movieRepo.save(m);
            }
            System.out.println("✅ Sample movies seeded.");
        }
    }
}