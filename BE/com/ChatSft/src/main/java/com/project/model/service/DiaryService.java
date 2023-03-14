package com.project.model.service;

import com.project.model.dto.Response;
import com.project.model.dto.request.DiaryRequestDto.AddDiary;
import com.project.model.dto.response.DiaryResponseDto;
import com.project.model.entity.Diary;
import com.project.model.entity.DiaryEmotion;
import com.project.model.repository.DiaryEmotionRepository;
import com.project.model.entity.Emotion;
import com.project.model.repository.DiaryRepository;
import com.project.model.repository.EmotionRepository;
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
    
    @Autowired
    public DiaryService(Response response, DiaryRepository diaryRepository, EmotionRepository emotionRepository,
            DiaryEmotionRepository diaryEmotionRepository) {
        this.response               = response;
        this.diaryRepository        = diaryRepository;
        this.emotionRepository      = emotionRepository;
        this.diaryEmotionRepository = diaryEmotionRepository;
    }
    
    public ResponseEntity<?> addDiary(AddDiary addDiary) {
        Optional<Emotion> optionalEmotion = emotionRepository.findById(addDiary.getDiaryEmotionId());
        if (optionalEmotion.isEmpty()) {
            return response.fail("존재하지 않는 감정입니다.", HttpStatus.BAD_REQUEST);
        }
        Emotion emotion = optionalEmotion.get();
        
        Diary diary = Diary.builder()
                .diaryContent(addDiary.getDiaryContent())
                .diaryScore(addDiary.getDiaryScore())
                .diaryStatus(true)
                .build();
        
        DiaryEmotion diaryEmotion = DiaryEmotion.builder()
                .diary(diary)
                .emotion(emotion)
                .build();
        
        emotionRepository.save(emotion);
        diaryRepository.save(diary);
        diaryEmotionRepository.save(diaryEmotion);
        return response.success("다이어리 추가에 성공했습니다.");
    }
    
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
