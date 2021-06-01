package com.example.boardapp.repositories;

import com.example.boardapp.entities.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.CrudRepository;

import com.example.boardapp.entities.Message;

import java.util.Set;

public interface MessageRepository extends CrudRepository<Message, Long> {

    Page<Message> findByTag(String tag, Pageable pageable);

    Page<Message> findAll(Pageable pageable);

    Page<Message> findByAuthorIn(Set<User> users, Pageable pageable);

    Page<Message> findByAuthor(User user, Pageable pageable);

    Page<Message> findByAuthorInAndTagEquals(Set<User> users, String tag, Pageable pageable);
}
