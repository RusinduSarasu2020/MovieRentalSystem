package com.cinerent.service;

import com.cinerent.model.User;
import com.cinerent.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class UserService {
    @Autowired private UserRepository repo;

    public User register(User u) { return repo.save(u); }
    public Optional<User> login(String username, String password) {
        return repo.findByUsername(username).filter(u -> u.getPassword().equals(password) && !u.isBlocked());
    }
    public List<User> all() { return repo.findAll(); }
    public List<User> search(String q) { return repo.findByUsernameContainingIgnoreCase(q); }
    public void delete(Long id) { repo.deleteById(id); }
    public User toggleBlock(Long id) {
        User u = repo.findById(id).orElseThrow();
        u.setBlocked(!u.isBlocked());
        return repo.save(u);
    }
    public Optional<User> findById(Long id) { return repo.findById(id); }
    public boolean existsByUsername(String u) { return repo.findByUsername(u).isPresent(); }
}