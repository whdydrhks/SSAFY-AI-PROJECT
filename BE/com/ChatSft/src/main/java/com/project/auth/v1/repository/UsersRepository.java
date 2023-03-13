package com.project.auth.v1.repository;

import com.project.auth.entity.Users;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UsersRepository extends JpaRepository<Users, Long> {
    
    Optional<Users> findByEmail(String email);
    
    boolean existsByEmail(String email);
}
