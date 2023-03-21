package com.project.model.repository;

import com.project.model.dto.Response;
import com.project.model.dto.request.UserRequestDto;
import com.project.model.dto.response.UserResponseDto;
import com.project.model.entity.*;
import com.project.model.enums.Authority;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
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
    
    @Autowired
    public UserQueryRepository(JPAQueryFactory jpaQueryFactory, UserRepository userRepository,
            DiaryRepository diaryRepository, DiaryEmotionRepository diaryEmotionRepository,
            DiaryMetRepository diaryMetRepository, DiaryDetailRepository diaryDetailRepository,
            UserResponseDto userResponseDto, Response response, PasswordEncoder passwordEncoder) {
        this.jpaQueryFactory        = jpaQueryFactory;
        this.userRepository         = userRepository;
        this.diaryRepository        = diaryRepository;
        this.diaryEmotionRepository = diaryEmotionRepository;
        this.diaryMetRepository     = diaryMetRepository;
        this.diaryDetailRepository  = diaryDetailRepository;
        this.userResponseDto        = userResponseDto;
        this.response               = response;
        this.passwordEncoder        = passwordEncoder;
    }
    
    /**
     * 회원 가입
     * 닉네임, 장치번호
     * 장치번호를 암호화해서 device, password 저장
     *
     * @param signUp 닉네임, 장치번호
     * @return response 닉네임 중복시 실패 / 성공
     */
    public ResponseEntity<?> signUp(UserRequestDto.SignUp signUp) {
        // 닉네임 중복 검사
        QUser             user           = QUser.user;
        BooleanExpression userNicknameEq = user.userNickname.eq(signUp.getUserNickname());
        if (userRepository.findOne(userNicknameEq).isPresent()) {
            return response.fail("이미 회원가입된 닉네임입니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 유저 생성
        User newUser = User.builder()
                .userNickname(signUp.getUserNickname())
                .userDevice(passwordEncoder.encode(signUp.getUserDevice()))
                .userPassword(passwordEncoder.encode(signUp.getUserDevice()))
                .roles(Collections.singletonList(Authority.ROLE_USER.name()))
                .userStatus(true)
                .build();
        
        // 유저 저장
        userRepository.save(newUser);
        
        // 성공
        return response.success("회원가입에 성공했습니다.");
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
    
    /**
     * 회원 탈퇴
     * 회원, 작성한 일기 비활성화
     * 일기의 감정, 만남, 상세 비활성화
     *
     * @param userId 회원 번호
     * @return response 회원이 없을 경우 실패 / 성공
     */
    public ResponseEntity<?> deleteUserByUserId(Long userId) {
        // 회원 조회
        QUser user = QUser.user;
        User findUser = jpaQueryFactory.selectFrom(user)
                .where(user.userId.eq(userId).and(user.userStatus.eq(true)))
                .fetchOne();
        
        // 회원이 없을 경우
        if (ObjectUtils.isEmpty(findUser)) {
            return response.fail("가입된 회원이 없습니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 회원 탈퇴
        findUser.setUserStatus(false);
        userRepository.save(findUser);
        
        // 회원이 작성한 다이어리 비활성화
        QDiary diary = QDiary.diary;
        List<Diary> findDiaries = jpaQueryFactory.selectFrom(diary)
                .where(diary.user.eq(findUser).and(diary.diaryStatus.eq(true)))
                .fetch();
        for (Diary d : findDiaries) {
            d.setDiaryStatus(false);
            diaryRepository.save(d);
        }
        
        // 회원이 작성한 다이어리의 감정 비활성화
        QDiaryEmotion diaryEmotion = QDiaryEmotion.diaryEmotion;
        List<DiaryEmotion> findDiaryEmotions = jpaQueryFactory.selectFrom(diaryEmotion)
                .where(diaryEmotion.diary.in(findDiaries).and(diaryEmotion.diaryEmotionStatus.eq(true)))
                .fetch();
        for (DiaryEmotion de : findDiaryEmotions) {
            de.setDiaryEmotionStatus(false);
            diaryEmotionRepository.save(de);
        }
        
        // 회원이 작성한 다이어리의 메트 비활성화
        QDiaryMet diaryMet = QDiaryMet.diaryMet;
        List<DiaryMet> findDiaryMets = jpaQueryFactory.selectFrom(diaryMet)
                .where(diaryMet.diary.in(findDiaries).and(diaryMet.diaryMetStatus.eq(true)))
                .fetch();
        for (DiaryMet dm : findDiaryMets) {
            dm.setDiaryMetStatus(false);
            diaryMetRepository.save(dm);
        }
        
        // 회원이 작성한 다이어리의 상세 비활성화
        QDiaryDetail diaryDetail = QDiaryDetail.diaryDetail;
        List<DiaryDetail> findDiaryDetails = jpaQueryFactory.selectFrom(diaryDetail)
                .where(diaryDetail.diary.in(findDiaries).and(diaryDetail.diaryDetailStatus.eq(true)))
                .fetch();
        for (DiaryDetail dd : findDiaryDetails) {
            dd.setDiaryDetailStatus(false);
            diaryDetailRepository.save(dd);
        }
        
        return response.success("회원 탈퇴에 성공했습니다.");
    }
}
