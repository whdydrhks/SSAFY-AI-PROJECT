package com.project.model.service;

import com.project.model.dto.Response;
import com.project.model.dto.request.DiaryRequestDto.AddDiary;
import com.project.model.dto.response.DiaryResponseDto;
import com.project.model.entity.Diary;
import com.project.model.entity.DiaryEmotion;
import com.project.model.entity.DiaryMet;
import com.project.model.entity.Emotion;
import com.project.model.entity.Met;
import com.project.model.entity.User;
import com.project.model.repository.DiaryEmotionRepository;
import com.project.model.repository.DiaryMetRepository;
import com.project.model.repository.DiaryRepository;
import com.project.model.repository.EmotionRepository;
import com.project.model.repository.MetRepository;
import com.project.model.repository.UserRepository;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class DiaryService {
    
    
    private Response               response;
    private DiaryRepository        diaryRepository;
    private EmotionRepository      emotionRepository;
    private DiaryEmotionRepository diaryEmotionRepository;
    private MetRepository          metRepository;
    private DiaryMetRepository     diaryMetRepository;
    private UserRepository         userRepository;
    
    @Autowired
    public DiaryService(Response response, DiaryRepository diaryRepository, EmotionRepository emotionRepository,
            DiaryEmotionRepository diaryEmotionRepository, MetRepository metRepository,
            DiaryMetRepository diaryMetRepository, UserRepository userRepository) {
        this.response               = response;
        this.diaryRepository        = diaryRepository;
        this.emotionRepository      = emotionRepository;
        this.diaryEmotionRepository = diaryEmotionRepository;
        this.metRepository          = metRepository;
        this.diaryMetRepository     = diaryMetRepository;
        this.userRepository         = userRepository;
    }
    
    private DiaryResponseDto toDiaryDto(Diary diary) {
        DiaryResponseDto diaryResponseDto = new DiaryResponseDto();
        diaryResponseDto.setDiaryId(diary.getDiaryId());
        diaryResponseDto.setDiaryContent(diary.getDiaryContent());
        diaryResponseDto.setDiaryScore(diary.getDiaryScore());
        diaryResponseDto.setDiaryEmotion(diary.getDiaryEmotions().stream()
                .map(de -> de.getEmotion().getEmotionId())
                .collect(Collectors.toList()));
        diaryResponseDto.setDiaryMet(diary.getDiaryMets().stream()
                .map(dm -> dm.getMet().getMetId())
                .collect(Collectors.toList()));
        return diaryResponseDto;
    }
    
    /**
     * 다이어리 추가
     *
     * @param addDiary
     * @return response
     */
    public ResponseEntity<?> addDiary(AddDiary addDiary) {
        // 존재하는 값인지 검증
        Optional<Emotion> optionalEmotion = emotionRepository.findById(addDiary.getDiaryEmotionId());
        if (optionalEmotion.isEmpty()) {
            return response.fail("존재하지 않는 감정입니다.", HttpStatus.BAD_REQUEST);
        }
        Emotion emotion = optionalEmotion.get();
        
        Optional<Met> optionalMet = metRepository.findById(addDiary.getDiaryMetId());
        if (optionalMet.isEmpty()) {
            return response.fail("존재하지 않는 메트입니다.", HttpStatus.BAD_REQUEST);
        }
        Met met = optionalMet.get();
        
        Optional<User> optionalUser = userRepository.findById(addDiary.getUserId());
        if (optionalUser.isEmpty()) {
            return response.fail("존재하지 않는 유저입니다.", HttpStatus.BAD_REQUEST);
        }
        User user = optionalUser.get();
        
        // 저장
        Diary diary = Diary.builder()
                .user(user)
                .diaryContent(addDiary.getDiaryContent())
                .diaryScore(addDiary.getDiaryScore())
                .diaryStatus(true)
                .build();
        
        DiaryEmotion diaryEmotion = DiaryEmotion.builder()
                .diary(diary)
                .emotion(emotion)
                .build();
        
        DiaryMet diaryMet = DiaryMet.builder()
                .diary(diary)
                .met(met)
                .build();
        
        emotionRepository.save(emotion);
        metRepository.save(met);
        diaryRepository.save(diary);
        diaryEmotionRepository.save(diaryEmotion);
        diaryMetRepository.save(diaryMet);
        return response.success("다이어리 추가에 성공했습니다.");
    }
    
    /**
     * 다이어리 전체 조회
     *
     * @return response
     */
    public ResponseEntity<?> findAllDiary() {
        List<Diary> findDiaries = diaryRepository.findAll();
        
        if (findDiaries.isEmpty()) {
            return response.fail("다이어리가 존재하지 않습니다.", HttpStatus.BAD_REQUEST);
        }
        
        List<DiaryResponseDto> diaryResponseDtos = findDiaries.stream()
                .map(this::toDiaryDto)
                .collect(Collectors.toList());
        
        return response.success(diaryResponseDtos);
    }
    
    /**
     * 다이어리 상세 조회
     *
     * @param diaryId
     * @return response
     */
    public ResponseEntity<?> findDiaryById(Long diaryId) {
        Optional<Diary> optionalDiary = diaryRepository.findById(diaryId);
        if (optionalDiary.isEmpty()) {
            return response.fail("존재하지 않는 다이어리입니다.", HttpStatus.BAD_REQUEST);
        }
        Diary diary = optionalDiary.get();
        return response.success(toDiaryDto(diary));
    }
}
