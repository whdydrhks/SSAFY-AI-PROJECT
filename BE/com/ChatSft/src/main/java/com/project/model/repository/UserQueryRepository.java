package com.project.model.repository;

import com.project.model.entity.QUser;
import com.project.model.entity.User;
import com.querydsl.jpa.impl.JPAQueryFactory;
import java.util.List;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class UserQueryRepository {
    
    private final JPAQueryFactory jpaQueryFactory;
    
    /**
     * 전체 true 회원 조회
     * todo ROLE_ADMIN 권한 필요
     *
     * @return response
     */
    public Optional<List<User>> findAllUser() {
        QUser u = new QUser("u");
        
        return Optional.ofNullable(jpaQueryFactory
                .select(u)
                .from(u)
                .where(u.status.eq(true))
                .fetch());
    }
    
    /**
     * 회원 번호로 true 회원 조회
     *
     * @param idx
     * @return response
     */
    public Optional<User> findUserByIdx(Long idx) {
        QUser u = new QUser("u");
        
        return Optional.ofNullable(jpaQueryFactory
                .select(u)
                .from(u)
                .where(u.idx.eq(idx).and(u.status.eq(true)))
                .fetchOne());
    }
    
    /**
     * 회원 닉네임으로 true 회원 조회
     *
     * @param nickname
     * @return response
     */
    public Optional<User> findUserByNickname(String nickname) {
        QUser u = new QUser("u");
        
        return Optional.ofNullable(jpaQueryFactory
                .select(u)
                .from(u)
                .where(u.nickname.eq(nickname).and(u.status.eq(true)))
                .fetchOne());
    }
}
