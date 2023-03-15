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
    
    @Getter
    @Setter
    public static class UpdateDiary {
        
        private Long       diaryId;
        private String     diaryContent;
        private Integer    diaryScore;
        private List<Long> diaryEmotionIdList;
        private List<Long> diaryMetIdList;
        
        public UpdateDiary(Long diaryId, String diaryContent, Integer diaryScore,
                List<Long> diaryEmotionIdList, List<Long> diaryMetIdList) {
            this.diaryId            = diaryId;
            this.diaryContent       = diaryContent;
            this.diaryScore         = diaryScore;
            this.diaryEmotionIdList = diaryEmotionIdList;
            this.diaryMetIdList     = diaryMetIdList;
        }
    }
    
    public static class DeleteDiary {
        
        private Long diaryId;
        
        public Long getDiaryId() {
            return diaryId;
        }
    }
}
