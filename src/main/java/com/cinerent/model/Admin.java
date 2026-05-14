package com.cinerent.model;

import jakarta.persistence.Entity;
import jakarta.persistence.DiscriminatorValue;

@Entity

// ✅ ADD THIS
@DiscriminatorValue("ADMIN")

public class Admin extends User {

    private String adminLevel = "SUPER";

    public Admin() {
        setRole("ADMIN");
    }

    public String getAdminLevel() { return adminLevel; }
    public void setAdminLevel(String adminLevel) { this.adminLevel = adminLevel; }

    // Polymorphic admin-only behaviour
    public String describe() {
        return "Admin[" + getUsername() + ", level=" + adminLevel + "]";
    }
}