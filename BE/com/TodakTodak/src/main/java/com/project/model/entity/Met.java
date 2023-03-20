package com.project.model.entity;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
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
public class Met {
    
    @Id
    @Column(name = "met_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long metId;
    
    @Column(name = "met_name")
    private String metName;
    
    @OneToMany(mappedBy = "met", cascade = CascadeType.ALL)
    private List<DiaryMet> diaryMets = new ArrayList<>();
}
