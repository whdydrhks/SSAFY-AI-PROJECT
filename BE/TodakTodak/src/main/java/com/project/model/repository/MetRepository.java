package com.project.model.repository;

import com.project.model.entity.Met;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MetRepository extends JpaRepository<Met, Long> {
    
    /**
     * 메트 이름으로 메트 존재 여부 확인
     *
     * @param metName
     * @return boolean
     */
    boolean existsMetByMetName(String metName);
}
