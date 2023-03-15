package com.project.model.service;

import com.project.library.JwtTokenProvider;
import com.project.library.SecurityUtil;
import com.project.model.dto.Response;
import com.project.model.dto.request.UserRequestDto;
import com.project.model.dto.response.EmotionResponseDto;
import com.project.model.dto.response.MetResponseDto;
import com.project.model.dto.response.UserDiaryDto;
import com.project.model.dto.response.UserResponseDto;
import com.project.model.dto.response.UserResponseDto.TokenInfo;
import com.project.model.entity.User;
import com.project.model.enums.Authority;
import com.project.model.repository.UserQueryRepository;
import com.project.model.repository.UserRepository;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;

@Slf4j
@RequiredArgsConstructor
@Service
public class UserService {
    
    private final UserRepository               userRepository;
    private final UserQueryRepository          userQueryRepository;
    private final Response                     response;
    private final PasswordEncoder              passwordEncoder;
    private final JwtTokenProvider             jwtTokenProvider;
    private final AuthenticationManagerBuilder authenticationManagerBuilder;
    private final RedisTemplate                redisTemplate;
    
    private UserResponseDto toUserDto(User user) {
        UserResponseDto userResponseDto = new UserResponseDto();
        userResponseDto.setUserId(user.getUserId());
        userResponseDto.setUserNickname(user.getUserNickname());
        userResponseDto.setUserDiary(user.getDiaries().stream()
                .map(diary -> {
                    UserDiaryDto userDiaryDto = new UserDiaryDto();
                    userDiaryDto.setDiaryId(diary.getDiaryId());
                    userDiaryDto.setDiaryContent(diary.getDiaryContent());
                    userDiaryDto.setDiaryScore(diary.getDiaryScore());
                    userDiaryDto.setEmotions(diary.getDiaryEmotions().stream()
                            .map(de -> {
                                EmotionResponseDto emotionResponseDto = new EmotionResponseDto();
                                emotionResponseDto.setEmotionId(de.getEmotion().getEmotionId());
                                emotionResponseDto.setEmotionName(de.getEmotion().getEmotionName());
                                return emotionResponseDto;
                            })
                            .collect(Collectors.toList()));
                    userDiaryDto.setMets(diary.getDiaryMets().stream()
                            .map(dm -> {
                                MetResponseDto metResponseDto = new MetResponseDto();
                                metResponseDto.setMetId(dm.getMet().getMetId());
                                metResponseDto.setMetName(dm.getMet().getMetName());
                                return metResponseDto;
                            })
                            .collect(Collectors.toList()));
                    return userDiaryDto;
                })
                .collect(Collectors.toList()));
        userResponseDto.setUserCreatedDate(user.getCreateDate());
        userResponseDto.setUserModifiedDate(user.getModifiedDate());
        return userResponseDto;
    }
    
    /**
     * 회원가입
     * 입력받은 device -> 암호화 -> device, password 저장
     * 암호화된 device == password  검증 완료
     *
     * @param signUp, nickname, device
     * @return response
     */
    public ResponseEntity<?> signUp(UserRequestDto.SignUp signUp) {
        if (userRepository.existsUserByUserNickname(signUp.getUserNickname())) {
            return response.fail("이미 회원가입된 닉네임입니다.", HttpStatus.BAD_REQUEST);
        }
        
        User user = User.builder()
                .userNickname(signUp.getUserNickname())
                .userDevice(passwordEncoder.encode(signUp.getUserDevice()))
                .userPassword(passwordEncoder.encode(signUp.getUserDevice()))
                .roles(Collections.singletonList(Authority.ROLE_USER.name()))
                .userStatus(true)
                .build();
        userRepository.save(user);
        
        return response.success("회원가입에 성공했습니다.");
    }
    
    /**
     * 전체 true 회원 조회
     * todo ROLE_ADMIN 권한 필요
     *
     * @return response
     */
    public ResponseEntity<?> findAllUser() {
        List<User> findUsers = userQueryRepository.findAllUser().get();
        
        if (ObjectUtils.isEmpty(findUsers)) {
            return response.fail("가입된 회원이 없습니다.", HttpStatus.BAD_REQUEST);
        }
        
        List<UserResponseDto> findUsersDto = findUsers.stream()
                .map(this::toUserDto)
                .collect(Collectors.toList());
        
        return response.success(findUsersDto);
    }
    
    /**
     * 회원 번호로 true 회원 조회
     *
     * @param userId
     * @return response
     */
    public ResponseEntity<?> findUserByUserId(Long userId) {
        Optional<User> findUser = userQueryRepository.findUserById(userId);
        
        if (findUser.isEmpty()) {
            return response.fail("해당하는 유저가 존재하지 않습니다.", HttpStatus.BAD_REQUEST);
        }
        UserResponseDto findUserDto = toUserDto(findUser.get());
        
        return response.success(findUserDto);
    }
    
    /**
     * 회원 닉네임으로 true 회원 조회
     *
     * @param userNickname
     * @return response
     */
    public ResponseEntity<?> findUserByUserNickname(String userNickname) {
        Optional<User> findUser = userQueryRepository.findUserByNickname(userNickname);
        
        if (findUser.isEmpty()) {
            return response.fail("해당하는 유저가 존재하지 않습니다.", HttpStatus.BAD_REQUEST);
        }
        UserResponseDto findUserDto = toUserDto(findUser.get());
        
        return response.success(findUserDto);
    }
    
