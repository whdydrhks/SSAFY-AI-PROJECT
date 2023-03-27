package com.project.model.repository;

import com.project.model.entity.Diary;
import com.project.model.entity.QDiary;
import com.querydsl.jpa.impl.JPAQueryFactory;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AnalyzeQueryRepository {
    
    private final JPAQueryFactory jpaQueryFactory;
    
    @Autowired
    public AnalyzeQueryRepository(JPAQueryFactory jpaQueryFactory) {
        this.jpaQueryFactory = jpaQueryFactory;
    }
    
    /**
     * 연월이 일치하는 트루 다이어리 반환
     *
     * @param userId userId
     * @param year   year
     * @param month  month
     * @return diaryList
     */
    public Optional<List<Diary>> findTrueAndMatchDateDiaryList(Long userId, int year, int month) {
        return Optional.ofNullable(jpaQueryFactory
                .selectFrom(QDiary.diary)
                .where(QDiary.diary.user.userId.eq(userId)
                        .and(QDiary.diary.diaryStatus.eq(true))
                        .and(QDiary.diary.diaryCreateDate.year().eq(year))
                        .and(QDiary.diary.diaryCreateDate.month().eq(month)))
                .fetch());
    }
    
    /**
     * 트루 다이어리 반환
     *
     * @param userId userId
     * @return diaryList
     */
    public Optional<List<Diary>> findTrueDiaryList(Long userId) {
        return Optional.ofNullable(jpaQueryFactory
                .selectFrom(QDiary.diary)
                .where(QDiary.diary.user.userId.eq(userId)
                        .and(QDiary.diary.diaryStatus.eq(true)))
                .fetch());
    }
    
    /**
     * 평점이 일치하는 트루 다이어리 반환
     *
     * @param userId userId
     * @param score  score
     * @return diaryList
     */
    public Optional<List<Diary>> findTrueFilterScoreDiary(Long userId, Integer score) {
        return Optional.ofNullable(jpaQueryFactory
                .selectFrom(QDiary.diary)
                .where(QDiary.diary.user.userId.eq(userId)
                        .and(QDiary.diary.diaryStatus.eq(true))
                        .and(QDiary.diary.diaryScore.eq(score)))
                .fetch());
    }
}
