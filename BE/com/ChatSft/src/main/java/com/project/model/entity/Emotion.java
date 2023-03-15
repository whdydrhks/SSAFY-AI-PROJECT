package com.project.model.entity;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
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
public class Emotion {
    
    @Id
    @Column(name = "emotion_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long emotionId;
    
    @Column(name = "emotion_name")
    private String emotionName;
    
    @OneToMany(mappedBy = "emotion", cascade = CascadeType.ALL)
    private List<DiaryEmotion> diaryEmotions = new ArrayList<>();
}
