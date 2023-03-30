package com.project.model.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@Entity
public class DiaryEmotion {
    
    @Id
    @Column(name = "diary_emotion_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long diaryEmotionId;
    
    @Column(name = "diary_emotion_status")
    private Boolean diaryEmotionStatus;
    
    @ManyToOne
    @JoinColumn(name = "diary_id")
    private Diary diary;
    
    @ManyToOne
    @JoinColumn(name = "emotion_id")
    private Emotion emotion;
}
