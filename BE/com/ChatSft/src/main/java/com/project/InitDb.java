package com.project;

import com.project.model.dto.request.EmotionRequestDto.AddEmotion;
import com.project.model.dto.request.UserRequestDto.SignUp;
import com.project.model.entity.Emotion;
import com.project.model.service.EmotionService;
import com.project.model.service.UserService;
import javax.annotation.PostConstruct;
import javax.persistence.EntityManager;
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
    }
    
    @Component
    @RequiredArgsConstructor
    static class initService {
        
        private final UserService    userService;
        private final EmotionService emotionService;
        
        public void userInit(String userNickname, String userDevice) {
            SignUp signUp = new SignUp(userNickname, userDevice);
            userService.signUp(signUp);
        }
        
        public void emotionInit(String emotionName) {
            AddEmotion addEmotion = new AddEmotion(emotionName);
            emotionService.addEmotion(addEmotion);
        }
    }
}
