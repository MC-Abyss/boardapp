package com.example.boardapp;

import com.example.boardapp.entities.Role;
import com.example.boardapp.entities.User;
import com.example.boardapp.repositories.UserRepository;
import com.example.boardapp.service.EmailService;
import com.example.boardapp.service.UserService;
import org.hamcrest.CoreMatchers;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentMatchers;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;

import java.util.Collections;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
public class UnitTest {

    @Autowired
    private UserService userService;

    @MockBean
    private UserRepository userRepository;

    @MockBean
    private EmailService emailService;

    @Test
    public void testAddUser() {
        User user = new User();
        user.setPassword("1234");
        user.setUsername("1234");
        user.setEmail("example@example.com");
        boolean isUserCreated = userService.addUser(user);

        Mockito.verify(userRepository, Mockito.times(1)).save(user);

        assertTrue(isUserCreated);
        assertTrue(CoreMatchers.is(user.getRoles()).matches(Collections.singleton(Role.USER)));

        Mockito.verify(emailService, Mockito.times(1)).send(
                ArgumentMatchers.eq(user.getEmail()),
                ArgumentMatchers.eq("Activation code"),
                ArgumentMatchers.contains("Please, follow this link")
        );
    }

    @Test
    public void addExistingUser() {
        User user = new User();
        user.setUsername("Newt");
        Mockito.doReturn(new User())
            .when(userRepository)
            .findByUsername("Newt");
        boolean isUserCreated = userService.addUser(user);
        assertFalse(isUserCreated);
    }
}
