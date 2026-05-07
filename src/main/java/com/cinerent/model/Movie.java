package com.cinerent.model;

import jakarta.persistence.*;

@Entity
@Table(name = "movies")
public class Movie {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;
    private String genre;       // Scifi, Horror, Documentary, Family, Child, Comedy, Adventure, Crime, Thriller, Psychological
    private int duration;       // minutes
    private String quality;     // 480p / 720p / 1080p / 4K
    private double rating;      // 0–10
    private double price;
    private boolean available = true;
    @Column(length = 500) private String posterUrl;
    @Column(length = 1000) private String description;
    private String watchPassword = "movie123"; // password to watch online

    public Movie() {}

    // getters / setters
    public Long getId() { return id; } public void setId(Long id) { this.id = id; }
    public String getTitle() { return title; } public void setTitle(String t) { this.title = t; }
    public String getGenre() { return genre; } public void setGenre(String g) { this.genre = g; }
    public int getDuration() { return duration; } public void setDuration(int d) { this.duration = d; }
    public String getQuality() { return quality; } public void setQuality(String q) { this.quality = q; }
    public double getRating() { return rating; } public void setRating(double r) { this.rating = r; }
    public double getPrice() { return price; } public void setPrice(double p) { this.price = p; }
    public boolean isAvailable() { return available; } public void setAvailable(boolean a) { this.available = a; }
    public String getPosterUrl() { return posterUrl; } public void setPosterUrl(String p) { this.posterUrl = p; }
    public String getDescription() { return description; } public void setDescription(String d) { this.description = d; }
    public String getWatchPassword() { return watchPassword; } public void setWatchPassword(String w) { this.watchPassword = w; }
}