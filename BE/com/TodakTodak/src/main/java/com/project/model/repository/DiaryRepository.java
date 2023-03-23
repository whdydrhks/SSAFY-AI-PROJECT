package com.project.model.repository;

import com.project.model.entity.Diary;
import com.project.model.entity.User;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import org.springframework.stereotype.Repository;


@Repository
public interface DiaryRepository extends JpaRepository<Diary, Long>, QuerydslPredicateExecutor<Diary> {
    
    Optional<List<Diary>> findAllByUser(User user);
    
    Optional<Diary> findTopByOrderByDiaryIdDesc();
}
