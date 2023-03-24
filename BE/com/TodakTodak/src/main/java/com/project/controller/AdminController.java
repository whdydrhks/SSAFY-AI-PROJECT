package com.project.controller;

import com.project.model.dto.request.AdminRequestDto.AdminSignup;
import com.project.model.service.AdminService;
import io.swagger.annotations.Api;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
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
     * 관리자 권한 부여
     *
     * @param accessToken access token
     * @param request     userId : 유저 아이디
     * @return response
     */
    @PostMapping("/grant-admin")
    public ResponseEntity<?> grantAdmin(@RequestHeader("Authorization") String accessToken,
            @RequestBody Map<String, String> request) {
        accessToken = accessToken.substring(7);
        Long userId = Long.parseLong(request.get("userId"));
        return adminService.grantAdmin(accessToken, userId);
    }
}
