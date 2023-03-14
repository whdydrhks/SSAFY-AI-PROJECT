package com.project.model.repository;

import com.project.model.entity.Emotion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EmotionRepository extends JpaRepository<Emotion, Long> {
    
    boolean existsEmotionByEmotionName(String emotionName);
}
