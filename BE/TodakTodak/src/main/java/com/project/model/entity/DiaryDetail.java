package com.project.model.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@Entity
public class DiaryDetail {
    
    @Id
    @Column(name = "diary_detail_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long diaryDetailId;
    
    @Column(name = "diary_detail_status")
    private Boolean diaryDetailStatus;
    
    @Column(name = "diary_detail_happy_count")
    private Long diaryDetailHappyCount;
    
    @Column(name = "diary_detail_anxiety_count")
    private Long diaryDetailAnxietyCount;
    
    @Column(name = "diary_detail_sad_count")
    private Long diaryDetailSadCount;
    
    @Column(name = "diary_detail_angry_count")
    private Long diaryDetailAngryCount;
    
    @Column(name = "diary_detail_hurt_count")
    private Long diaryDetailHurtCount;
    
    @OneToOne
    @JoinColumn(name = "diary_id")
    private Diary diary;
}