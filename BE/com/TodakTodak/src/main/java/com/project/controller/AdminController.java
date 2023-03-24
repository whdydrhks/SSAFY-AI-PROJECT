package com.project.controller;

import com.project.model.dto.request.AdminRequestDto.AdminSignup;
import com.project.model.dto.request.UserRequestDto.Grant;
import com.project.model.service.AdminService;
import io.swagger.annotations.Api;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/v1/admin")
@RestController
@Api("관리자 컨트롤러 API v1")
public class AdminController {
    
    private AdminService adminService;
    
    @Autowired
    public AdminController(AdminService adminService) {
        this.adminService = adminService;
    }
    
    /**
     * 관리자 회원 가입
     *
     * @param adminSignup 패스워드, 닉네임, 장치번호
     * @return response
     */
    @PostMapping("/sign-up")
    public ResponseEntity<?> adminSignup(@RequestBody AdminSignup adminSignup) {
        return adminService.adminSignup(adminSignup);
    }
    
    /**
     * 모든 유저 조회
     *
     * @return response
     */
    @GetMapping("/user")
    public ResponseEntity<?> findAllTrueUser() {
        return adminService.findAllTrueUser();
    }
    
    /**
     * 모든 다이어리 조회
     *
     * @return response
     */
    @GetMapping("/diary")
    public ResponseEntity<?> findAllTrueDiary() {
        return adminService.findAllTrueDiary();
    }
    
    /**
     * 관리자 권한 부여
     *
     * @param accessToken  엑세스 토큰
     * @param refreshToken 리프레시 토큰
     * @param request      userId
     * @return response
     */
    @PostMapping("/grant-admin")
    public ResponseEntity<?> grantAdmin(@RequestHeader("Authorization") String accessToken,
            @CookieValue("refreshToken") String refreshToken, @RequestBody Map<String, String> request) {
        accessToken = accessToken.substring(7);
        Long  userId = Long.parseLong(request.get("userId"));
        Grant grant  = new Grant(accessToken, refreshToken, userId);
        return adminService.grantAdmin(grant);
    }
}
