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
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

import static com.example.boardapp.controller.ControllerUtils.getPreviousPageByRequest;

@Controller
public class UserMessageController {
    @Autowired
    private MessageRepository messageRepository;

    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("/user-messages/{user}")
    public String userMessages(
            @AuthenticationPrincipal User currentUser,
            @PathVariable User user,
            Model model,
            @RequestParam(required = false) Message message,
            @PageableDefault(sort = {"id"}, direction = Sort.Direction.ASC) Pageable pageable
    ) {
        Page<Message> page = messageRepository.findByAuthor(user, pageable);

        model.addAttribute("page", page);
        model.addAttribute("url", "/user-messages/" + user.getId());
        model.addAttribute("message", message);

        model.addAttribute("userAuthor", user);
        model.addAttribute("isCurrentUser", currentUser.equals(user));

        model.addAttribute("isSubscriber", user.getSubscribers().contains(currentUser));

        model.addAttribute("subscriptionsCount", user.getSubscriptions().size());
        model.addAttribute("subscribersCount", user.getSubscribers().size());
        return "user_messages";
    }

    @GetMapping("/delete/{message}")
    public String userMessages(
            @AuthenticationPrincipal User currentUser,
            @PathVariable Message message,
            HttpServletRequest request
    ) {
        User author = message.getAuthor();
        if (currentUser.equals(author) || currentUser.isAdmin()) {
            messageRepository.deleteById(message.getId());
        }
        return getPreviousPageByRequest(request).orElse("/user-messages/"+ author.getId());
    }

    @PostMapping("/user-messages/{user}")
    public String updateMessage(
            @AuthenticationPrincipal User currentUser,
            @PathVariable User user,
            Model model,
            @RequestParam("id") Message message,
            @RequestParam("text") String text,
            @RequestParam("tag") String tag,
            @RequestParam(name="file", required=false) MultipartFile file
    ) throws IOException {
        if (message.getAuthor().equals(currentUser)) {
            if (!ObjectUtils.isEmpty(text)) {
                message.setText(text);
            }

            if (!ObjectUtils.isEmpty(tag)) {
                message.setTag(tag);
            }

            ControllerUtils.saveFile(message, file, uploadPath);

            messageRepository.save(message);
        }
        return "redirect:/user-messages/" + user.getId();
    }
}
