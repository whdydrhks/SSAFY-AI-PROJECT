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
    
    public Optional<List<User>> findAllUser() {
        QUser u = new QUser("u");
        
        return Optional.ofNullable(jpaQueryFactory
                .select(u)
                .from(u)
                .where(u.status.eq(true))
                .fetch());
    }
}
