package com.project.model.dto.request;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

public class DiaryRequestDto {
    
    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class AddDiary {
        
        private String     diaryContent;
        private Integer    diaryScore;
        private String     diaryCreateDate;
        private List<Long> diaryEmotionIdList;
        private List<Long> diaryMetIdList;
        private List<Long> diaryDetailLineEmotionCountList;
    }
    
    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class UpdateDiary {
        
        private Long       diaryId;
        private String     diaryContent;
        private Integer    diaryScore;
        private String     diaryCreateDate;
        private List<Long> diaryEmotionIdList;
        private List<Long> diaryMetIdList;
        private List<Long> diaryDetailLineEmotionCountList;
    }
    
    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class DeleteDiary {
        
        private Long diaryId;
    }
}
