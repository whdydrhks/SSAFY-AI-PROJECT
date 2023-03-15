package com.project.model.dto.request;

import java.util.List;
import lombok.Getter;
import lombok.Setter;

public class DiaryRequestDto {
    
    @Getter
    @Setter
    public static class AddDiary {
        
        private String     diaryContent;
        private Integer    diaryScore;
        private List<Long> diaryEmotionIdList;
        private List<Long> diaryMetIdList;
        private Long       userId;
        
        public AddDiary(String diaryContent, Integer diaryScore, List<Long> diaryEmotionIdList,
                List<Long> diaryMetIdList,
                Long userId) {
            this.diaryContent       = diaryContent;
            this.diaryScore         = diaryScore;
            this.diaryEmotionIdList = diaryEmotionIdList;
            this.diaryMetIdList     = diaryMetIdList;
            this.userId             = userId;
        }
    }
}
