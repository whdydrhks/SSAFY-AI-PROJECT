package com.project.controller;

import com.project.model.dto.request.DiaryRequestDto.AddDiary;
import com.project.model.dto.request.DiaryRequestDto.DeleteDiary;
import com.project.model.dto.request.DiaryRequestDto.UpdateDiary;
import com.project.model.service.DiaryService;
import io.swagger.annotations.Api;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/v1/diary")
@RestController
@Api("다이어리 컨트롤러 API v1")
public class DiaryController {
    
    private DiaryService diaryService;
    
    @Autowired
    public DiaryController(DiaryService diaryService) {
        this.diaryService = diaryService;
    }
    
    
    /**
     * 다이어리 추가
     *
     * @param accessToken access token
     * @param addDiary    다이어리 추가 요청 dto
     * @return response
     */
    @PostMapping("/add")
    public ResponseEntity<?> addDiary(@RequestHeader("Authorization") String accessToken,
            @RequestBody AddDiary addDiary) {
        log.info("DiaryController.addDiary");
        return diaryService.addDiary(accessToken.substring(7), addDiary);
    }
    
    /**
     * 다이어리 수정
     *
     * @param accessToken access token
     * @param updateDiary 다이어리 수정 요청 dto
     * @return response
     */
    @PutMapping("/update")
    public ResponseEntity<?> updateDiary(@RequestHeader("Authorization") String accessToken,
            @RequestBody UpdateDiary updateDiary) {
        log.info("DiaryController.updateDiary");
        return diaryService.updateDiary(accessToken.substring(7), updateDiary);
    }
    
    /**
     * 다이어리 삭제
     *
     * @param accessToken access token
     * @param deleteDiary 다이어리 삭제 요청 dto
     * @return response
     */
    @PutMapping("/delete")
    public ResponseEntity<?> deleteDiary(@RequestHeader("Authorization") String accessToken,
            @RequestBody DeleteDiary deleteDiary) {
        log.info("DiaryController.deleteDiary");
        return diaryService.deleteDiary(accessToken.substring(7), deleteDiary);
    }
    
    /**
     * 다이어리 상세 조회
     *
     * @param accessToken access token
     * @param diaryId     다이어리 id
     * @return response
     */
    @GetMapping("/{diaryId}")
    public ResponseEntity<?> findDiaryById(@RequestHeader("Authorization") String accessToken,
            @PathVariable Long diaryId) {
        log.info("DiaryController.findDiaryById");
        return diaryService.findDiaryById(accessToken.substring(7), diaryId);
    }
    
    /**
     * 유저 토큰으로 다이어리 조회
     *
     * @param accessToken access token
     * @return response
     */
    @GetMapping("/user")
    public ResponseEntity<?> findDiaryByUserId(@RequestHeader("Authorization") String accessToken) {
        log.info("DiaryController.findDiaryByUserId");
        return diaryService.findDiaryByUserId(accessToken.substring(7));
    }
    
    /**
     * 달력에 표시할 다이어리 조회
     *
     * @param accessToken access token
     * @return response
     */
    @GetMapping("/calendar")
    public ResponseEntity<?> findDiaryByUserIdForCalendar(@RequestHeader("Authorization") String accessToken) {
        log.info("DiaryController.findDiaryByUserIdForCalendar");
        return diaryService.findDiaryByUserIdForCalendar(accessToken.substring(7));
    }
}
