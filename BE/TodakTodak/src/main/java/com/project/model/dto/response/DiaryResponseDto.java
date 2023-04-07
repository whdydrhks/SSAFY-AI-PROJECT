package com.project.model.dto.response;

import com.project.model.entity.Diary;
import com.project.model.entity.DiaryDetail;
import com.project.model.entity.DiaryEmotion;
import com.project.model.entity.DiaryMet;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import lombok.Getter;
import lombok.Setter;
import org.springframework.stereotype.Component;

@Getter
@Setter
@Component
public class DiaryResponseDto {
    
    private Long       userId;
    private Long       diaryId;
    private String     diaryContent;
    private Integer    diaryScore;
    private List<Long> diaryEmotion;
    private List<Long> diaryMet;
    private List<Long> diaryDetailLineEmotionCount;
    private DayOfWeek  diaryCreatedDayOfWeek;
    private LocalDate  diaryCreatedDate;
    
    public DiaryResponseDto toDiaryDto(Diary diary) {
        // DTO 생성
        DiaryResponseDto diaryResponseDto = new DiaryResponseDto();
        diaryResponseDto.setDiaryId(diary.getDiaryId());
        diaryResponseDto.setDiaryContent(diary.getDiaryContent());
        diaryResponseDto.setDiaryScore(diary.getDiaryScore());
        diaryResponseDto.setUserId(diary.getUser().getUserId());
        // 다이어리에 속한 감정 리스트를 가져옵니다. true 인 것만 가져옵니다.
        diaryResponseDto.setDiaryEmotion(diary.getDiaryEmotions().stream()
                .filter(DiaryEmotion::getDiaryEmotionStatus)
                .map(de -> de.getEmotion().getEmotionId())
                .collect(Collectors.toList()));
        // 다이어리에 속한 메트 리스트를 가져옵니다. true 인 것만 가져옵니다.
        diaryResponseDto.setDiaryMet(diary.getDiaryMets().stream()
                .filter(DiaryMet::getDiaryMetStatus)
                .map(dm -> dm.getMet().getMetId())
                .collect(Collectors.toList()));
        diaryResponseDto.setDiaryCreatedDate(diary.getDiaryCreateDate());
        // 다이어리 상세 정보를 가져옵니다.
        List<Long>  diaryDetailLineEmotionCountList = new ArrayList<>();
        DiaryDetail diaryDetail                     = diary.getDiaryDetail();
        diaryDetailLineEmotionCountList.add(diaryDetail.getDiaryDetailHappyCount());
        diaryDetailLineEmotionCountList.add(diaryDetail.getDiaryDetailAnxietyCount());
        diaryDetailLineEmotionCountList.add(diaryDetail.getDiaryDetailSadCount());
        diaryDetailLineEmotionCountList.add(diaryDetail.getDiaryDetailAngryCount());
        diaryDetailLineEmotionCountList.add(diaryDetail.getDiaryDetailHurtCount());
        diaryResponseDto.setDiaryDetailLineEmotionCount(diaryDetailLineEmotionCountList);
        DayOfWeek dayOfWeek = diary.getDiaryCreateDate().getDayOfWeek();
        diaryResponseDto.setDiaryCreatedDayOfWeek(dayOfWeek);
        // DTO 리턴
        return diaryResponseDto;
    }
}
