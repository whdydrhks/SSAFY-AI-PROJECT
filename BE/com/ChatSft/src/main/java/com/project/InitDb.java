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
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;
import javax.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

/**
 * 서버 실행시에 회원, 감정, 만남, 일기를 미리 등록해놓는 클래스
 * DDL 설정을 CREATE -> UPDATE 로 변경한다면 필요없는 클래스
 */
@Component
@RequiredArgsConstructor
public class InitDb {
    
    private final initService initService;
    
    @PostConstruct
    public void init() {
        // 감정 생성
        initService.emotionInit("기쁨");
        initService.emotionInit("슬픔");
        initService.emotionInit("화남");
        initService.emotionInit("놀람");
        initService.emotionInit("우울");
        
        // 만난 사람 생성
        initService.metInit("지인");
        initService.metInit("가족");
        initService.metInit("친구");
        initService.metInit("연인");
        initService.metInit("혼자");
        
        // 회원 조합 생성
        String[]    firstName     = {"지후", "서준", "하준", "시우", "도윤", "서윤", "지우", "수아", "하은", "유진"};
        String[]    lastName      = {"김", "이", "박", "최", "정", "강", "조", "윤", "장", "임"};
        Set<String> deviceNumbers = new HashSet<>();
        Random      random        = new Random();
        while (deviceNumbers.size() < 10000) {
            int    randomInt       = random.nextInt(10000);
            String formattedString = String.format("%04d", randomInt);
            deviceNumbers.add(formattedString);
        }
        int index = 0;
        for (String last : lastName) {
            for (String first : firstName) {
                String name         = last + first;
                String deviceNumber = deviceNumbers.toArray(new String[0])[index++];
                initService.userInit(name, deviceNumber);
            }
        }
        
        // 일기 생성 100
        int diaryCount = 100;
        random = new Random();
        for (long i = 1; i <= diaryCount; i++) {
            String          content  = (i % 2 == 1) ? "재밌어요" : "슬퍼요";
            int             rating   = random.nextInt(5) + 1;
            ArrayList<Long> emotions = generateRandomArrayList(1, 5, random);
            ArrayList<Long> people   = generateRandomArrayList(1, 5, random);
            Long            userId   = i;
            
            // lineEmotionCount
            int        arraySize        = 5;
            List<Long> lineEmotionCount = new ArrayList<>();
            for (int j = 0; j < arraySize; j++) {
                lineEmotionCount.add((long) random.nextInt(6));
            }
            
            DiaryRequestDto.AddDiary addDiary = new DiaryRequestDto.AddDiary(content, rating, emotions, people,
                    userId, lineEmotionCount);
            initService.diaryInit(addDiary);
        }
        
        // 일기 수정 100 3의 배수
        for (long i = 1; i <= diaryCount; i += 3) {
            Long            diaryId  = i;
            String          content  = (i % 2 == 1) ? "꿀잼" : "노잼";
            int             rating   = random.nextInt(5) + 1;
            ArrayList<Long> emotions = generateRandomArrayList(1, 5, random);
            ArrayList<Long> people   = generateRandomArrayList(1, 5, random);
            
            // lineEmotionCount
            int        arraySize        = 5;
            List<Long> lineEmotionCount = new ArrayList<>();
            for (int j = 0; j < arraySize; j++) {
                lineEmotionCount.add((long) random.nextInt(6));
            }
            
            DiaryRequestDto.UpdateDiary updateDiary = new DiaryRequestDto.UpdateDiary(diaryId, content, rating,
                    emotions, people, lineEmotionCount);
            initService.diaryUpdate(updateDiary);
        }
        
        // 일기 삭제 100 4의 배수
        DiaryRequestDto.DeleteDiary deleteDiary = new DiaryRequestDto.DeleteDiary();
        for (long i = 1; i <= diaryCount; i += 4) {
            deleteDiary.setDiaryId(i);
            initService.diaryDelete(deleteDiary);
        }
    }
    
    // minSize ~ maxSize 사이의 랜덤한 크기의 ArrayList<Long> 생성
    public static ArrayList<Long> generateRandomArrayList(int minSize, int maxSize, Random random) {
        int             size = random.nextInt(maxSize - minSize + 1) + minSize;
        ArrayList<Long> list = new ArrayList<>();
        
        for (int i = 0; i < size; i++) {
            list.add((long) (random.nextInt(5) + 1));
        }
        
        return list;
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
        
        public void diaryInit(DiaryRequestDto.AddDiary addDiary) {
            diaryService.addDiary(addDiary);
        }
        
        public void diaryDelete(DiaryRequestDto.DeleteDiary deleteDiary) {
            diaryService.deleteDiary(deleteDiary);
        }
        
        public void diaryUpdate(DiaryRequestDto.UpdateDiary updateDiary) {
            diaryService.updateDiary(updateDiary);
        }
    }
}
