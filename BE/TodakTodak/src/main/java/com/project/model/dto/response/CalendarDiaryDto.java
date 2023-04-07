package com.project.model.dto.response;

import com.project.model.entity.Diary;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.TextStyle;
import java.util.Locale;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.stereotype.Component;

@Getter
@Setter
@Component
@NoArgsConstructor
@AllArgsConstructor
public class CalendarDiaryDto {
    
    private Long      diaryId;
    private Integer   diaryScore;
    private LocalDate diaryCreateDate;
    private String    diaryCreatedDayOfWeek;
    
    public static CalendarDiaryDto fromEntity(Diary diary) {
        DayOfWeek dayOfWeek       = diary.getDiaryCreateDate().getDayOfWeek();
        String    dayOfWeekKorean = dayOfWeek.getDisplayName(TextStyle.FULL, Locale.KOREAN);
        return new CalendarDiaryDto(
                diary.getDiaryId(),
                diary.getDiaryScore(),
                diary.getDiaryCreateDate(),
                dayOfWeekKorean
        );
    }
}
