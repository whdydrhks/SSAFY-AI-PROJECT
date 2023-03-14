package com.project.model.service;

import com.project.model.dto.Response;
import com.project.model.repository.DiaryEmotionRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class DiaryEmotionService {
    
    private Response               response;
    private DiaryEmotionRepository diaryEmotionRepository;
    
    @Autowired
    public DiaryEmotionService(Response response, DiaryEmotionRepository diaryEmotionRepository) {
        this.response               = response;
        this.diaryEmotionRepository = diaryEmotionRepository;
    }
}
