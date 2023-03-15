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
                .where(u.userStatus.eq(true))
                .fetch());
    }
    
    /**
     * 회원 번호로 true 회원 조회
     *
     * @param userId
     * @return response
     */
    public Optional<User> findUserById(Long userId) {
        QUser u = new QUser("u");
        
        return Optional.ofNullable(jpaQueryFactory
                .select(u)
                .from(u)
                .where(u.userId.eq(userId).and(u.userStatus.eq(true)))
                .fetchOne());
    }
    
    /**
     * 회원 닉네임으로 true 회원 조회
     *
     * @param userNickname
     * @return response
     */
    public Optional<User> findUserByNickname(String userNickname) {
        QUser u = new QUser("u");
        
        return Optional.ofNullable(jpaQueryFactory
                .select(u)
                .from(u)
                .where(u.userNickname.eq(userNickname).and(u.userStatus.eq(true)))
                .fetchOne());
    }
}
