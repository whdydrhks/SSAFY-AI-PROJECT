package com.project.model.repository;

import com.project.library.JwtTokenProvider;
import com.project.model.dto.Response;
import com.project.model.dto.response.UserResponseDto;
import com.project.model.entity.QUser;
import com.project.model.entity.User;
import com.querydsl.jpa.impl.JPAQueryFactory;
import java.util.List;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;
import org.springframework.util.ObjectUtils;

@Repository
@RequiredArgsConstructor
public class UserQueryRepository {
    
    private JPAQueryFactory        jpaQueryFactory;
    private UserRepository         userRepository;
    private DiaryRepository        diaryRepository;
    private DiaryEmotionRepository diaryEmotionRepository;
    private DiaryMetRepository     diaryMetRepository;
    private DiaryDetailRepository  diaryDetailRepository;
    private UserResponseDto        userResponseDto;
    private Response               response;
    private PasswordEncoder        passwordEncoder;
    private RedisTemplate          redisTemplate;
    private JwtTokenProvider       jwtTokenProvider;
    
    @Autowired
    public UserQueryRepository(JPAQueryFactory jpaQueryFactory, UserRepository userRepository,
            DiaryRepository diaryRepository, DiaryEmotionRepository diaryEmotionRepository,
            DiaryMetRepository diaryMetRepository, DiaryDetailRepository diaryDetailRepository,
            UserResponseDto userResponseDto, Response response, PasswordEncoder passwordEncoder,
            RedisTemplate redisTemplate, JwtTokenProvider jwtTokenProvider) {
        this.jpaQueryFactory        = jpaQueryFactory;
        this.userRepository         = userRepository;
        this.diaryRepository        = diaryRepository;
        this.diaryEmotionRepository = diaryEmotionRepository;
        this.diaryMetRepository     = diaryMetRepository;
        this.diaryDetailRepository  = diaryDetailRepository;
        this.userResponseDto        = userResponseDto;
        this.response               = response;
        this.passwordEncoder        = passwordEncoder;
        this.redisTemplate          = redisTemplate;
        this.jwtTokenProvider       = jwtTokenProvider;
    }
    
    /**
     * 전체 회원 조회
     *
     * @return response 회원이 없을 경우 실패 / 성공
     */
    public ResponseEntity<?> findAllUser() {
        // 전체 회원 조회
        QUser user = QUser.user;
        List<User> findUsers = jpaQueryFactory.selectFrom(user)
                .where(user.userStatus.eq(true))
                .fetch();
        
        // 회원이 없을 경우
        if (ObjectUtils.isEmpty(findUsers)) {
            return response.fail("가입된 회원이 없습니다.", HttpStatus.BAD_REQUEST);
        }
        
        // DTO 변환
        List<UserResponseDto> findUserResponseDtoList = findUsers.stream()
                .map(u -> userResponseDto.toUserDto(u))
                .collect(Collectors.toList());
        
        // 회원 조회 성공
        return response.success(findUserResponseDtoList);
    }
    
    
    /**
     * 회원 번호로 true 회원 조회
     *
     * @param userId
     * @return response 회원이 없을 경우 실패 / 성공
     */
    public ResponseEntity<?> findUserByUserId(Long userId) {
        // 회원 조회
        QUser user = QUser.user;
        User findUser = jpaQueryFactory.selectFrom(user)
                .where(user.userId.eq(userId).and(user.userStatus.eq(true)))
                .fetchOne();
        
        // 회원이 없을 경우
        if (ObjectUtils.isEmpty(findUser)) {
            return response.fail("가입된 회원이 없습니다.", HttpStatus.BAD_REQUEST);
        }
        
        // DTO 변환
        UserResponseDto findUserResponseDto = userResponseDto.toUserDto(findUser);
        
        // 회원 조회 성공
        return response.success(findUserResponseDto);
    }
    
    /**
     * 회원 닉네임으로 true 회원 조회
     *
     * @param userNickname
     * @return response 회원이 없을 경우 실패 / 성공
     */
    public ResponseEntity<?> findUserByUserNickname(String userNickname) {
        // 회원 조회
        QUser user = QUser.user;
        User findUser = jpaQueryFactory.selectFrom(user)
                .where(user.userNickname.eq(userNickname).and(user.userStatus.eq(true)))
                .fetchOne();
        
        // 회원이 없을 경우
        if (ObjectUtils.isEmpty(findUser)) {
            return response.fail("가입된 회원이 없습니다.", HttpStatus.BAD_REQUEST);
        }
        
        // DTO 변환
        UserResponseDto findUserResponseDto = userResponseDto.toUserDto(findUser);
        
        // 회원 조회 성공
        return response.success(findUserResponseDto);
    }
}
