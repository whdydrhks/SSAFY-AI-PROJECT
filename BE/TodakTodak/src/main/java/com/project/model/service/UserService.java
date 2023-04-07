package com.project.model.service;

import com.project.library.JwtTokenProvider;
import com.project.model.dto.Response;
import com.project.model.dto.request.DiaryRequestDto;
import com.project.model.dto.request.UserRequestDto.Login;
import com.project.model.dto.request.UserRequestDto.Reissue;
import com.project.model.dto.request.UserRequestDto.Signup;
import com.project.model.dto.response.UserResponseDto.TokenInfo;
import com.project.model.entity.Diary;
import com.project.model.entity.User;
import com.project.model.enums.Authority;
import com.project.model.repository.DiaryRepository;
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
    private DiaryRepository              diaryRepository;
    private Response                     response;
    private PasswordEncoder              passwordEncoder;
    private JwtTokenProvider             jwtTokenProvider;
    private AuthenticationManagerBuilder authenticationManagerBuilder;
    private RedisTemplate                redisTemplate;
    private DiaryService                 diaryService;
    
    @Autowired
    public UserService(UserRepository userRepository, DiaryRepository diaryRepository, Response response,
            PasswordEncoder passwordEncoder, JwtTokenProvider jwtTokenProvider,
            AuthenticationManagerBuilder authenticationManagerBuilder, RedisTemplate redisTemplate,
            DiaryService diaryService) {
        this.userRepository               = userRepository;
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
            log.info("UserService.signup : 이미 존재하는 닉네임입니다.");
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
        
        // 로그인까지 진행
        Login login = new Login(userNickname, signup.getUserDevice());
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
        
        log.info("UserService.signup : 회원 가입 성공");
        return response.success(tokenInfo, "회원가입 및 로그인에 성공했습니다.", HttpStatus.OK);
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
            log.info("UserService.login : 해당하는 유저가 존재하지 않습니다.");
            return response.fail("해당하는 유저가 존재하지 않습니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 탈퇴한 유저인지 확인
        if (!user.getUserStatus()) {
            log.info("UserService.login : 탈퇴한 유저입니다.");
            return response.fail("탈퇴한 유저입니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 입력받은 암호와 유저의 암호를 비교
        String inputPassword = login.getUserDevice();
        String userPassword  = user.getUserPassword();
        if (!passwordEncoder.matches(inputPassword, userPassword)) {
            log.info("UserService.login : 비밀번호가 일치하지 않습니다.");
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
        
        log.info("UserService.login : 로그인 성공");
        return response.success(tokenInfo, "로그인에 성공했습니다.", HttpStatus.OK);
    }
    
    /**
     * 로그아웃 (토큰 삭제)
     *
     * @param accessToken accessToken
     * @return response
     */
    public ResponseEntity<?> logout(String accessToken) {
        // AT 검증
        if (!jwtTokenProvider.validateToken(accessToken)) {
            log.info("UserService.logout : 만료된 Access Token 입니다.");
            return response.fail("만료된 Access Token 입니다.", HttpStatus.UNAUTHORIZED);
        }
        
        // Redis RT 삭제 + AT 유효시간 저장
        Authentication authentication = jwtTokenProvider.getAuthentication(accessToken);
        if (redisTemplate.opsForValue().get("RT:" + authentication.getName()) != null) {
            redisTemplate.delete("RT:" + authentication.getName());
        }
        Long expiration = jwtTokenProvider.getExpiration(accessToken);
        redisTemplate.opsForValue().set(accessToken, "logout", expiration, TimeUnit.MILLISECONDS);
        
        log.info("UserService.logout : 로그아웃 성공");
        return response.success("로그아웃 되었습니다.");
    }
    
    /**
     * 백업 (비밀번호 변경)
     *
     * @param accessToken accessToken
     * @param newPassword newPassword
     * @return response
     */
    public ResponseEntity<?> backupUser(String accessToken, String newPassword) {
        // AT 검증
        if (!jwtTokenProvider.validateToken(accessToken)) {
            log.info("UserService.backupUser : 만료된 Access Token 입니다.");
            return response.fail("만료된 Access Token 입니다.", HttpStatus.UNAUTHORIZED);
        }
        
        // 유저 존재 여부 확인
        User user = userRepository.findUserByUserNickname(
                jwtTokenProvider.getAuthentication(accessToken).getName()).orElse(null);
        if (user == null) {
            log.info("UserService.backupUser : 해당하는 유저가 존재하지 않습니다.");
            return response.fail("해당하는 유저가 존재하지 않습니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 비밀번호, 기기번호 수정
        user.setUserDevice(passwordEncoder.encode(newPassword));
        user.setUserPassword(passwordEncoder.encode(newPassword));
        userRepository.save(user);
        
        log.info("UserService.backupUser : 비밀번호 백업 성공");
        return response.success("회원 정보 수정에 성공했습니다.");
    }
    
    /**
     * 로드 (비밀번호 확인)
     * 백업한 계정으로 로그인
     * 장치번호를 암호화해서 device, password 갱신
     *
     * @param userNickname userNickname
     * @param userPassword userPassword
     * @param userDevice   userDevice
     * @return response
     */
    public ResponseEntity<?> loadUser(String userNickname, String userPassword, String userDevice) {
        // 유저 존재 여부 확인
        User user = userRepository.findUserByUserNickname(userNickname).orElse(null);
        if (user == null) {
            log.info("UserService.loadUser : 해당하는 유저가 존재하지 않습니다.");
            return response.fail("해당하는 유저가 존재하지 않습니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 탈퇴한 유저인지 확인
        if (!user.getUserStatus()) {
            log.info("UserService.loadUser : 탈퇴한 유저입니다.");
            return response.fail("탈퇴한 유저입니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 입력받은 암호와 유저의 암호를 비교
        String prePassword = user.getUserPassword();
        if (!passwordEncoder.matches(userPassword, prePassword)) {
            log.info("UserService.loadUser : 비밀번호가 일치하지 않습니다.");
            return response.fail("비밀번호가 일치하지 않습니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 비밀번호 변경
        user.setUserPassword(passwordEncoder.encode(userDevice));
        user.setUserDevice(passwordEncoder.encode(userDevice));
        userRepository.save(user);
        
        // 로그인
        Login                               login               = new Login(userNickname, userDevice);
        UsernamePasswordAuthenticationToken authenticationToken = login.toAuthentication();
        Authentication authentication = authenticationManagerBuilder.getObject()
                .authenticate(authenticationToken);
        TokenInfo tokenInfo = jwtTokenProvider.generateToken(authentication);
        redisTemplate.opsForValue().set("RT:" + authentication.getName(), tokenInfo.getRefreshToken(),
                tokenInfo.getRefreshTokenExpirationTime(), TimeUnit.MILLISECONDS);
        SecurityContextHolder.getContext().setAuthentication(authentication);
        
        log.info("UserService.loadUser : 로드 성공");
        return response.success(tokenInfo, "로그인에 성공했습니다.", HttpStatus.OK);
    }
    
    /**
     * 회원 비활성화
     * 회원, 작성한 일기 비활성화
     * 일기의 감정, 만남, 상세 비활성화
     *
     * @param accessToken accessToken
     * @return response
     */
    public ResponseEntity<?> deleteUser(String accessToken) {
        // AT 검증
        if (!jwtTokenProvider.validateToken(accessToken)) {
            log.info("UserService.deleteUser : 만료된 Access Token 입니다.");
            return response.fail("만료된 Access Token 입니다.", HttpStatus.UNAUTHORIZED);
        }
        // 로그아웃
        logout(accessToken);
        
        // 유저 존재 여부 확인
        User user = userRepository.findUserByUserNickname(
                jwtTokenProvider.getAuthentication(accessToken).getName()).orElse(null);
        if (user == null) {
            log.info("UserService.deleteUser : 해당하는 유저가 존재하지 않습니다.");
            return response.fail("해당하는 유저가 존재하지 않습니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 작성한 일기, 감정, 메트, 상세 비활성화
        List<Diary> diaryList = diaryRepository.findAllByUser(user).orElse(null);
        if (diaryList != null) {
            for (Diary diary : diaryList) {
                Long                        diaryId     = diary.getDiaryId();
                DiaryRequestDto.DeleteDiary deleteDiary = new DiaryRequestDto.DeleteDiary(diaryId);
                diaryService.deleteDiary("deleteUser", deleteDiary);
            }
        }
        
        // 회원 비활성화
        user.setUserStatus(false);
        userRepository.save(user);
        
        log.info("UserService.deleteUser : 회원 탈퇴 성공");
        return response.success("회원 탈퇴에 성공했습니다.");
    }
    
    /**
     * 토큰 재발행
     *
     * @param reissue accessToken, refreshToken
     * @return response
     */
    public ResponseEntity<?> reissue(Reissue reissue) {
        // RT 검증 1
        if (!jwtTokenProvider.validateToken(reissue.getRefreshToken())) {
            log.info("UserService.reissue : Refresh Token 정보가 유효하지 않습니다.");
            return response.fail("Refresh Token 정보가 유효하지 않습니다.", HttpStatus.UNAUTHORIZED);
        }
        
        // Authentication 객체 생성
        Authentication authentication = jwtTokenProvider.getAuthentication(reissue.getAccessToken());
        
        // Redis -> RT
        String refreshToken = (String) redisTemplate.opsForValue().get("RT:" + authentication.getName());
        
        if (ObjectUtils.isEmpty(refreshToken)) {
            log.info("UserService.reissue : 잘못된 요청입니다.");
            return response.fail("잘못된 요청입니다.", HttpStatus.BAD_REQUEST);
        }
        if (!refreshToken.equals(reissue.getRefreshToken())) {
            log.info("UserService.reissue : Refresh Token 정보가 일치하지 않습니다.");
            return response.fail("Refresh Token 정보가 일치하지 않습니다.", HttpStatus.UNAUTHORIZED);
        }
        
        // Token 재발행
        TokenInfo tokenInfo = jwtTokenProvider.generateToken(authentication);
        
        // Redis -> AT, RT
        redisTemplate.opsForValue().set("RT:" + authentication.getName(), tokenInfo.getRefreshToken(),
                tokenInfo.getRefreshTokenExpirationTime(), TimeUnit.MILLISECONDS);
        
        log.info("UserService.reissue : Token 정보가 갱신되었습니다.");
        return response.success(tokenInfo, "Token 정보가 갱신되었습니다.", HttpStatus.OK);
    }
}
