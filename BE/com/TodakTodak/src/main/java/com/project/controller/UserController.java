package com.project.controller;

import com.project.model.dto.request.UserRequestDto;
import com.project.model.dto.request.UserRequestDto.Grant;
import com.project.model.dto.request.UserRequestDto.Login;
import com.project.model.dto.request.UserRequestDto.Reissue;
import com.project.model.dto.request.UserRequestDto.Signup;
import com.project.model.service.UserService;
import io.swagger.annotations.Api;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/v1/user")
@RestController
@Api("사용자 컨트롤러 API v1")
public class UserController {
    
    private final UserService userService;
    
    /**
     * 회원 가입
     * 닉네임, 장치번호
     * 장치번호를 암호화해서 device, password 저장
     *
     * @param signup 닉네임, 장치번호
     * @return response
     */
    @PostMapping("/sign-up")
    public ResponseEntity<?> signup(@RequestBody Signup signup) {
        return userService.signup(signup);
    }
    
    /**
     * 로그인 (토큰 발급)
     *
     * @param login 닉네임, 장치번호
     * @return response
     */
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Login login) {
        return userService.login(login);
    }
    
    /**
     * 로그아웃 (토큰 삭제)
     *
     * @param accessToken  엑세스 토큰
     * @param refreshToken 리프레시 토큰
     * @return response
     */
    @PostMapping("/logout")
    public ResponseEntity<?> logout(@RequestHeader("Authorization") String accessToken,
            @CookieValue("refreshToken") String refreshToken) {
        accessToken = accessToken.substring(7);
        UserRequestDto.Logout logout = new UserRequestDto.Logout(accessToken, refreshToken);
        return userService.logout(logout);
    }
    
    /**
     * 백업 (비밀번호 변경)
     *
     * @param accessToken  엑세스 토큰
     * @param refreshToken 리프레시 토큰
     * @param request      비밀번호
     * @return response
     */
    @PutMapping("/backup")
    public ResponseEntity<?> backupUser(@RequestHeader("Authorization") String accessToken,
            @CookieValue("refreshToken") String refreshToken, @RequestBody Map<String, String> request) {
        accessToken = accessToken.substring(7);
        String                newPassword = request.get("newPassword");
        UserRequestDto.Backup backup      = new UserRequestDto.Backup(accessToken, refreshToken, newPassword);
        return userService.backupUser(backup);
    }
    
    /**
     * 회원 비활성화
     * 회원, 작성한 일기 비활성화
     * 일기의 감정, 만남, 상세 비활성화
     *
     * @param accessToken  엑세스 토큰
     * @param refreshToken 리프레시 토큰
     * @return response
     */
    @PutMapping("/delete")
    public ResponseEntity<?> deleteUser(@RequestHeader("Authorization") String accessToken,
            @CookieValue("refreshToken") String refreshToken) {
        accessToken = accessToken.substring(7);
        UserRequestDto.Delete delete = new UserRequestDto.Delete(accessToken, refreshToken);
        return userService.deleteUser(delete);
    }
    
    /**
     * 토큰 재발행
     *
     * @param accessToken  엑세스 토큰
     * @param refreshToken 리프레시 토큰
     * @return response
     */
    @PostMapping("/reissue")
    public ResponseEntity<?> reissue(@RequestHeader("Authorization") String accessToken,
            @CookieValue("refreshToken") String refreshToken) {
        accessToken = accessToken.substring(7);
        Reissue reissue = new Reissue(accessToken, refreshToken);
        return userService.reissue(reissue);
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
        return userService.grantAdmin(grant);
    }
    // ======================================= ADMIN =======================================
    
    @GetMapping("")
    public ResponseEntity<?> findAllUser() {
        return userService.findAllUser();
    }
    
    @GetMapping("/id/{userId}")
    public ResponseEntity<?> findUserByUserId(@PathVariable Long userId) {
        return userService.findUserByUserId(userId);
    }
    
    @GetMapping("/nickname/{userNickname}")
    public ResponseEntity<?> findUserByUserNickname(@PathVariable String userNickname) {
        return userService.findUserByUserNickname(userNickname);
    }
}
