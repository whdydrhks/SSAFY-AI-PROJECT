package com.project.model.repository;

import com.project.model.entity.Emotion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EmotionRepository extends JpaRepository<Emotion, Long> {
    
    /**
     * 감정 이름으로 감정 존재 여부
     *
     * @param emotionName
     * @return boolean
     */
    boolean existsEmotionByEmotionName(String emotionName);
}
