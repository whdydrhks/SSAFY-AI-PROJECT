package com.project.model.dto.response;

import java.util.List;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserDiaryDto {
    
    private Long                     diaryId;
    private String                   diaryContent;
    private Integer                  diaryScore;
    private List<EmotionResponseDto> emotions;
    private List<MetResponseDto>     mets;
}
