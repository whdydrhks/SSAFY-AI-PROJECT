package com.project.model.repository;

import com.project.model.entity.DiaryMet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DiaryMetRepository extends JpaRepository<DiaryMet, Long> {

}