    /**
     * 회원 탈퇴 (비활성화)
     *
     * @param userId
     * @return response
     */
    public ResponseEntity<?> deleteUser(Long userId) {
        Optional<User> findUser = userQueryRepository.findUserById(userId);
        
        if (findUser.isEmpty()) {
            return response.fail("해당하는 유저가 존재하지 않습니다.", HttpStatus.BAD_REQUEST);
        }
        
        User user = findUser.get();
        user.setUserStatus(false);
        userRepository.save(user);
        
        return response.success("회원 탈퇴에 성공했습니다.");
    }
    
    public ResponseEntity<?> login(UserRequestDto.Login login) {
        
        if (userRepository.findUserByUserNickname(login.getNickname()).orElse(null) == null) {
            return response.fail("해당하는 유저가 존재하지 않습니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 1. Login ID/PW 를 기반으로 Authentication 객체 생성
        // 이때 authentication 는 인증 여부를 확인하는 authenticated 값이 false
        UsernamePasswordAuthenticationToken authenticationToken = login.toAuthentication();
        
        // 2. 실제 검증 (사용자 비밀번호 체크)이 이루어지는 부분
        // authenticate 매서드가 실행될 때 CustomUserDetailsService 에서 만든 loadUserByUsername 메서드가 실행
        Authentication authentication = authenticationManagerBuilder.getObject().authenticate(authenticationToken);
        
        // 3. 인증 정보를 기반으로 JWT 토큰 생성
        TokenInfo tokenInfo = jwtTokenProvider.generateToken(authentication);
        
        // 4. RefreshToken Redis 저장 (expirationTime 설정을 통해 자동 삭제 처리)
        redisTemplate.opsForValue().set("RT:" + authentication.getName(), tokenInfo.getRefreshToken(),
                tokenInfo.getRefreshTokenExpirationTime(), TimeUnit.MILLISECONDS);
        
        return response.success(tokenInfo, "로그인에 성공했습니다.", HttpStatus.OK);
    }
    
    public ResponseEntity<?> reissue(UserRequestDto.Reissue reissue) {
        // 1. Refresh Token 검증
        if (!jwtTokenProvider.validateToken(reissue.getRefreshToken())) {
            return response.fail("Refresh Token 정보가 유효하지 않습니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 2. Access Token 에서 User nickname 을 가져옵니다.
        Authentication authentication = jwtTokenProvider.getAuthentication(reissue.getAccessToken());
        
        // 3. Redis 에서 User nickname 을 기반으로 저장된 Refresh Token 값을 가져옵니다.
        String refreshToken = (String) redisTemplate.opsForValue().get("RT:" + authentication.getName());
        // (추가) 로그아웃되어 Redis 에 RefreshToken 이 존재하지 않는 경우 처리
        if (ObjectUtils.isEmpty(refreshToken)) {
            return response.fail("잘못된 요청입니다.", HttpStatus.BAD_REQUEST);
        }
        if (!refreshToken.equals(reissue.getRefreshToken())) {
            return response.fail("Refresh Token 정보가 일치하지 않습니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 4. 새로운 토큰 생성
        TokenInfo tokenInfo = jwtTokenProvider.generateToken(authentication);
        
        // 5. RefreshToken Redis 업데이트
        redisTemplate.opsForValue().set("RT:" + authentication.getName(), tokenInfo.getRefreshToken(),
                tokenInfo.getRefreshTokenExpirationTime(), TimeUnit.MILLISECONDS);
        
        return response.success(tokenInfo, "Token 정보가 갱신되었습니다.", HttpStatus.OK);
    }
    
    public ResponseEntity<?> logout(UserRequestDto.Logout logout) {
        // 1. Access Token 검증
        if (!jwtTokenProvider.validateToken(logout.getAccessToken())) {
            return response.fail("잘못된 요청입니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 2. Access Token 에서 User nickname 을 가져옵니다.
        Authentication authentication = jwtTokenProvider.getAuthentication(logout.getAccessToken());
        
        // 3. Redis 에서 해당 User nickname 로 저장된 Refresh Token 이 있는지 여부를 확인 후 있을 경우 삭제합니다.
        if (redisTemplate.opsForValue().get("RT:" + authentication.getName()) != null) {
            // Refresh Token 삭제
            redisTemplate.delete("RT:" + authentication.getName());
        }
        
        // 4. 해당 Access Token 유효시간 가지고 와서 BlackList 로 저장하기
        Long expiration = jwtTokenProvider.getExpiration(logout.getAccessToken());
        redisTemplate.opsForValue().set(logout.getAccessToken(), "logout", expiration, TimeUnit.MILLISECONDS);
        
        return response.success("로그아웃 되었습니다.");
    }
    
    public ResponseEntity<?> authority() {
        // SecurityContext에 담겨 있는 authentication userNickname 정보
        String nickname = SecurityUtil.getCurrentUserNickname();
        
        User user = userRepository.findUserByUserNickname(nickname)
                .orElseThrow(() -> new UsernameNotFoundException("No authentication information."));
        
        // add ROLE_ADMIN
        user.getRoles().add(Authority.ROLE_ADMIN.name());
        userRepository.save(user);
        
        return response.success();
    }
}
