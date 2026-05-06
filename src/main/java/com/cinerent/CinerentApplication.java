package com.cinerent;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class CinerentApplication {
    public static void main(String[] args) {
        SpringApplication.run(CinerentApplication.class, args);
        System.out.println("\n🎬 CineRent running → http://localhost:8080\n");
    }
}
