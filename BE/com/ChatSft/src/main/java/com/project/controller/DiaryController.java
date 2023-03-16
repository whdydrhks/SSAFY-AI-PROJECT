package com.project.controller;

import com.project.model.dto.request.DiaryRequestDto;
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
     * @param addDiary
     * @return response
     */
    @PostMapping("/add")
    public ResponseEntity<?> addDiary(@RequestBody DiaryRequestDto.AddDiary addDiary) {
        return diaryService.addDiary(addDiary);
    }
    
    /**
     * 다이어리 전체 조회
     *
     * @return response
     */
    @GetMapping("")
    public ResponseEntity<?> findAllDiary() {
        return diaryService.findAllDiary();
    }
    
    /**
     * 다이어리 상세 조회
     *
     * @param diaryId
     * @return response
     */
    @GetMapping("/{diaryId}")
    public ResponseEntity<?> findDiaryById(@PathVariable Long diaryId) {
        return diaryService.findDiaryById(diaryId);
    }
    
    /**
     * 다이어리 수정
     *
     * @param updateDiary
     * @return response
     */
    @PutMapping("/update")
    public ResponseEntity<?> updateDiary(@RequestBody DiaryRequestDto.UpdateDiary updateDiary) {
        return diaryService.updateDiary(updateDiary);
    }
    
    /**
     * 다이어리 삭제
     *
     * @param deleteDiary
     * @return response
     */
    @PutMapping("/delete")
    public ResponseEntity<?> deleteDiary(@RequestBody DiaryRequestDto.DeleteDiary deleteDiary) {
        return diaryService.deleteDiary(deleteDiary);
    }
}
