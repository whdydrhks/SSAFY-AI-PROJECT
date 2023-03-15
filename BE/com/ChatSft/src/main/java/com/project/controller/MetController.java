package com.project.controller;

import com.project.model.dto.request.MetRequestDto;
import com.project.model.service.MetService;
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
@Api("메트 컨트롤러 API v1")
@RequestMapping("/api/v1/met")
@RestController
@RequiredArgsConstructor
public class MetController {
    
    private MetService metService;
    
    @Autowired
    public MetController(MetService metService) {
        this.metService = metService;
    }
    
    /**
     * 메트 추가
     *
     * @param addMet
     * @return response
     */
    @PostMapping("/add")
    public ResponseEntity<?> addMet(@RequestBody MetRequestDto.AddMet addMet) {
        return metService.addMet(addMet);
    }
}
