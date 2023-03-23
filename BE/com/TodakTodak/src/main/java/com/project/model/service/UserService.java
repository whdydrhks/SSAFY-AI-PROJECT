package com.project.model.service;

import com.project.library.JwtTokenProvider;
import com.project.model.dto.Response;
import com.project.model.dto.request.DiaryRequestDto;
import com.project.model.dto.request.UserRequestDto.Backup;
import com.project.model.dto.request.UserRequestDto.Delete;
import com.project.model.dto.request.UserRequestDto.Grant;
import com.project.model.dto.request.UserRequestDto.Login;
import com.project.model.dto.request.UserRequestDto.Logout;
import com.project.model.dto.request.UserRequestDto.Reissue;
import com.project.model.dto.request.UserRequestDto.Signup;
import com.project.model.dto.response.UserResponseDto.TokenInfo;
import com.project.model.entity.Diary;
import com.project.model.entity.User;
import com.project.model.enums.Authority;
import com.project.model.repository.DiaryRepository;
import com.project.model.repository.UserQueryRepository;
import com.project.model.repository.UserRepository;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.TimeUnit;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;

@Slf4j
@RequiredArgsConstructor
@Service
public class UserService {
    
    
    private UserRepository               userRepository;
    private UserQueryRepository          userQueryRepository;
    private DiaryRepository              diaryRepository;
    private Response                     response;
    private PasswordEncoder              passwordEncoder;
    private JwtTokenProvider             jwtTokenProvider;
    private AuthenticationManagerBuilder authenticationManagerBuilder;
    private RedisTemplate                redisTemplate;
    private DiaryService                 diaryService;
    
    @Autowired
    public UserService(UserRepository userRepository, UserQueryRepository userQueryRepository,
            DiaryRepository diaryRepository, Response response, PasswordEncoder passwordEncoder,
            JwtTokenProvider jwtTokenProvider, AuthenticationManagerBuilder authenticationManagerBuilder,
            RedisTemplate redisTemplate, DiaryService diaryService) {
        this.userRepository               = userRepository;
        this.userQueryRepository          = userQueryRepository;
        this.diaryRepository              = diaryRepository;
        this.response                     = response;
        this.passwordEncoder              = passwordEncoder;
        this.jwtTokenProvider             = jwtTokenProvider;
        this.authenticationManagerBuilder = authenticationManagerBuilder;
        this.redisTemplate                = redisTemplate;
        this.diaryService                 = diaryService;
    }
    
    /**
     * 회원 가입
     * 닉네임, 장치번호
     * 장치번호를 암호화해서 device, password 저장
     *
     * @param signup 닉네임, 장치번호
     * @return response
     */
    public ResponseEntity<?> signup(Signup signup) {
        // 중복 검사
        String userNickname = signup.getUserNickname();
        if (userRepository.findUserByUserNickname(userNickname).orElse(null) != null) {
            return response.fail("이미 존재하는 닉네임입니다.", HttpStatus.BAD_REQUEST);
        }
        // 유저 저장
        User user = User.builder()
                .userNickname(userNickname)
                .userDevice(passwordEncoder.encode(signup.getUserDevice()))
                .userPassword(passwordEncoder.encode(signup.getUserDevice()))
                .roles(Collections.singletonList(Authority.ROLE_USER.name()))
                .userStatus(true)
                .build();
        userRepository.save(user);
        
        return response.success("회원가입에 성공했습니다.");
    }
    
