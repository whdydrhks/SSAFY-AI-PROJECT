package com.project.model.dto.request;

import lombok.Getter;
import lombok.Setter;

public class DiaryRequestDto {
    
    @Getter
    @Setter
    public static class AddDiary {
        
        private String  diaryContent;
        private Integer diaryScore;
        private Boolean diaryStatus;
        private Long    diaryEmotionId;
        private Long    diaryMetId;
        private Long    userId;
        
        public AddDiary(String diaryContent, Integer diaryScore, Boolean diaryStatus, Long diaryEmotionId,
                Long diaryMetId,
                Long userId) {
            this.diaryContent   = diaryContent;
            this.diaryScore     = diaryScore;
            this.diaryStatus    = diaryStatus;
            this.diaryEmotionId = diaryEmotionId;
            this.diaryMetId     = diaryMetId;
            this.userId         = userId;
        }
    }
}
