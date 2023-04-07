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
     * 월이 -1 인 경우 해당 연도 전체 반환
     *
     * @param userId userId
     * @param year   year
     * @param month  month
     * @return diaryList
     */
    public Optional<List<Diary>> findTrueAndMatchDateDiaryList(Long userId, int year, int month) {
        if (month == -1) {
            return Optional.ofNullable(jpaQueryFactory
                    .selectFrom(QDiary.diary)
                    .where(QDiary.diary.user.userId.eq(userId)
                            .and(QDiary.diary.diaryStatus.eq(true))
                            .and(QDiary.diary.diaryCreateDate.year().eq(year)))
                    .fetch());
        }
        return Optional.ofNullable(jpaQueryFactory
                .selectFrom(QDiary.diary)
                .where(QDiary.diary.user.userId.eq(userId)
                        .and(QDiary.diary.diaryStatus.eq(true))
                        .and(QDiary.diary.diaryCreateDate.year().eq(year))
                        .and(QDiary.diary.diaryCreateDate.month().eq(month)))
                .fetch());
    }
    
    
    /**
     * 연월, 평점이 일치하는 트루 다이어리 반환
     * 월이 -1 인 경우 해당 연도 전체 반환
     *
     * @param userId userId
     * @param score  score
     * @param year   year
     * @param month  month
     * @return diaryList
     */
    public Optional<List<Diary>> findTrueAndMatchDateFilterScoreDiary(Long userId, Integer score, int year, int month) {
        if (month == -1) {
            return Optional.ofNullable(jpaQueryFactory
                    .selectFrom(QDiary.diary)
                    .where(QDiary.diary.user.userId.eq(userId)
                            .and(QDiary.diary.diaryStatus.eq(true))
                            .and(QDiary.diary.diaryScore.eq(score))
                            .and(QDiary.diary.diaryCreateDate.year().eq(year)))
                    .fetch());
        }
        return Optional.ofNullable(jpaQueryFactory
                .selectFrom(QDiary.diary)
                .where(QDiary.diary.user.userId.eq(userId)
                        .and(QDiary.diary.diaryStatus.eq(true))
                        .and(QDiary.diary.diaryScore.eq(score))
                        .and(QDiary.diary.diaryCreateDate.year().eq(year))
                        .and(QDiary.diary.diaryCreateDate.month().eq(month)))
                .fetch());
    }
}
