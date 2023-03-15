package com.project.model.entity;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.*;
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
public class Diary extends BaseTime {
    
    @Id
    @Column(name = "diary_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long diaryId;
    
    @Column(name = "diary_content")
    private String diaryContent;
    
    @Column(name = "diary_score")
    private Integer diaryScore;
    
    @Column(name = "diary_status")
    private Boolean diaryStatus;
    
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
    
    @OneToMany(mappedBy = "diary", cascade = CascadeType.ALL)
    private List<DiaryEmotion> diaryEmotions = new ArrayList<>();
    
    @OneToMany(mappedBy = "diary", cascade = CascadeType.ALL)
    private List<DiaryMet> diaryMets = new ArrayList<>();
}
