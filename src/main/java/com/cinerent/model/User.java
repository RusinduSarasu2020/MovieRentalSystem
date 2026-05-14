package com.cinerent.model;

import jakarta.persistence.*;

@Entity
@Table(name = "users")

// ✅ ADD THESE
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "dtype", discriminatorType = DiscriminatorType.STRING)
@DiscriminatorValue("USER")

public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String username;

    @Column(unique = true, nullable = false)
    private String email;

    private String phone;
    private String password;

    private String role = "USER";   // still fine 👍
    private boolean blocked = false;

    public User() {}

    public User(String username, String email, String phone, String password) {
        this.username = username;
        this.email = email;
        this.phone = phone;
        this.password = password;
    }

    // getters/setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String u) { this.username = u; }

    public String getEmail() { return email; }
    public void setEmail(String e) { this.email = e; }

    public String getPhone() { return phone; }
    public void setPhone(String p) { this.phone = p; }

    public String getPassword() { return password; }
    public void setPassword(String p) { this.password = p; }

    public String getRole() { return role; }
    public void setRole(String r) { this.role = r; }

    public boolean isBlocked() { return blocked; }
    public void setBlocked(boolean b) { this.blocked = b; }
}