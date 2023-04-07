package com.project.model.service;

import com.project.library.JwtTokenProvider;
import com.project.model.dto.Response;
import com.project.model.dto.request.AdminRequestDto.AdminSignup;
import com.project.model.entity.User;
import com.project.model.enums.Authority;
import com.project.model.repository.UserRepository;
import java.io.IOException;
import java.util.Collection;
import java.util.Collections;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Slf4j
@RequiredArgsConstructor
@Service
public class AdminService {
    
    private UserRepository   userRepository;
    private Response         response;
    private PasswordEncoder  passwordEncoder;
    private JwtTokenProvider jwtTokenProvider;
    
    @Autowired
    public AdminService(UserRepository userRepository, Response response, PasswordEncoder passwordEncoder,
            JwtTokenProvider jwtTokenProvider) {
        this.userRepository   = userRepository;
        this.response         = response;
        this.passwordEncoder  = passwordEncoder;
        this.jwtTokenProvider = jwtTokenProvider;
    }
    
    /**
     * 관리자 회원 가입
     *
     * @param adminSignup password, userNickname, userDevice
     * @return response
     */
    public ResponseEntity<?> adminSignup(AdminSignup adminSignup) throws IOException {
        // verify admin
        String password = adminSignup.getPassword();
        if (!password.equals("1q2w3e4r!!")) {
            log.info("AdminService.adminSignup: 관리자가 아닙니다.");
            return response.fail("관리자가 아닙니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 중복 검사
        String userNickname = adminSignup.getUserNickname();
        if (userRepository.findUserByUserNickname(userNickname).orElse(null) != null) {
            log.info("AdminService.adminSignup: 이미 존재하는 닉네임입니다.");
            return response.fail("이미 존재하는 닉네임입니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 유저 저장
        User user = User.builder()
                .userNickname(userNickname)
                .userDevice(passwordEncoder.encode(adminSignup.getUserDevice()))
                .userPassword(passwordEncoder.encode(adminSignup.getUserDevice()))
                .roles(Collections.singletonList(Authority.ROLE_ADMIN.name()))
                .userStatus(true)
                .build();
        userRepository.save(user);
        
        log.info("AdminService.adminSignup: 회원가입에 성공했습니다.");
        return response.success("회원가입에 성공했습니다.");
    }
    
    /**
     * 관리자 권한 부여
     *
     * @param accessToken accessToken
     * @param userId      userId
     * @return response
     */
    public ResponseEntity<?> grantAdmin(String accessToken, Long userId) {
        
        // AT 검증
        if (!jwtTokenProvider.validateToken(accessToken)) {
            log.info("AdminService.grantAdmin: 만료된 Access Token 입니다.");
            return response.fail("만료된 Access Token 입니다.", HttpStatus.UNAUTHORIZED);
        }
        
        // 권한 검증
        boolean                                isAdmin        = false;
        Authentication                         authentication = jwtTokenProvider.getAuthentication(accessToken);
        Collection<? extends GrantedAuthority> authorities    = authentication.getAuthorities();
        for (GrantedAuthority authority : authorities) {
            if (authority.getAuthority().equals(Authority.ROLE_ADMIN.name())) {
                isAdmin = true;
                break;
            }
        }
        if (!isAdmin) {
            log.info("AdminService.grantAdmin: 권한이 없습니다.");
            return response.fail("권한이 없습니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 유저 존재 여부 확인
        User user = userRepository.findById(userId).orElse(null);
        if (user == null || !user.getUserStatus()) {
            log.info("AdminService.grantAdmin: 해당하는 유저가 존재하지 않습니다.");
            return response.fail("해당하는 유저가 존재하지 않습니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 이미 권한 가지고 있는지
        if (user.getRoles().contains(Authority.ROLE_ADMIN.name())) {
            log.info("AdminService.grantAdmin: 이미 관리자 권한을 가지고 있습니다.");
            return response.fail("이미 관리자 권한을 가지고 있습니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 권한 부여
        user.getRoles().add(Authority.ROLE_ADMIN.name());
        userRepository.save(user);
        
        log.info("AdminService.grantAdmin: 관리자 권한을 부여했습니다.");
        return response.success("관리자 권한을 부여했습니다.");
    }
}
