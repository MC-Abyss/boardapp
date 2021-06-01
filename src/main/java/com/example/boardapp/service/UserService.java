package com.example.boardapp.service;

import com.example.boardapp.entities.Role;
import com.example.boardapp.entities.User;
import com.example.boardapp.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class UserService implements UserDetailsService {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private EmailService emailService;

    @Autowired
    PasswordEncoder passwordEncoder;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepository.findByUsername(username);
        if (user == null) {
            throw new UsernameNotFoundException("Рользователь не найден.");
        }
        return user;
    }

    public boolean addUser(User user) {
        User userInfo = userRepository.findByUsername(user.getUsername());

        if (userInfo != null) {
            return false;
        }

        user.setActive(false);
        user.setRoles(Collections.singleton(Role.USER));
        user.setActivationCode(UUID.randomUUID().toString());
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userRepository.save(user);

        if (!ObjectUtils.isEmpty(user.getEmail())) {
            String message = String.format(
                    "Приветствуем, %s \n" +
                            "Пожалуйста, перейдите по ссылке для активации аккаунта BoardApp:\n" +
                            "http://localhost:8080/activate/%s",
                    user.getUsername(),
                    user.getActivationCode()
            );
            emailService.send(user.getEmail(), "Код активации", message);
        }
        return true;
    }

    public boolean activateUser(String code) {
        User user = userRepository.findByActivationCode(code);

        if (user == null) {
            return false;
        }

        user.setActive(true);
        user.setActivationCode(null);
        userRepository.save(user);
        return true;
    }

    public List<User> findAll() {
        return userRepository.findAll();
    }

    public void updateUserByAdmin(User user, String username, Map<String, String> form) {
        user.setUsername(username);
        Set<String> roles = Arrays.stream(Role.values())
                .map(Role::name).collect(Collectors.toSet());
        user.getRoles().clear();
        for (String key : form.keySet()) {
            if (roles.contains(key)) {
                user.getRoles().add(Role.valueOf(key));
            }
        }
        userRepository.save(user);
    }

    public void updateUser(User user, String password, String email) {
        String oldEmail = user.getEmail();

        if (!ObjectUtils.isEmpty(password)) {
            user.setPassword(passwordEncoder.encode(password));
        }

        if (!Objects.equals(oldEmail, email)) {
            user.setEmail(email);
            user.setActivationCode(UUID.randomUUID().toString());
        }

        userRepository.save(user);

        if(!Objects.equals(oldEmail, email)) {
            String message = String.format(
                    "Приветствуем, %s \n" +
                            "Пожалуйста, перейдите по ссылке для повторной активации аккаунта BoardApp:\n" +
                            "http://localhost:8080/activate/%s",
                    user.getUsername(),
                    user.getActivationCode()
            );
            emailService.send(user.getEmail(), "Код активации", message);
        }
    }

    public void subscribe(User currentUser, User user) {
        user.getSubscribers().add(currentUser);
        userRepository.save(user);
    }

    public void unsubscribe(User currentUser, User user) {
        user.getSubscribers().remove(currentUser);
        userRepository.save(currentUser);
    }
}
