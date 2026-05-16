package com.cinerent.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.io.File;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Value("${app.upload.dir:uploads}")
    private String uploadDir;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // Resolve the absolute path to the uploads folder
        String absPath = new File(uploadDir).isAbsolute()
                ? uploadDir
                : new File(System.getProperty("user.dir"), uploadDir).getAbsolutePath();

        // Serve uploaded files at /uploads/**
        registry.addResourceHandler("/uploads/**")
                .addResourceLocations("file:" + absPath + File.separator);
    }
}

