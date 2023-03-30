package com.project.model.service;

import com.project.model.dto.Response;
import com.project.model.dto.request.EmotionRequestDto.AddEmotion;
import com.project.model.entity.Emotion;
import com.project.model.repository.EmotionRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class EmotionService {
    
    private Response          response;
    private EmotionRepository emotionRepository;
    
    @Autowired
    public EmotionService(Response response, EmotionRepository emotionRepository) {
        this.response          = response;
        this.emotionRepository = emotionRepository;
    }
    
    /**
     * 감정 추가
     * 중복 검사
     * todo ROLE_ADMIN 권한 필요
     *
     * @param addEmotion
     * @return response
     */
    public ResponseEntity<?> addEmotion(AddEmotion addEmotion) {
        if (emotionRepository.existsEmotionByEmotionName(addEmotion.getEmotionName())) {
            return response.fail("이미 존재하는 감정입니다.", HttpStatus.BAD_REQUEST);
        }
        
        Emotion emotion = Emotion.builder()
                .emotionName(addEmotion.getEmotionName())
                .build();
        emotionRepository.save(emotion);
        
        return response.success("감정 추가에 성공했습니다.");
    }
}
