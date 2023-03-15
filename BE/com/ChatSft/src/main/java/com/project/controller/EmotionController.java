package com.project.controller;

import com.project.model.dto.request.EmotionRequestDto;
import com.project.model.service.EmotionService;
import io.swagger.annotations.Api;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@Api("감정 컨트롤러 API v1")
@RequiredArgsConstructor
@RequestMapping("/api/v1/emotion")
@RestController
public class EmotionController {
    
    private EmotionService emotionService;
    
    @Autowired
    public EmotionController(EmotionService emotionService) {
        this.emotionService = emotionService;
    }
    
    /**
     * 감정 추가
     * 중복 검사
     * todo ROLE_ADMIN 권한 필요
     *
     * @param addEmotion
     * @return response
     */
    @PostMapping("/add")
    public ResponseEntity<?> addEmotion(@RequestBody EmotionRequestDto.AddEmotion addEmotion) {
        return emotionService.addEmotion(addEmotion);
    }
}
