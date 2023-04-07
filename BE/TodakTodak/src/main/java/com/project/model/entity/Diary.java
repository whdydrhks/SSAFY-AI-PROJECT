package com.project.model.entity;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

@Builder
@Setter
@Getter
@Entity
@NoArgsConstructor
@AllArgsConstructor
@EntityListeners(AuditingEntityListener.class)
public class Diary {
    
    @Id
    @Column(name = "diary_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long diaryId;
    
    @Lob
    @Column(name = "diary_content")
    private String diaryContent;
    
    @Column(name = "diary_score")
    private Integer diaryScore;
    
    @Column(name = "diary_status")
    private Boolean diaryStatus;
    
    @Column(name = "diary_created_date")
    private LocalDate diaryCreateDate;
    
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
    
    @OneToMany(mappedBy = "diary", cascade = CascadeType.ALL)
    private List<DiaryEmotion> diaryEmotions = new ArrayList<>();
    
    @OneToMany(mappedBy = "diary", cascade = CascadeType.ALL)
    private List<DiaryMet> diaryMets = new ArrayList<>();
    
    @OneToOne(mappedBy = "diary", cascade = CascadeType.ALL)
    private DiaryDetail diaryDetail;
}
