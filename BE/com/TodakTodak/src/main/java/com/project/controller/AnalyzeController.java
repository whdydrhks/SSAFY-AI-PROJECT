package com.project.controller;

import com.project.model.service.AnalyzeService;
import io.swagger.annotations.Api;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/api/v1/analyze")
@RequiredArgsConstructor
@Slf4j
@RestController
@Api("분석 컨트롤러 API v1")
public class AnalyzeController {
    
    private AnalyzeService analyzeService;
    
    @Autowired
    public AnalyzeController(AnalyzeService analyzeService) {
        this.analyzeService = analyzeService;
    }
    
    /**
     * 사용자의 분석 데이터를 조회한다.
     *
     * @param userId
     * @return response
     */
    @GetMapping("/graph/{userId}")
    public ResponseEntity<?> findGraphByUserId(@PathVariable Long userId) {
        return analyzeService.findGraphByUserId(userId);
    }
}
