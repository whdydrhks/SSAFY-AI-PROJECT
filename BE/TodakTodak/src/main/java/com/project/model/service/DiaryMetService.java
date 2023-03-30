package com.project.model.service;

import com.project.model.dto.Response;
import com.project.model.repository.DiaryMetRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class DiaryMetService {
    
    private Response           response;
    private DiaryMetRepository diaryMetRepository;
    
    @Autowired
    public DiaryMetService(Response response, DiaryMetRepository diaryMetRepository) {
        this.response           = response;
        this.diaryMetRepository = diaryMetRepository;
    }
}
