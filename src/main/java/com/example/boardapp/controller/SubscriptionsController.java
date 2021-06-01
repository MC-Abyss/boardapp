package com.example.boardapp.controller;

import com.example.boardapp.entities.Message;
import com.example.boardapp.entities.User;
import com.example.boardapp.repositories.MessageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.IOException;
import java.util.Map;

@Controller
public class SubscriptionsController {
    @Autowired
    private MessageRepository messageRepository;

    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("/subscriptions")
    public String main(
            @AuthenticationPrincipal User user,
            @RequestParam(required = false, defaultValue = "") String filter,
            Model model,
            @PageableDefault(sort = {"id"}, direction = Sort.Direction.ASC) Pageable pageable
    ) {
        Page<Message> page;
        if( filter == null || filter.isEmpty()) {
            page = messageRepository.findByAuthorIn(user.getSubscriptions(), pageable);
        } else {
            page = messageRepository.findByAuthorInAndTagEquals(user.getSubscriptions(), filter, pageable);
        }
        model.addAttribute("page", page);
        model.addAttribute("url", "/subscriptions");
        model.addAttribute("filter", filter);
        return "subscription_messages";
    }

    @PostMapping("/subscriptions")
    public String add(
            @AuthenticationPrincipal User user,
            @Valid Message message,
            BindingResult bindingResult, Model model,
            @RequestParam(name="file", required=false) MultipartFile file,
            @PageableDefault(sort = {"id"}, direction = Sort.Direction.ASC) Pageable pageable
    ) throws IOException {
        if (bindingResult.hasErrors()) {
            Map<String, String> errorMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorMap);
            model.addAttribute("message", message);
        } else {
            message.setAuthor(user);
            ControllerUtils.saveFile(message, file, uploadPath);
            model.addAttribute("message", null);
            messageRepository.save(message);
        }
        Page<Message> page = messageRepository.findByAuthorIn(user.getSubscriptions(), pageable);
        model.addAttribute("page", page);
        model.addAttribute("url", "/subscriptions");
        return "subscription_messages";
    }
}
