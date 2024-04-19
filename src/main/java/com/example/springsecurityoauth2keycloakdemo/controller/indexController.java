package com.example.springsecurityoauth2keycloakdemo.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;

@RestController
public class indexController {
    @GetMapping("/home")
    @PreAuthorize("hasAuthority('test')")
    public String hello() {
        return "Hello";
    }

    @GetMapping("/test")
    @PreAuthorize("hasAuthority('manage-account')")
    public String test() {
        return "test";
    }
}
