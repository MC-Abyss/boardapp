package com.example.boardapp.controller;

import com.example.boardapp.entities.Message;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

public class ControllerUtils {
    static Map<String, String> getErrors(BindingResult bindingResult) {
        return bindingResult.getFieldErrors().stream().collect(Collectors.toMap(
                fieldError -> fieldError.getField() + "Error",
                FieldError::getDefaultMessage
        ));
    }

    static Optional<String> getPreviousPageByRequest(HttpServletRequest request)
    {
        return Optional.ofNullable(request.getHeader("Referer")).map(requestUrl -> "redirect:" + requestUrl);
    }

    public static void saveFile(@Valid Message message,
                                @RequestParam(name = "file", required = false) MultipartFile file,
                                String uploadPath
    ) throws IOException {
        if (file != null && !file.isEmpty()) {
            File uploadDirectory = new File(uploadPath);
            if (!uploadDirectory.exists()) {
                uploadDirectory.mkdir();
            }
            String fileUUID = UUID.randomUUID().toString();
            String filename = fileUUID + "_" + file.getOriginalFilename();
            file.transferTo(new File(uploadDirectory + "/" + filename));
            message.setFilename(filename);
        }
    }
}
