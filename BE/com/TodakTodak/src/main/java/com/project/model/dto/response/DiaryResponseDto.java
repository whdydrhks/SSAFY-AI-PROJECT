package com.project.model.dto.response;

import com.project.model.entity.Diary;
import java.time.DayOfWeek;
import java.time.LocalDateTime;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.stereotype.Component;

@Getter
@Setter
@Component
public class DiaryResponseDto {
    
    private Long          userId;
    private Long          diaryId;
    private String        diaryContent;
    private Integer       diaryScore;
    private List<Long>    diaryEmotion;
    private List<Long>    diaryMet;
    private LocalDateTime diaryCreatedDate;
    private DayOfWeek     diaryCreatedDayOfWeek;
    private LocalDateTime diaryModifiedDate;
    private List<Long>    diaryDetailLineEmotionCount;
    
    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class DiaryToDto {
        
        private Long          userId;
        private Long          diaryId;
        private String        diaryContent;
        private Integer       diaryScore;
        private List<Long>    diaryEmotion;
        private List<Long>    diaryMet;
        private LocalDateTime diaryCreatedDate;
        private DayOfWeek     diaryCreatedDayOfWeek;
        private LocalDateTime diaryModifiedDate;
        private List<Long>    diaryDetailLineEmotionCount;
    }
    
    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class CalendarDiary {
        
        private Long          diaryId;
        private Integer       diaryScore;
        private LocalDateTime diaryCreatedDate;
        private DayOfWeek     diaryCreatedDayOfWeek;
        
        public DiaryResponseDto.CalendarDiary toCalendarDiaryDto(Diary diary) {
            DiaryResponseDto.CalendarDiary calendarDiary = new DiaryResponseDto.CalendarDiary();
            calendarDiary.setDiaryId(diary.getDiaryId());
            calendarDiary.setDiaryScore(diary.getDiaryScore());
            calendarDiary.setDiaryCreatedDate(diary.getDiaryCreateDate());
            calendarDiary.setDiaryCreatedDayOfWeek(diary.getDiaryCreateDate().getDayOfWeek());
            return calendarDiary;
        }
    }
}
