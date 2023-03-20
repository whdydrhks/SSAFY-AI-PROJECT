package com.project;

import com.project.model.dto.request.DiaryRequestDto;
import com.project.model.dto.request.EmotionRequestDto;
import com.project.model.dto.request.EmotionRequestDto.AddEmotion;
import com.project.model.dto.request.MetRequestDto;
import com.project.model.dto.request.MetRequestDto.AddMet;
import com.project.model.dto.request.UserRequestDto.SignUp;
import com.project.model.entity.Diary;
import com.project.model.repository.DiaryRepository;
import com.project.model.service.DiaryService;
import com.project.model.service.EmotionService;
import com.project.model.service.MetService;
import com.project.model.service.UserService;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
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

    private final initService     initService;
    private final DiaryRepository diaryRepository;

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

        // 회원 6명 생성 + 기기번호는 4자리의 랜덤값
        String[]    name          = {"정현석", "소채린", "조용관", "김지환", "이지은", "류원창"};
        Set<String> deviceNumbers = new HashSet<>();
        Random      random        = new Random();
        while (deviceNumbers.size() < 10000) {
            int    randomInt       = random.nextInt(10000);
            String formattedString = String.format("%04d", randomInt);
            deviceNumbers.add(formattedString);
        }
        int index = 0;
        for (String n : name) {
            String deviceNumber = deviceNumbers.toArray(new String[0])[index++];
            initService.userInit(n, deviceNumber);
        }

        // 일기 10 / 1개씩 생성
        String[] diaryExamples = {
                "오늘은 날씨가 정말 좋았다.",
                "친구들과 함께 영화를 보고 왔다.",
                "새로운 도전으로 요리를 시도해봤다.",
                "집에서 편안한 하루를 보냈다.",
                "운동을 시작하기로 결심했다."
        };

        for (long userIndex = 1; userIndex <= 6; userIndex++) {
            int diaryCountPerUser = userIndex == 6 ? 10 : 1;
            for (int i = 1; i <= diaryCountPerUser; i++) {
                Long            userId      = userIndex;
                int             randomIndex = random.nextInt(diaryExamples.length);
                String          content     = diaryExamples[randomIndex];
                int             rating      = random.nextInt(5) + 1;
                ArrayList<Long> emotions    = generateRandomArrayList(1, 5, random);
                ArrayList<Long> people      = generateRandomArrayList(1, 5, random);

                int        arraySize        = 5;
                List<Long> lineEmotionCount = new ArrayList<>();
                for (int j = 0; j < arraySize; j++) {
                    lineEmotionCount.add((long) random.nextInt(6));
                }

                DiaryRequestDto.AddDiary addDiary = new DiaryRequestDto.AddDiary(content, rating, emotions, people,
                        userId, lineEmotionCount);

                initService.diaryInit(addDiary);

                // 작성 일자 조작
                LocalDateTime localDateTime = LocalDateTime.now().minus(i, ChronoUnit.DAYS);
                // 가장 마지막에 저장된 다이어리 조회
                Diary diary = diaryRepository.findTopByOrderByDiaryIdDesc();
                diary.setDiaryCreateDate(localDateTime);
                diaryRepository.save(diary);
            }
        }
    }

    // minSize ~ maxSize 사이의 랜덤한 크기의 ArrayList<Long> 생성
    public static ArrayList<Long> generateRandomArrayList(int min, int max, Random random) {
        int           arraySize = random.nextInt(max - min + 1) + min;
        HashSet<Long> randomSet = new HashSet<>();

        while (randomSet.size() < arraySize) {
            randomSet.add((long) (random.nextInt(max) + 1));
        }

        return new ArrayList<>(randomSet);
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
    }
}
