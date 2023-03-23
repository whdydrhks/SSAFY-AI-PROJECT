package com.project.model.service;

import com.project.model.dto.Response;
import com.project.model.dto.request.AdminRequestDto.AdminSignup;
import com.project.model.dto.request.UserRequestDto.Grant;
import com.project.model.dto.response.DiaryResponseDto;
import com.project.model.dto.response.UserResponseDto;
import com.project.model.entity.User;
import com.project.model.enums.Authority;
import com.project.model.repository.AdminQueryRepository;
import com.project.model.repository.UserRepository;
import java.util.Collections;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Slf4j
@RequiredArgsConstructor
@Service
public class AdminService {
    
    private UserRepository       userRepository;
    private AdminQueryRepository adminQueryRepository;
    private Response             response;
    private PasswordEncoder      passwordEncoder;
    
    @Autowired
    public AdminService(UserRepository userRepository, AdminQueryRepository adminQueryRepository, Response response,
            PasswordEncoder passwordEncoder) {
        this.userRepository       = userRepository;
        this.adminQueryRepository = adminQueryRepository;
        this.response             = response;
        this.passwordEncoder      = passwordEncoder;
    }
    
    /**
     * 관리자 회원 가입
     * todo 깃 이그노어 해서 파일 밖에 저장하자
     *
     * @param adminSignup 패스워드, 닉네임, 장치번호
     * @return response
     */
    public ResponseEntity<?> adminSignup(AdminSignup adminSignup) {
        String password = adminSignup.getPassword();
        if (!password.equals("1q2w3e4r!!")) {
            return response.fail("관리자가 아닙니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 중복 검사
        String userNickname = adminSignup.getUserNickname();
        if (userRepository.findUserByUserNickname(userNickname).orElse(null) != null) {
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
        
        return response.success("회원가입에 성공했습니다.");
    }
    
    /**
     * 모든 유저 조회
     *
     * @return response
     */
    public ResponseEntity<?> findAllTrueUser() {
        List<UserResponseDto> findAllTrueUser = adminQueryRepository.findAllTrueUser();
        
        if (findAllTrueUser.isEmpty()) {
            return response.fail("회원이 없습니다.", HttpStatus.BAD_REQUEST);
        }
        return response.success(findAllTrueUser);
    }
    
    /**
     * 모든 다이어리 조회
     *
     * @return response
     */
    public ResponseEntity<?> findAllTrueDiary() {
        List<DiaryResponseDto> findAllTrueDiary = adminQueryRepository.findAllTrueDiary();
        
        if (findAllTrueDiary.isEmpty()) {
            return response.fail("일기가 없습니다.", HttpStatus.BAD_REQUEST);
        }
        
        return response.success(findAllTrueDiary);
    }
    
    /**
     * 관리자 권한 부여
     *
     * @param grant accessToken, refreshToken, userId
     * @return response
     */
    public ResponseEntity<?> grantAdmin(Grant grant) {
        // 유저 존재 여부 확인
        User user = userRepository.findById(grant.getUserId()).orElse(null);
        if (user == null || !user.getUserStatus()) {
            return response.fail("해당하는 유저가 존재하지 않습니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 이미 권한 가지고 있는지
        if (user.getRoles().contains(Authority.ROLE_ADMIN.name())) {
            return response.fail("이미 관리자 권한을 가지고 있습니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 권한 부여
        user.getRoles().add(Authority.ROLE_ADMIN.name());
        userRepository.save(user);
        
        return response.success("관리자 권한을 부여했습니다.");
    }
}
