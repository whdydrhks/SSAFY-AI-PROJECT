package com.project.model.repository;

import com.project.model.dto.response.DiaryResponseDto;
import com.project.model.dto.response.UserResponseDto;
import com.project.model.entity.QDiary;
import com.project.model.entity.QUser;
import com.querydsl.jpa.impl.JPAQueryFactory;
import java.util.List;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class AdminQueryRepository {
    
    private JPAQueryFactory  jpaQueryFactory;
    private UserResponseDto  userResponseDto;
    private DiaryResponseDto diaryResponseDto;
    
    @Autowired
    public AdminQueryRepository(JPAQueryFactory jpaQueryFactory, UserResponseDto userResponseDto,
            DiaryResponseDto diaryResponseDto) {
        this.jpaQueryFactory  = jpaQueryFactory;
        this.userResponseDto  = userResponseDto;
        this.diaryResponseDto = diaryResponseDto;
    }
    
    /**
     * 모든 유저 조회
     *
     * @return response
     */
    public List<UserResponseDto> findAllTrueUser() {
        return jpaQueryFactory.selectFrom(QUser.user)
                .where(QUser.user.userStatus.eq(true))
                .fetch().stream()
                .map(u -> userResponseDto.toUserDto(u))
                .collect(Collectors.toList());
    }
    
    /**
     * 모든 다이어리 조회
     *
     * @return response
     */
    public List<DiaryResponseDto> findAllTrueDiary() {
        return jpaQueryFactory.selectFrom(QDiary.diary)
                .where(QDiary.diary.diaryStatus.eq(true))
                .fetch().stream()
                .map(d -> diaryResponseDto.toDiaryDto(d))
                .collect(Collectors.toList());
    }
}
