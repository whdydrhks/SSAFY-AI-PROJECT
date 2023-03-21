package com.project.controller;

import com.project.library.Helper;
import com.project.library.JwtTokenProvider;
import com.project.model.dto.Response;
import com.project.model.dto.request.UserRequestDto;
import com.project.model.service.UserService;
import io.swagger.annotations.Api;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/v1/user")
@RestController
@Api("사용자 컨트롤러 API v1")
public class UserController {
    
    private final JwtTokenProvider jwtTokenProvider;
    private final UserService      userService;
    private final Response         response;
    
    /**
     * 회원 가입
     * 닉네임, 장치번호
     * 장치번호를 암호화해서 device, password 저장
     *
     * @param signUp 닉네임, 장치번호
     * @return response 닉네임 중복시 실패 / 성공
     */
    @PostMapping("/sign-up")
    public ResponseEntity<?> signUp(@RequestBody @Validated UserRequestDto.SignUp signUp, Errors errors) {
        // validation check
        if (errors.hasErrors()) {
            return response.invalidFields(Helper.refineErrors(errors));
        }
        return userService.signUp(signUp);
    }
    
    /**
     * 전체 회원 조회
     *
     * @return response 회원이 없을 경우 실패 / 성공
     */
    @GetMapping("")
    public ResponseEntity<?> findAllUser() {
        return userService.findAllUser();
    }
    
    /**
     * 회원 번호로 true 회원 조회
     *
     * @param userId
     * @return response 회원이 없을 경우 실패 / 성공
     */
    @GetMapping("/id/{userId}")
    public ResponseEntity<?> findUserByUserId(@PathVariable Long userId) {
        return userService.findUserByUserId(userId);
    }
    
    /**
     * 회원 닉네임으로 true 회원 조회
     *
     * @param userNickname
     * @return response 회원이 없을 경우 실패 / 성공
     */
    @GetMapping("/nickname/{userNickname}")
    public ResponseEntity<?> findUserByUserNickname(@PathVariable String userNickname) {
        return userService.findUserByUserNickname(userNickname);
    }
    
    /**
     * 회원 탈퇴
     * 회원, 작성한 일기 비활성화
     * 일기의 감정, 만남, 상세 비활성화
     *
     * @param userId 회원 번호
     * @return response 회원이 없을 경우 실패 / 성공
     */
    @PutMapping("delete/{userId}")
    public ResponseEntity<?> deleteUserByUserId(@PathVariable Long userId) {
        return userService.deleteUserByUserId(userId);
    }
    
    /**
     * 로그인 (토큰 발급)
     *
     * @param login
     * @param errors
     * @return response
     */
    @PostMapping("/login")
    public ResponseEntity<?> login(@Validated UserRequestDto.Login login, Errors errors) {
        // validation check
        if (errors.hasErrors()) {
            return response.invalidFields(Helper.refineErrors(errors));
        }
        return userService.login(login);
    }
    
    /**
     * 토큰 재발급
     *
     * @param reissue
     * @param errors
     * @return response
     */
    @PostMapping("/reissue")
    public ResponseEntity<?> reissue(@Validated UserRequestDto.Reissue reissue, Errors errors) {
        // validation check
        if (errors.hasErrors()) {
            return response.invalidFields(Helper.refineErrors(errors));
        }
        return userService.reissue(reissue);
    }
    
    /**
     * 로그아웃 (토큰 삭제)
     *
     * @param logout
     * @param errors
     * @return response
     */
    @PostMapping("/logout")
    public ResponseEntity<?> logout(@Validated UserRequestDto.Logout logout, Errors errors) {
        // validation check
        if (errors.hasErrors()) {
            return response.invalidFields(Helper.refineErrors(errors));
            
        }
        return userService.logout(logout);
    }
    
    /**
     * 관리자 권한 부여
     *
     * @return response
     */
    @GetMapping("/authority")
    public ResponseEntity<?> authority() {
        log.info("ADD ROLE_ADMIN");
        return userService.authority();
    }
    
    /**
     * 유저가 유저 권한 가지고 있는지 테스트
     *
     * @return
     */
    @GetMapping("/userTest")
    public ResponseEntity<?> userTest() {
        log.info("ROLE_USER TEST");
        return response.success();
    }
    
    /**
     * 유저가 관리자 권한 가지고 있는지 테스트
     *
     * @return
     */
    @GetMapping("/adminTest")
    public ResponseEntity<?> adminTest() {
        log.info("ROLE_ADMIN TEST");
        return response.success();
    }
}
