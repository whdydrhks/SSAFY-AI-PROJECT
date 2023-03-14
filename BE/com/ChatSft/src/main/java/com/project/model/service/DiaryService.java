package com.project.model.service;

import com.project.model.dto.Response;
import com.project.model.dto.request.DiaryRequestDto.AddDiary;
import com.project.model.dto.response.DiaryResponseDto;
import com.project.model.entity.Diary;
import com.project.model.entity.DiaryEmotion;
import com.project.model.entity.DiaryMet;
import com.project.model.entity.Met;
import com.project.model.repository.DiaryEmotionRepository;
import com.project.model.entity.Emotion;
import com.project.model.repository.DiaryMetRepository;
import com.project.model.repository.DiaryRepository;
import com.project.model.repository.EmotionRepository;
import com.project.model.repository.MetRepository;
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
    
    @Autowired
    public DiaryService(Response response, DiaryRepository diaryRepository, EmotionRepository emotionRepository,
            DiaryEmotionRepository diaryEmotionRepository, MetRepository metRepository,
            DiaryMetRepository diaryMetRepository) {
        this.response               = response;
        this.diaryRepository        = diaryRepository;
        this.emotionRepository      = emotionRepository;
        this.diaryEmotionRepository = diaryEmotionRepository;
        this.metRepository          = metRepository;
        this.diaryMetRepository     = diaryMetRepository;
    }
    
    /**
     * 다이어리 추가
     *
     * @param addDiary
     * @return response
     */
    public ResponseEntity<?> addDiary(AddDiary addDiary) {
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
        
        Diary diary = Diary.builder()
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
                .map(DiaryResponseDto::new)
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
        
        DiaryResponseDto diaryResponseDto = new DiaryResponseDto(diary);
        
        return response.success(diaryResponseDto);
    }
}
