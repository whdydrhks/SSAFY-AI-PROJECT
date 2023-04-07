package com.project.controller;

import com.project.model.dto.request.UserRequestDto.Login;
import com.project.model.dto.request.UserRequestDto.Reissue;
import com.project.model.dto.request.UserRequestDto.Signup;
import com.project.model.service.UserService;
import io.swagger.annotations.Api;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
        log.info("UserController.signup");
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
        log.info("UserController.login");
        return userService.login(login);
    }
    
    /**
     * 로그아웃 (토큰 삭제)
     *
     * @param accessToken 엑세스 토큰
     * @return response
     */
    @PostMapping("/logout")
    public ResponseEntity<?> logout(@RequestHeader("Authorization") String accessToken) {
        log.info("UserController.logout");
        accessToken = accessToken.substring(7);
        return userService.logout(accessToken);
    }
    
    /**
     * 백업 (비밀번호 변경)
     *
     * @param accessToken 엑세스 토큰
     * @param request     비밀번호
     * @return response
     */
    @PutMapping("/backup")
    public ResponseEntity<?> backupUser(@RequestHeader("Authorization") String accessToken,
            @RequestBody Map<String, String> request) {
        log.info("UserController.backupUser");
        accessToken = accessToken.substring(7);
        String newPassword = request.get("newPassword");
        return userService.backupUser(accessToken, newPassword);
    }
    
    /**
     * 로드 (비밀번호 확인)
     * 백업한 계정으로 로그인
     * 장치번호를 암호화해서 device, password 갱신
     *
     * @param request userNickname, userPassword, userDevice
     * @return response
     */
    @PutMapping("/load")
    public ResponseEntity<?> loadUser(@RequestBody Map<String, String> request) {
        log.info("UserController.loadUser");
        String userNickname = request.get("userNickname");
        String userPassword = request.get("userPassword");
        String userDevice   = request.get("userDevice");
        return userService.loadUser(userNickname, userPassword, userDevice);
    }
    
    /**
     * 회원 비활성화
     * 회원, 작성한 일기 비활성화
     * 일기의 감정, 만남, 상세 비활성화
     *
     * @param accessToken 엑세스 토큰
     * @return response
     */
    @PutMapping("/delete")
    public ResponseEntity<?> deleteUser(@RequestHeader("Authorization") String accessToken) {
        log.info("UserController.deleteUser");
        accessToken = accessToken.substring(7);
        return userService.deleteUser(accessToken);
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
        log.info("UserController.reissue");
        accessToken = accessToken.substring(7);
        Reissue reissue = new Reissue(accessToken, refreshToken);
        return userService.reissue(reissue);
    }
}
