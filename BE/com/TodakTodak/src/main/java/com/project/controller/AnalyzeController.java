package com.project.controller;

import com.project.model.dto.request.AnalyzeRequestDto;
import com.project.model.service.AnalyzeService;
import io.swagger.annotations.Api;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
    
    @GetMapping("/graph")
    public ResponseEntity<?> findGraphByUserId(@RequestBody AnalyzeRequestDto.Graph graph) {
        return analyzeService.findGraphByUserId(graph);
    }
}
