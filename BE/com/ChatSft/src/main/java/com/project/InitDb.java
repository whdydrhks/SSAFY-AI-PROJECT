package com.project;

import com.project.model.dto.request.DiaryRequestDto;
import com.project.model.dto.request.EmotionRequestDto;
import com.project.model.dto.request.EmotionRequestDto.AddEmotion;
import com.project.model.dto.request.MetRequestDto;
import com.project.model.dto.request.MetRequestDto.AddMet;
import com.project.model.dto.request.UserRequestDto.SignUp;
import com.project.model.service.DiaryService;
import com.project.model.service.EmotionService;
import com.project.model.service.MetService;
import com.project.model.service.UserService;
import java.util.List;
import javax.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class InitDb {
    
    private final initService initService;
    
    @PostConstruct
    public void init() {
        initService.userInit("김싸피", "Device1234!!");
        initService.userInit("김서울", "Device4321!!");
        initService.userInit("박대전", "Device4321!!");
        initService.userInit("최광주", "Device4321!!");
        initService.userInit("이구미", "Device4321!!");
        initService.userInit("강부울경", "Device4321!!");
        initService.emotionInit("기쁨");
        initService.emotionInit("슬픔");
        initService.emotionInit("화남");
        initService.emotionInit("놀람");
        initService.emotionInit("우울");
        initService.metInit("지인");
        initService.metInit("가족");
        initService.metInit("친구");
        initService.metInit("연인");
        initService.metInit("혼자");
        initService.diaryInit("오늘은 기분이 좋았다.", 5, List.of(1L, 2L), List.of(1L, 2L), 1L);
        initService.diaryInit("오늘은 기분이 좋지 않았다.", 1, List.of(3L, 4L), List.of(3L, 4L), 2L);
        initService.diaryInit("오늘은 기분이 좋지 않았다.", 1, List.of(3L, 4L), List.of(3L, 4L), 3L);
    }
    
    @Component
    @RequiredArgsConstructor
    static class initService {
        
        private final UserService    userService;
        private final EmotionService emotionService;
        private final MetService     metService;
        private final DiaryService   diaryService;
        
        public void userInit(String userNickname, String userDevice) {
            SignUp signUp = new SignUp(userNickname, userDevice);
            userService.signUp(signUp);
        }
        
        public void emotionInit(String emotionName) {
            EmotionRequestDto.AddEmotion addEmotion = new AddEmotion();
            addEmotion.setEmotionName(emotionName);
            emotionService.addEmotion(addEmotion);
        }
        
        public void metInit(String metName) {
            MetRequestDto.AddMet addMet = new AddMet();
            addMet.setMetName(metName);
            metService.addMet(addMet);
        }
        
        public void diaryInit(String diaryContent, Integer diaryScore, List<Long> diaryEmotionIdList,
                List<Long> diaryMetIdList, Long userId) {
            DiaryRequestDto.AddDiary addDiary = new DiaryRequestDto.AddDiary(diaryContent, diaryScore,
                    diaryEmotionIdList, diaryMetIdList, userId);
            diaryService.addDiary(addDiary);
        }
    }
}
