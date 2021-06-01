package com.example.boardapp.controller;

import com.example.boardapp.entities.User;
import com.example.boardapp.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.validation.Valid;
import java.util.Map;


@Controller
public class RegistrationController {

    @Autowired
    private UserService userService;

    @GetMapping("/register")
    public String register() {
        return "register";
    }

    @PostMapping("/register")
    public String addUser(@RequestParam("password2") String password2,
                          @Valid User newUser, BindingResult bindingResult, Model model) {
        boolean trigger = false;
        if (ObjectUtils.isEmpty(password2)) {
            model.addAttribute("password2Error", "Подтверждение пароля не может быть пустым!");
            trigger = true;
        }
        if (!newUser.getPassword().equals(password2)) {
            model.addAttribute("password2Error", "Введенные пароли различаются!");
            trigger = true;
        }

        if(trigger || bindingResult.hasErrors()) {
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);
            return "register";
        }

        if (!userService.addUser(newUser)) {
            model.addAttribute("usernameError", "Пользователь уже существует!");
            return "register";
        }

        return "redirect:/login";
    }

    @GetMapping("/activate/{code}")
    public String activate(Model model, @PathVariable String code) {
        boolean isActive = userService.activateUser(code);
        if (isActive) {
            model.addAttribute("messageType", "success");
            model.addAttribute("message", "Пользователь успешно активирован!");
        } else {
            model.addAttribute("messageType", "warning");
            model.addAttribute("message", "Этот код не может быть использован!");
        }
        return "login";
    }
}
