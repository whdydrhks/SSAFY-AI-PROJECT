package com.project.model.dto.response;

import java.time.LocalDateTime;
import java.util.List;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DiaryResponseDto {
    
    private Long          diaryId;
    private String        diaryContent;
    private Integer       diaryScore;
    private List<Long>    diaryEmotion;
    private List<Long>    diaryMet;
    private LocalDateTime diaryCreatedDate;
    private LocalDateTime diaryModifiedDate;
}
