package com.victolee.signuplogin.service;

import com.victolee.signuplogin.domain.User;
import com.victolee.signuplogin.domain.repository.UserRepository;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
public class MemberService {

    private final UserRepository userRepository;

    @Transactional(readOnly = true)
    public boolean isEmailAlreadyExists(String email) {
        Optional<User> existingMember = userRepository.findByEmail(email);
        return existingMember.isPresent();
    }

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public User getUserByEmail(String email){
        return userRepository.findByEmail(email).orElse(null);
    }
}
