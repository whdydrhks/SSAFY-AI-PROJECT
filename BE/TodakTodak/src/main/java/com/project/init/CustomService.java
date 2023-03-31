//package com.project.init;
//
//import com.project.library.EncryptDecrypt;
//import com.project.model.dto.request.UserRequestDto.Signup;
//import com.project.model.entity.Diary;
//import com.project.model.entity.DiaryDetail;
//import com.project.model.entity.DiaryEmotion;
//import com.project.model.entity.DiaryMet;
//import com.project.model.entity.Emotion;
//import com.project.model.entity.Met;
//import com.project.model.entity.User;
//import com.project.model.enums.Authority;
//import com.project.model.repository.DiaryDetailRepository;
//import com.project.model.repository.DiaryEmotionRepository;
//import com.project.model.repository.DiaryMetRepository;
//import com.project.model.repository.DiaryRepository;
//import com.project.model.repository.EmotionRepository;
//import com.project.model.repository.MetRepository;
//import com.project.model.repository.UserRepository;
//import java.util.ArrayList;
//import java.util.Collections;
//import java.util.List;
//import org.springframework.security.crypto.password.PasswordEncoder;
//import org.springframework.stereotype.Service;
//
///**
// * 초기 회원, 감정, 관계, 일기 등을 미리 등록하는 클래스
// * 유저, 일기 추가하는 과정에서 필요한 인증 과정 생략
// * 출시 이후는 주석 처리
// */
//@Service
//public class CustomService {
//
//    private DiaryRepository        diaryRepository;
//    private UserRepository         userRepository;
//    private EmotionRepository      emotionRepository;
//    private MetRepository          metRepository;
//    private DiaryEmotionRepository diaryEmotionRepository;
//    private DiaryMetRepository     diaryMetRepository;
//    private DiaryDetailRepository  diaryDetailRepository;
//    private PasswordEncoder        passwordEncoder;
//    private EncryptDecrypt         encryptDecrypt;
//
//    public CustomService(DiaryRepository diaryRepository, UserRepository userRepository,
//            EmotionRepository emotionRepository, MetRepository metRepository,
//            DiaryEmotionRepository diaryEmotionRepository,
//            DiaryMetRepository diaryMetRepository, DiaryDetailRepository diaryDetailRepository,
//            PasswordEncoder passwordEncoder, EncryptDecrypt encryptDecrypt) {
//        this.diaryRepository        = diaryRepository;
//        this.userRepository         = userRepository;
//        this.emotionRepository      = emotionRepository;
//        this.metRepository          = metRepository;
//        this.diaryEmotionRepository = diaryEmotionRepository;
//        this.diaryMetRepository     = diaryMetRepository;
//        this.diaryDetailRepository  = diaryDetailRepository;
//        this.passwordEncoder        = passwordEncoder;
//        this.encryptDecrypt         = encryptDecrypt;
//    }
//
//    public void forceAddUser(Signup signup) {
//        // 유저 저장
//        String userNickname = signup.getUserNickname();
//        User user = User.builder()
//                .userNickname(userNickname)
//                .userDevice(passwordEncoder.encode(signup.getUserDevice()))
//                .userPassword(passwordEncoder.encode(signup.getUserDevice()))
//                .roles(Collections.singletonList(Authority.ROLE_USER.name()))
//                .userStatus(true)
//                .build();
//        userRepository.save(user);
//    }
//
//    public void forceAddDiary(String content, int rating, ArrayList<Long> emotions, ArrayList<Long> people, Long userId,
//            List<Long> lineEmotionCount) {
//        User  user  = userRepository.findById(userId).get();
//        Diary diary = new Diary();
//        diary.setDiaryContent(encryptDecrypt.encrypt(content));
//        diary.setDiaryScore(rating);
//        diary.setUser(user);
//        diary.setDiaryStatus(true);
//
//        // 다이어리에 속한 감정 리스트를 생성합니다.
//        List<DiaryEmotion> diaryEmotions = new ArrayList<>();
//        for (Long emotionId : emotions) {
//            // 감정을 가져옵니다.
//            Emotion emotion = emotionRepository.findById(emotionId)
//                    .orElseThrow(() -> new RuntimeException("Emotion not found"));
//            DiaryEmotion diaryEmotion = new DiaryEmotion();
//            diaryEmotion.setDiaryEmotionStatus(true);
//            diaryEmotion.setDiary(diary);
//            diaryEmotion.setEmotion(emotion);
//            diaryEmotions.add(diaryEmotion);
//        }
//
//        List<DiaryMet> diaryMets = new ArrayList<>();
//        for (Long metId : people) {
//            // 메트를 가져옵니다.
//            Met met = metRepository.findById(metId)
//                    .orElseThrow(() -> new RuntimeException("Met not found"));
//            DiaryMet diaryMet = new DiaryMet();
//            diaryMet.setDiaryMetStatus(true);
//            diaryMet.setDiary(diary);
//            diaryMet.setMet(met);
//            diaryMets.add(diaryMet);
//        }
//
//        diary.setDiaryEmotions(diaryEmotions);
//        diary.setDiaryMets(diaryMets);
//
//        // 다이어리 감정 갯수 작업
//        DiaryDetail diaryDetail = new DiaryDetail();
//        diaryDetail.setDiary(diary);
//        diaryDetail.setDiaryDetailHappyCount(lineEmotionCount.get(0));
//        diaryDetail.setDiaryDetailAnxietyCount(lineEmotionCount.get(1));
//        diaryDetail.setDiaryDetailSadCount(lineEmotionCount.get(2));
//        diaryDetail.setDiaryDetailAngryCount(lineEmotionCount.get(3));
//        diaryDetail.setDiaryDetailHurtCount(lineEmotionCount.get(4));
//        diaryDetail.setDiaryDetailStatus(true);
//        diary.setDiaryDetail(diaryDetail);
//
//        // 다이어리 저장
//        diaryRepository.save(diary);
//        diaryEmotionRepository.saveAll(diaryEmotions);
//        diaryMetRepository.saveAll(diaryMets);
//        diaryDetailRepository.save(diaryDetail);
//    }
//}
