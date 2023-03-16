package com.project.model.service;

import com.project.model.dto.Response;
import com.project.model.dto.request.DiaryRequestDto;
import com.project.model.dto.response.DiaryResponseDto;
import com.project.model.entity.Diary;
import com.project.model.entity.DiaryDetail;
import com.project.model.entity.DiaryEmotion;
import com.project.model.entity.DiaryMet;
import com.project.model.entity.Emotion;
import com.project.model.entity.Met;
import com.project.model.entity.User;
import com.project.model.repository.DiaryDetailRepository;
import com.project.model.repository.DiaryEmotionRepository;
import com.project.model.repository.DiaryMetRepository;
import com.project.model.repository.DiaryRepository;
import com.project.model.repository.EmotionRepository;
import com.project.model.repository.MetRepository;
import com.project.model.repository.UserRepository;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;
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
    private DiaryDetailRepository  diaryDetailRepository;
    
    @Autowired
    public DiaryService(Response response, DiaryRepository diaryRepository, EmotionRepository emotionRepository,
            DiaryEmotionRepository diaryEmotionRepository, MetRepository metRepository,
            DiaryMetRepository diaryMetRepository, UserRepository userRepository,
            DiaryDetailRepository diaryDetailRepository) {
        this.response               = response;
        this.diaryRepository        = diaryRepository;
        this.emotionRepository      = emotionRepository;
        this.diaryEmotionRepository = diaryEmotionRepository;
        this.metRepository          = metRepository;
        this.diaryMetRepository     = diaryMetRepository;
        this.userRepository         = userRepository;
        this.diaryDetailRepository  = diaryDetailRepository;
    }
    
    /**
     * 다이어리 DTO 변환
     *
     * @param diary
     * @return diaryResponseDto
     */
    private DiaryResponseDto toDiaryDto(Diary diary) {
        // DTO 생성
        DiaryResponseDto diaryResponseDto = new DiaryResponseDto();
        diaryResponseDto.setDiaryId(diary.getDiaryId());
        diaryResponseDto.setDiaryContent(diary.getDiaryContent());
        diaryResponseDto.setDiaryScore(diary.getDiaryScore());
        // 다이어리에 속한 감정 리스트를 가져옵니다. true 인 것만 가져옵니다.
        diaryResponseDto.setDiaryEmotion(diary.getDiaryEmotions().stream()
                .filter(DiaryEmotion::getDiaryEmotionStatus)
                .map(de -> de.getEmotion().getEmotionId())
                .collect(Collectors.toList()));
        // 다이어리에 속한 메트 리스트를 가져옵니다. true 인 것만 가져옵니다.
        diaryResponseDto.setDiaryMet(diary.getDiaryMets().stream()
                .filter(DiaryMet::getDiaryMetStatus)
                .map(dm -> dm.getMet().getMetId())
                .collect(Collectors.toList()));
        diaryResponseDto.setDiaryCreatedDate(diary.getCreateDate());
        diaryResponseDto.setDiaryModifiedDate(diary.getModifiedDate());
        // 다이어리 상세 정보를 가져옵니다.
        List<Long>  diaryDetailLineEmotionCountList = new ArrayList<>();
        DiaryDetail diaryDetail                     = diary.getDiaryDetail();
        diaryDetailLineEmotionCountList.add(diaryDetail.getDiaryDetailHappyCount());
        diaryDetailLineEmotionCountList.add(diaryDetail.getDiaryDetailAnxietyCount());
        diaryDetailLineEmotionCountList.add(diaryDetail.getDiaryDetailSadCount());
        diaryDetailLineEmotionCountList.add(diaryDetail.getDiaryDetailAngryCount());
        diaryDetailLineEmotionCountList.add(diaryDetail.getDiaryDetailHurtCount());
        diaryResponseDto.setDiaryDetailLineEmotionCount(diaryDetailLineEmotionCountList);
        // DTO 리턴
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
        
        // 해당 유저의 다이어리 리스트를 가져옵니다.
        List<Diary> diaryList = diaryRepository.findAllByUser(user);
        // 같은 날짜에 이미 작성된 다이어리가 있는지 확인합니다.
        if (diaryList.size() > 0) {
            for (Diary diary : diaryList) {
                if (diary.getCreateDate().toLocalDate().equals(LocalDate.now())) {
                    // 이미 작성된 다이어리가 있습니다.
                    return response.fail("이미 작성된 일기가 있습니다.", HttpStatus.BAD_REQUEST);
                }
            }
        }
        
        // 다이어리 생성
        Diary diary = new Diary();
        diary.setDiaryContent(addDiary.getDiaryContent());
        diary.setDiaryScore(addDiary.getDiaryScore());
        diary.setUser(user);
        diary.setDiaryStatus(true);
        
        // 다이어리에 속한 감정 리스트를 생성합니다.
        List<DiaryEmotion> diaryEmotions = new ArrayList<>();
        for (Long emotionId : addDiary.getDiaryEmotionIdList()) {
            // 감정을 가져옵니다.
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
            // 메트를 가져옵니다.
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
        
        // 다이어리 감정 갯수 작업
        DiaryDetail diaryDetail = new DiaryDetail();
        diaryDetail.setDiary(diary);
        List<Long> lineEmotionCountList = addDiary.getDiaryDetailLineEmotionCountList();
        diaryDetail.setDiaryDetailHappyCount(lineEmotionCountList.get(0));
        diaryDetail.setDiaryDetailAnxietyCount(lineEmotionCountList.get(1));
        diaryDetail.setDiaryDetailSadCount(lineEmotionCountList.get(2));
        diaryDetail.setDiaryDetailAngryCount(lineEmotionCountList.get(3));
        diaryDetail.setDiaryDetailHurtCount(lineEmotionCountList.get(4));
        diaryDetail.setDiaryDetailStatus(true);
        diary.setDiaryDetail(diaryDetail);
        
        // 다이어리 저장
        diaryRepository.save(diary);
        diaryEmotionRepository.saveAll(diaryEmotions);
        diaryMetRepository.saveAll(diaryMets);
        diaryDetailRepository.save(diaryDetail);
        
        // 다이어리 추가 성공
        return response.success("다이어리가 추가되었습니다");
    }
    
    /**
     * 다이어리 전체 조회
     *
     * @return response
     */
    public ResponseEntity<?> findAllDiary() {
        // 다이어리 리스트를 가져옵니다.
        List<Diary> findDiaries = diaryRepository.findAll();
        
        // 다이어리가 존재하지 않습니다.
        if (findDiaries.isEmpty()) {
            return response.fail("다이어리가 존재하지 않습니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 다이어리 리스트를 DTO 로 변환합니다. true 인 것만 가져옵니다.
        List<DiaryResponseDto> diaryResponseDtos = findDiaries.stream()
                .filter(Diary::getDiaryStatus)
                .map(this::toDiaryDto)
                .collect(Collectors.toList());
        
        // 다이어리 리스트를 리턴합니다.
        return response.success(diaryResponseDtos);
    }
    
    /**
     * 다이어리 상세 조회
     *
     * @param diaryId
     * @return response
     */
    public ResponseEntity<?> findDiaryById(Long diaryId) {
        // 다이어리를 가져옵니다.
        Optional<Diary> optionalDiary = diaryRepository.findById(diaryId);
        if (optionalDiary.isEmpty() || !optionalDiary.get().getDiaryStatus()) {
            // 다이어리가 존재하지 않습니다.
            return response.fail("존재하지 않는 다이어리입니다.", HttpStatus.BAD_REQUEST);
        }
        // 다이어리를 DTO 로 변환합니다. true 인 것만 가져옵니다.
        DiaryResponseDto diaryResponseDto = toDiaryDto(optionalDiary.get());
        
        // 다이어리를 리턴합니다.
        return response.success(diaryResponseDto);
    }
    
    /**
     * 다이어리 수정
     *
     * @param updateDiary
     * @return response
     */
    public ResponseEntity<?> updateDiary(DiaryRequestDto.UpdateDiary updateDiary) {
        // 다이어리를 가져옵니다.
        Long  diaryId = updateDiary.getDiaryId();
        Diary diary   = diaryRepository.findById(diaryId).get();
        
        // 다이어리를 수정합니다.
        diary.setDiaryContent(updateDiary.getDiaryContent());
        diary.setDiaryScore(updateDiary.getDiaryScore());
        
        // 다이어리 감정, 메트를 삭제합니다.
        for (DiaryEmotion de : diary.getDiaryEmotions()) {
            de.setDiaryEmotionStatus(false);
        }
        for (DiaryMet dm : diary.getDiaryMets()) {
            dm.setDiaryMetStatus(false);
        }
        
        Set<Long> newEmotionIds = new HashSet<>(updateDiary.getDiaryEmotionIdList());
        Set<Long> newMetIds     = new HashSet<>(updateDiary.getDiaryMetIdList());
        
        List<DiaryEmotion> diaryEmotions = new ArrayList<>();
        for (DiaryEmotion existingDiaryEmotion : diary.getDiaryEmotions()) {
            Long existingEmotionId = existingDiaryEmotion.getEmotion().getEmotionId();
            if (newEmotionIds.contains(existingEmotionId)) {
                existingDiaryEmotion.setDiaryEmotionStatus(true);
                newEmotionIds.remove(existingEmotionId);
            } else {
                existingDiaryEmotion.setDiaryEmotionStatus(false);
            }
        }
        
        for (Long emotionId : newEmotionIds) {
            Emotion      emotion      = emotionRepository.findById(emotionId).get();
            DiaryEmotion diaryEmotion = new DiaryEmotion();
            diaryEmotion.setDiaryEmotionStatus(true);
            diaryEmotion.setDiary(diary);
            diaryEmotion.setEmotion(emotion);
            diaryEmotions.add(diaryEmotion);
        }
        
        List<DiaryMet> diaryMets = new ArrayList<>();
        for (DiaryMet existingDiaryMet : diary.getDiaryMets()) {
            Long existingMetId = existingDiaryMet.getMet().getMetId();
            if (newMetIds.contains(existingMetId)) {
                existingDiaryMet.setDiaryMetStatus(true);
                newMetIds.remove(existingMetId);
            } else {
                existingDiaryMet.setDiaryMetStatus(false);
            }
        }
        
        for (Long metId : newMetIds) {
            Met      met      = metRepository.findById(metId).get();
            DiaryMet diaryMet = new DiaryMet();
            diaryMet.setDiaryMetStatus(true);
            diaryMet.setDiary(diary);
            diaryMet.setMet(met);
            diaryMets.add(diaryMet);
        }
        
        diary.setDiaryEmotions(diaryEmotions);
        diary.setDiaryMets(diaryMets);
        
        // 다이어리 상세를 수정합니다.
        List<Long>  diaryDetailLineEmotionCountList = updateDiary.getDiaryDetailLineEmotionCountList();
        DiaryDetail diaryDetail                     = diaryDetailRepository.findByDiary(diary).get();
        diaryDetail.setDiaryDetailHappyCount(diaryDetailLineEmotionCountList.get(0));
        diaryDetail.setDiaryDetailAnxietyCount(diaryDetailLineEmotionCountList.get(1));
        diaryDetail.setDiaryDetailSadCount(diaryDetailLineEmotionCountList.get(2));
        diaryDetail.setDiaryDetailAngryCount(diaryDetailLineEmotionCountList.get(3));
        diaryDetail.setDiaryDetailHurtCount(diaryDetailLineEmotionCountList.get(4));
        
        // 다이어리 저장
        diaryRepository.save(diary);
        diaryEmotionRepository.saveAll(diaryEmotions);
        diaryMetRepository.saveAll(diaryMets);
        diaryDetailRepository.save(diaryDetail);
        
        // 다이어리 수정 성공
        return response.success("다이어리가 수정되었습니다");
    }
    
    /**
     * 다이어리 삭제
     *
     * @param deleteDiary
     * @return response
     */
    public ResponseEntity<?> deleteDiary(DiaryRequestDto.DeleteDiary deleteDiary) {
        // 다이어리를 가져옵니다.
        Long  diaryId = deleteDiary.getDiaryId();
        Diary diary   = diaryRepository.findById(diaryId).get();
        
        // 다이어리를 삭제합니다.
        diary.setDiaryStatus(false);
        
        // 다이어리 감정, 메트를 삭제합니다.
        for (DiaryEmotion de : diary.getDiaryEmotions()) {
            de.setDiaryEmotionStatus(false);
        }
        for (DiaryMet dm : diary.getDiaryMets()) {
            dm.setDiaryMetStatus(false);
        }
        
        // 다이어리 상세를 삭제합니다.
        DiaryDetail diaryDetail = diaryDetailRepository.findByDiary(diary).get();
        diaryDetail.setDiaryDetailStatus(false);
        
        // 다이어리 저장
        diaryRepository.save(diary);
        diaryDetailRepository.save(diaryDetail);
        
        // 다이어리 삭제 성공
        return response.success("다이어리가 삭제되었습니다");
    }
}
