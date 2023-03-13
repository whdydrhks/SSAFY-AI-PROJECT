package com.project.controller;

import com.project.jwt.JwtTokenProvider;
import com.project.lib.Helper;
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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/v1/user")
@RestController
@Api("사용자 컨트롤러 API v1")
public class UsersController {
    
    private final JwtTokenProvider jwtTokenProvider;
    private final UserService      userService;
    private final Response         response;
    
    @PostMapping("/sign-up")
    public ResponseEntity<?> signUp(@Validated UserRequestDto.SignUp signUp, Errors errors) {
        // validation check
        if (errors.hasErrors()) {
            return response.invalidFields(Helper.refineErrors(errors));
        }
        return userService.signUp(signUp);
    }
    
    @PostMapping("/login")
    public ResponseEntity<?> login(@Validated UserRequestDto.Login login, Errors errors) {
        // validation check
        if (errors.hasErrors()) {
            return response.invalidFields(Helper.refineErrors(errors));
        }
        return userService.login(login);
    }
    
    @PostMapping("/reissue")
    public ResponseEntity<?> reissue(@Validated UserRequestDto.Reissue reissue, Errors errors) {
        // validation check
        if (errors.hasErrors()) {
            return response.invalidFields(Helper.refineErrors(errors));
        }
        return userService.reissue(reissue);
    }
    
    @PostMapping("/logout")
    public ResponseEntity<?> logout(@Validated UserRequestDto.Logout logout, Errors errors) {
        // validation check
        if (errors.hasErrors()) {
            return response.invalidFields(Helper.refineErrors(errors));
            
        }
        return userService.logout(logout);
    }
    
    @GetMapping("/authority")
    public ResponseEntity<?> authority() {
        log.info("ADD ROLE_ADMIN");
        return userService.authority();
    }
    
    @GetMapping("/userTest")
    public ResponseEntity<?> userTest() {
        log.info("ROLE_USER TEST");
        return response.success();
    }
    
    @GetMapping("/adminTest")
    public ResponseEntity<?> adminTest() {
        log.info("ROLE_ADMIN TEST");
        return response.success();
    }
}
