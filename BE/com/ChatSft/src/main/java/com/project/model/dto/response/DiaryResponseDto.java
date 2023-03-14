package com.project.model.dto.response;

import com.project.model.entity.Diary;
import com.project.model.entity.DiaryEmotion;
import java.util.List;
import java.util.stream.Collectors;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DiaryResponseDto {
    
    private Long                     diaryId;
    private String                   diaryContent;
    private Integer                  diaryScore;
    private List<EmotionResponseDto> diaryEmotion;
    
    @Builder
    public DiaryResponseDto(Diary diary) {
        this.diaryId      = diary.getDiaryId();
        this.diaryContent = diary.getDiaryContent();
        this.diaryScore   = diary.getDiaryScore();
        
        List<DiaryEmotion> findDiaryEmotion = diary.getDiaryEmotions();
        this.diaryEmotion = findDiaryEmotion.stream()
                .map(DiaryEmotion::getEmotion)
                .map(EmotionResponseDto::new)
                .collect(Collectors.toList());
    }
}
