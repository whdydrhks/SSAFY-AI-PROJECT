package com.project.controller;

import com.project.model.service.AnalyzeService;
import io.swagger.annotations.Api;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;
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
     * 1. 지정한 연, 월의 일자별 평점 조회
     * 2. top5 조회
     * 3. 평점별 아이콘 조회
     *
     * @param accessToken        accessToken
     * @param LocalDateYearMonth 연월
     * @return response
     */
    @GetMapping("/{LocalDateYearMonth}")
    public ResponseEntity<?> findGraphByUser(@RequestHeader("Authorization") String accessToken,
            @PathVariable String LocalDateYearMonth) {
        accessToken = accessToken.substring(7);
        int year  = Integer.parseInt(LocalDateYearMonth.substring(0, 4));
        int month = Integer.parseInt(LocalDateYearMonth.substring(4, 6));
        return analyzeService.findGraphByUser(accessToken, year, month);
    }
}
