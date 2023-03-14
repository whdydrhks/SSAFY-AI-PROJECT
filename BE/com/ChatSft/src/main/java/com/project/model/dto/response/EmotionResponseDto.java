package com.project.model.dto.response;

import com.project.model.entity.DiaryEmotion;
import com.project.model.entity.Emotion;
import java.util.List;
import java.util.stream.Collectors;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EmotionResponseDto {
    
    private Long                   emotionId;
    private String                 emotionName;
    private List<DiaryResponseDto> diaryEmotion;
    
    @Builder
    public EmotionResponseDto(Emotion emotion) {
        this.emotionId   = emotion.getEmotionId();
        this.emotionName = emotion.getEmotionName();
        
        List<DiaryEmotion> findDiaryEmotion = emotion.getDiaryEmotions();
        this.diaryEmotion = findDiaryEmotion.stream()
                .map(DiaryEmotion::getDiary)
                .map(DiaryResponseDto::new)
                .collect(Collectors.toList());
    }
}
