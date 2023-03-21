package com.project.model.repository;

import com.project.model.entity.User;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Long>, QuerydslPredicateExecutor<User> {
    
    Optional<User> findUserByUserNickname(String userNickname);
    
    boolean existsUserByUserNickname(String userNickname);
}
