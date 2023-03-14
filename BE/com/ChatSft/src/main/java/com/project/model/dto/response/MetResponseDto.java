package com.project.model.dto.response;

import com.project.model.entity.DiaryMet;
import com.project.model.entity.Met;
import java.util.List;
import java.util.stream.Collectors;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MetResponseDto {
    
    private Long                   metId;
    private String                 metName;
    private List<DiaryResponseDto> diaryMet;
    
    @Builder
    public MetResponseDto(Met met) {
        this.metId   = met.getMetId();
        this.metName = met.getMetName();
        
        List<DiaryMet> findDiaryMet = met.getDiaryMets();
        this.diaryMet = findDiaryMet.stream()
                .map(DiaryMet::getDiary)
                .map(DiaryResponseDto::new)
                .collect(Collectors.toList());
    }
}
