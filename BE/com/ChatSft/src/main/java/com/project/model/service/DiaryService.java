package com.project.model.service;

import com.project.model.dto.Response;
import com.project.model.dto.request.DiaryRequestDto;
import com.project.model.dto.response.DiaryResponseDto;
import com.project.model.entity.Diary;
import com.project.model.entity.DiaryEmotion;
import com.project.model.entity.DiaryMet;
import com.project.model.entity.Emotion;
import com.project.model.entity.Met;
import com.project.model.entity.User;
import com.project.model.repository.DiaryEmotionRepository;
import com.project.model.repository.DiaryMetRepository;
import com.project.model.repository.DiaryRepository;
import com.project.model.repository.EmotionRepository;
import com.project.model.repository.MetRepository;
import com.project.model.repository.UserRepository;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class DiaryService {
    
    
    private Response               response;
    private DiaryRepository        diaryRepository;
    private EmotionRepository      emotionRepository;
    private DiaryEmotionRepository diaryEmotionRepository;
    private MetRepository          metRepository;
    private DiaryMetRepository     diaryMetRepository;
    private UserRepository         userRepository;
    
    @Autowired
    public DiaryService(Response response, DiaryRepository diaryRepository, EmotionRepository emotionRepository,
            DiaryEmotionRepository diaryEmotionRepository, MetRepository metRepository,
            DiaryMetRepository diaryMetRepository, UserRepository userRepository) {
        this.response               = response;
        this.diaryRepository        = diaryRepository;
        this.emotionRepository      = emotionRepository;
        this.diaryEmotionRepository = diaryEmotionRepository;
        this.metRepository          = metRepository;
        this.diaryMetRepository     = diaryMetRepository;
        this.userRepository         = userRepository;
    }
    
    private DiaryResponseDto toDiaryDto(Diary diary) {
        DiaryResponseDto diaryResponseDto = new DiaryResponseDto();
        diaryResponseDto.setDiaryId(diary.getDiaryId());
        diaryResponseDto.setDiaryContent(diary.getDiaryContent());
        diaryResponseDto.setDiaryScore(diary.getDiaryScore());
        diaryResponseDto.setDiaryEmotion(diary.getDiaryEmotions().stream()
                .filter(DiaryEmotion::getDiaryEmotionStatus)
                .map(de -> de.getEmotion().getEmotionId())
                .collect(Collectors.toList()));
        diaryResponseDto.setDiaryMet(diary.getDiaryMets().stream()
                .filter(DiaryMet::getDiaryMetStatus)
                .map(dm -> dm.getMet().getMetId())
                .collect(Collectors.toList()));
        diaryResponseDto.setDiaryCreatedDate(diary.getCreateDate());
        diaryResponseDto.setDiaryModifiedDate(diary.getModifiedDate());
        return diaryResponseDto;
    }
    
    /**
     * 다이어리 추가
     *
     * @param addDiary
     * @return response
     */
    public ResponseEntity<?> addDiary(DiaryRequestDto.AddDiary addDiary) {
        User user = userRepository.findById(addDiary.getUserId()).get();
        
        // 같은 날짜에 이미 작성된 날짜가 있는지
        // 작성자로 일기를 검색하고 날짜를 비교하자
        List<Diary> diaryList = diaryRepository.findAllByUser(user);
        if (diaryList.size() > 0) {
            for (Diary diary : diaryList) {
                if (diary.getCreateDate().toLocalDate().equals(LocalDate.now())) {
                    return response.fail("이미 작성된 일기가 있습니다.", HttpStatus.BAD_REQUEST);
                }
            }
        }
        
        Diary diary = new Diary();
        diary.setDiaryContent(addDiary.getDiaryContent());
        diary.setDiaryScore(addDiary.getDiaryScore());
        diary.setUser(user);
        diary.setDiaryStatus(true);
        
        List<DiaryEmotion> diaryEmotions = new ArrayList<>();
        for (Long emotionId : addDiary.getDiaryEmotionIdList()) {
            
            Emotion emotion = emotionRepository.findById(emotionId)
                    .orElseThrow(() -> new RuntimeException("Emotion not found"));
            DiaryEmotion diaryEmotion = new DiaryEmotion();
            diaryEmotion.setDiaryEmotionStatus(true);
            diaryEmotion.setDiary(diary);
            diaryEmotion.setEmotion(emotion);
            diaryEmotions.add(diaryEmotion);
        }
        
        List<DiaryMet> diaryMets = new ArrayList<>();
        for (Long metId : addDiary.getDiaryMetIdList()) {
            
            Met met = metRepository.findById(metId)
                    .orElseThrow(() -> new RuntimeException("Met not found"));
            DiaryMet diaryMet = new DiaryMet();
            diaryMet.setDiaryMetStatus(true);
            diaryMet.setDiary(diary);
            diaryMet.setMet(met);
            diaryMets.add(diaryMet);
        }
        
        diary.setDiaryEmotions(diaryEmotions);
        diary.setDiaryMets(diaryMets);
        
        diaryRepository.save(diary);
        
        // 다대다 관계를 처리하는 테이블에 데이터를 저장합니다.
        diaryEmotionRepository.saveAll(diaryEmotions);
        diaryMetRepository.saveAll(diaryMets);
        
        return response.success("다이어리가 추가되었습니다");
    }
    
    /**
     * 다이어리 전체 조회
     *
     * @return response
     */
    public ResponseEntity<?> findAllDiary() {
        List<Diary> findDiaries = diaryRepository.findAll();
        
        if (findDiaries.isEmpty()) {
            return response.fail("다이어리가 존재하지 않습니다.", HttpStatus.BAD_REQUEST);
        }
        
        List<DiaryResponseDto> diaryResponseDtos = findDiaries.stream()
                .filter(Diary::getDiaryStatus)
                .map(this::toDiaryDto)
                .collect(Collectors.toList());
        
        return response.success(diaryResponseDtos);
    }
    
    /**
     * 다이어리 상세 조회
     *
     * @param diaryId
     * @return response
     */
    public ResponseEntity<?> findDiaryById(Long diaryId) {
        Optional<Diary> optionalDiary = diaryRepository.findById(diaryId);
        if (optionalDiary.isEmpty() || !optionalDiary.get().getDiaryStatus()) {
            return response.fail("존재하지 않는 다이어리입니다.", HttpStatus.BAD_REQUEST);
        }
        Diary diary = optionalDiary.get();
        return response.success(toDiaryDto(diary));
    }
    
    public ResponseEntity<?> updateDiary(DiaryRequestDto.UpdateDiary updateDiary) {
        Long  diaryId = updateDiary.getDiaryId();
        Diary diary   = diaryRepository.findById(diaryId).get();
        diary.setDiaryContent(updateDiary.getDiaryContent());
        diary.setDiaryScore(updateDiary.getDiaryScore());
        
        for (DiaryEmotion de : diary.getDiaryEmotions()) {
            de.setDiaryEmotionStatus(false);
        }
        for (DiaryMet dm : diary.getDiaryMets()) {
            dm.setDiaryMetStatus(false);
        }
        
        // 다이어리 감정, 메트를 새로 저장합니다.
        List<DiaryEmotion> diaryEmotions = new ArrayList<>();
        for (Long emotionId : updateDiary.getDiaryEmotionIdList()) {
            
            Emotion emotion = emotionRepository.findById(emotionId).get();
            
            DiaryEmotion diaryEmotion = new DiaryEmotion();
            diaryEmotion.setDiaryEmotionStatus(true);
            diaryEmotion.setDiary(diary);
            diaryEmotion.setEmotion(emotion);
            diaryEmotions.add(diaryEmotion);
        }
        List<DiaryMet> diaryMets = new ArrayList<>();
        for (Long metId : updateDiary.getDiaryMetIdList()) {
            
            Met met = metRepository.findById(metId).get();
            
            DiaryMet diaryMet = new DiaryMet();
            diaryMet.setDiaryMetStatus(true);
            diaryMet.setDiary(diary);
            diaryMet.setMet(met);
            diaryMets.add(diaryMet);
        }
        
        diary.setDiaryEmotions(diaryEmotions);
        diary.setDiaryMets(diaryMets);
        
        diaryRepository.save(diary);
        
        // 다대다 관계를 처리하는 테이블에 데이터를 저장합니다.
        diaryEmotionRepository.saveAll(diaryEmotions);
        diaryMetRepository.saveAll(diaryMets);
        
        return response.success("다이어리가 수정되었습니다");
    }
    
    public ResponseEntity<?> deleteDiary(DiaryRequestDto.DeleteDiary deleteDiary) {
        Long  diaryId = deleteDiary.getDiaryId();
        Diary diary   = diaryRepository.findById(diaryId).get();
        diary.setDiaryStatus(false);
        
        for (DiaryEmotion de : diary.getDiaryEmotions()) {
            de.setDiaryEmotionStatus(false);
        }
        for (DiaryMet dm : diary.getDiaryMets()) {
            dm.setDiaryMetStatus(false);
        }
        
        diaryRepository.save(diary);
        
        return response.success("다이어리가 삭제되었습니다");
    }
}
