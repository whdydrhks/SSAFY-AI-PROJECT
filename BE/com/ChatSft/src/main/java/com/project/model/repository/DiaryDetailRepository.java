package com.project.model.repository;

import com.project.model.entity.Diary;
import com.project.model.entity.DiaryDetail;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DiaryDetailRepository extends JpaRepository<DiaryDetail, Long> {
    
    Optional<DiaryDetail> findByDiary(Diary diary);
}