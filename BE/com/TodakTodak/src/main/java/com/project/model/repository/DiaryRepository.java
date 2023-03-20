package com.project.model.repository;

import com.project.model.entity.Diary;
import com.project.model.entity.User;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface DiaryRepository extends JpaRepository<Diary, Long> {
    
    List<Diary> findAllByUser(User user);
    
    Diary findTopByOrderByDiaryIdDesc();
}