    /**
     * 로그인 (토큰 발급)
     *
     * @param login 닉네임, 장치번호
     * @return response
     */
    public ResponseEntity<?> login(Login login) {
        // 유저 존재 여부 확인
        User user = userRepository.findUserByUserNickname(login.getUserNickname()).orElse(null);
        if (user == null) {
            return response.fail("해당하는 유저가 존재하지 않습니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 탈퇴한 유저인지 확인
        if (!user.getUserStatus()) {
            return response.fail("탈퇴한 유저입니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 입력받은 암호와 유저의 암호를 비교
        String inputPassword = login.getUserDevice();
        String userPassword  = user.getUserPassword();
        if (!passwordEncoder.matches(inputPassword, userPassword)) {
            return response.fail("비밀번호가 일치하지 않습니다.", HttpStatus.BAD_REQUEST);
        }
        
        // Authentication 객체 생성
        UsernamePasswordAuthenticationToken authenticationToken = login.toAuthentication();
        // 암호 체크 후 인증 객체를 반환 (여기선 이미 암호 체크 되어있음)
        Authentication authentication = authenticationManagerBuilder.getObject().authenticate(authenticationToken);
        // JWT 토큰 생성
        TokenInfo tokenInfo = jwtTokenProvider.generateToken(authentication);
        // RT -> Redis 저장
        redisTemplate.opsForValue().set("RT:" + authentication.getName(), tokenInfo.getRefreshToken(),
                tokenInfo.getRefreshTokenExpirationTime(), TimeUnit.MILLISECONDS);
        
        // SecurityContextHolder에 사용자 정보 저장
        SecurityContextHolder.getContext().setAuthentication(authentication);
        return response.success(tokenInfo, "로그인에 성공했습니다.", HttpStatus.OK);
    }
    
    /**
     * 로그아웃 (토큰 삭제)
     *
     * @param logout accessToken, refreshToken
     * @return response
     */
    public ResponseEntity<?> logout(Logout logout) {
        // 로그인 여부 확인
        if (Boolean.TRUE.equals(redisTemplate.hasKey(logout.getAccessToken()))) {
            return response.fail("로그인된 계정이 아닙니다.", HttpStatus.BAD_REQUEST);
        }
        
        // AT 검증
        if (!jwtTokenProvider.validateToken(logout.getAccessToken())) {
            return response.fail("잘못된 요청입니다.", HttpStatus.BAD_REQUEST);
        }
        
        // Authentication 객체 생성
        Authentication authentication = jwtTokenProvider.getAuthentication(logout.getAccessToken());
        
        // RT 삭제
        if (redisTemplate.opsForValue().get("RT:" + authentication.getName()) != null) {
            redisTemplate.delete("RT:" + authentication.getName());
        }
        
        // AT 유효시간 저장
        Long expiration = jwtTokenProvider.getExpiration(logout.getAccessToken());
        redisTemplate.opsForValue().set(logout.getAccessToken(), "logout", expiration, TimeUnit.MILLISECONDS);
        
        return response.success("로그아웃 되었습니다.");
    }
    
    /**
     * 백업 (비밀번호 변경)
     *
     * @param backup accessToken, refreshToken, password
     * @return response
     */
    public ResponseEntity<?> backupUser(Backup backup) {
        // 로그인 여부 확인
        if (Boolean.TRUE.equals(redisTemplate.hasKey(backup.getAccessToken()))) {
            return response.fail("로그인된 계정이 아닙니다.", HttpStatus.BAD_REQUEST);
        }
        
        // AT 검증
        if (!jwtTokenProvider.validateToken(backup.getAccessToken())) {
            return response.fail("잘못된 요청입니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 유저 존재 여부 확인
        User user = userRepository.findUserByUserNickname(
                jwtTokenProvider.getAuthentication(backup.getAccessToken()).getName()).orElse(null);
        if (user == null) {
            return response.fail("해당하는 유저가 존재하지 않습니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 비밀번호, 기기번호 수정
        user.setUserDevice(passwordEncoder.encode(backup.getNewPassword()));
        user.setUserPassword(passwordEncoder.encode(backup.getNewPassword()));
        userRepository.save(user);
        
        return response.success("회원 정보 수정에 성공했습니다.");
    }
    
    /**
     * 회원 비활성화
     * 회원, 작성한 일기 비활성화
     * 일기의 감정, 만남, 상세 비활성화
     *
     * @param delete accessToken, refreshToken
     * @return response
     */
    public ResponseEntity<?> deleteUser(Delete delete) {
        // 로그인 여부 확인
        if (Boolean.TRUE.equals(redisTemplate.hasKey(delete.getAccessToken()))) {
            return response.fail("로그인된 계정이 아닙니다.", HttpStatus.BAD_REQUEST);
        }
        
        // AT 검증
        if (!jwtTokenProvider.validateToken(delete.getAccessToken())) {
            return response.fail("잘못된 요청입니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 유저 존재 여부 확인
        User user = userRepository.findUserByUserNickname(
                jwtTokenProvider.getAuthentication(delete.getAccessToken()).getName()).orElse(null);
        if (user == null) {
            return response.fail("해당하는 유저가 존재하지 않습니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 작성한 일기, 감정, 메트, 상세 비활성화
        List<Diary> diaryList = diaryRepository.findAllByUser(user).orElse(null);
        if (diaryList != null) {
            for (Diary diary : diaryList) {
                Long                        diaryId     = diary.getDiaryId();
                DiaryRequestDto.DeleteDiary deleteDiary = new DiaryRequestDto.DeleteDiary(diaryId);
                diaryService.deleteDiary(deleteDiary);
            }
        }
        
        // 회원 비활성화
        user.setUserStatus(false);
        userRepository.save(user);
        
        // 로그아웃
        logout(new Logout(delete.getAccessToken(), delete.getRefreshToken()));
        
        return response.success("회원 탈퇴에 성공했습니다.");
    }
    
    /**
     * 토큰 재발행
     *
     * @param reissue accessToken, refreshToken
     * @return response
     */
    public ResponseEntity<?> reissue(Reissue reissue) {
        // RT 검증
        if (!jwtTokenProvider.validateToken(reissue.getRefreshToken())) {
            return response.fail("Refresh Token 정보가 유효하지 않습니다.", HttpStatus.BAD_REQUEST);
        }
        
        // Authentication 객체 생성
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
        
        // 권한 부여
        user.getRoles().add(Authority.ROLE_ADMIN.name());
        userRepository.save(user);
        
        return response.success();
    }
    
    // ======================================= ADMIN =======================================
    public ResponseEntity<?> findAllUser() {
        return userQueryRepository.findAllUser();
    }
    
    public ResponseEntity<?> findUserByUserId(Long userId) {
        return userQueryRepository.findUserByUserId(userId);
    }
    
    public ResponseEntity<?> findUserByUserNickname(String userNickname) {
        return userQueryRepository.findUserByUserNickname(userNickname);
    }
}
