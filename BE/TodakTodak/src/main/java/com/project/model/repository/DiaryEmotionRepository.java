package com.project.model.repository;

import com.project.model.entity.DiaryEmotion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DiaryEmotionRepository extends JpaRepository<DiaryEmotion, Long> {

}