package com.cinerent.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String index() { return "index"; }

    @GetMapping("/terms")
    public String terms() { return "terms"; }

    @GetMapping("/privacy")
    public String privacy() { return "privacy"; }
}
