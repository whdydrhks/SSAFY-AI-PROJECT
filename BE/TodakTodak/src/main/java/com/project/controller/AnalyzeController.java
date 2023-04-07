package com.project.controller;

import com.project.model.service.AnalyzeService;
import io.swagger.annotations.Api;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
     * @param accessToken accessToken
     * @param year        year
     * @param month       month
     * @return response
     */
    @GetMapping("")
    public ResponseEntity<?> findGraphByUser(@RequestHeader("Authorization") String accessToken,
            @RequestParam("year") int year, @RequestParam("month") int month) {
        log.info("AnalyzeController.findGraphByUser");
        accessToken = accessToken.substring(7);
        return analyzeService.findGraphByUser(accessToken, year, month);
    }
}
