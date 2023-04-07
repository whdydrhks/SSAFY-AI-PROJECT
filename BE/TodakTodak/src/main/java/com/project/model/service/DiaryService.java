package com.project.model.service;

import com.project.library.EncryptDecrypt;
import com.project.library.JwtTokenProvider;
import com.project.model.dto.Response;
import com.project.model.dto.request.DiaryRequestDto.AddDiary;
import com.project.model.dto.request.DiaryRequestDto.DeleteDiary;
import com.project.model.dto.request.DiaryRequestDto.UpdateDiary;
import com.project.model.dto.response.CalendarDiaryDto;
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
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
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
    private DiaryResponseDto       diaryResponseDto;
    private JwtTokenProvider       jwtTokenProvider;
    private EncryptDecrypt         encryptDecrypt;
    
    @Autowired
    public DiaryService(Response response, DiaryRepository diaryRepository, EmotionRepository emotionRepository,
            DiaryEmotionRepository diaryEmotionRepository, MetRepository metRepository,
            DiaryMetRepository diaryMetRepository, UserRepository userRepository,
            DiaryDetailRepository diaryDetailRepository, DiaryResponseDto diaryResponseDto,
            JwtTokenProvider jwtTokenProvider, EncryptDecrypt encryptDecrypt) {
        this.response               = response;
        this.diaryRepository        = diaryRepository;
        this.emotionRepository      = emotionRepository;
        this.diaryEmotionRepository = diaryEmotionRepository;
        this.metRepository          = metRepository;
        this.diaryMetRepository     = diaryMetRepository;
        this.userRepository         = userRepository;
        this.diaryDetailRepository  = diaryDetailRepository;
        this.diaryResponseDto       = diaryResponseDto;
        this.jwtTokenProvider       = jwtTokenProvider;
        this.encryptDecrypt         = encryptDecrypt;
    }
    
    /**
     * 다이어리 추가
     *
     * @param accessToken access token
     * @param addDiary    다이어리 추가 요청 dto
     * @return response
     */
    public ResponseEntity<?> addDiary(String accessToken, AddDiary addDiary) {
        // AT 검증
        if (!jwtTokenProvider.validateToken(accessToken)) {
            log.info("DiaryService.addDiary : 만료된 Access Token 입니다.");
            return response.fail("만료된 Access Token 입니다.", HttpStatus.UNAUTHORIZED);
        }
        
        // 유저 존재 여부 확인
        User user = userRepository.findUserByUserNickname(
                jwtTokenProvider.getAuthentication(accessToken).getName()).orElse(null);
        if (user == null) {
            log.info("DiaryService.addDiary : 해당하는 유저가 존재하지 않습니다.");
            return response.fail("해당하는 유저가 존재하지 않습니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 해당 유저의 다이어리 리스트를 가져옵니다.
        String    diaryCreateDate = addDiary.getDiaryCreateDate();
        LocalDate localDate       = LocalDate.parse(diaryCreateDate);
        List<Diary> findDiaryList = diaryRepository.findAllByUser(user).orElse(Collections.emptyList()).stream()
                .filter(Diary::getDiaryStatus)
                .filter(d -> d.getDiaryCreateDate().equals(localDate))
                .collect(Collectors.toList());
        if (!findDiaryList.isEmpty()) {
            log.info("DiaryService.addDiary : 이미 작성된 일기가 있습니다.");
            return response.fail("이미 작성된 일기가 있습니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 일기 내용 암호화
        String encryptDiaryContent = encryptDecrypt.encrypt(addDiary.getDiaryContent());
        
        // 다이어리 생성
        Diary diary = new Diary();
        diary.setDiaryContent(encryptDiaryContent);
        diary.setDiaryScore(addDiary.getDiaryScore());
        diary.setDiaryCreateDate(localDate);
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
        log.info("DiaryService.addDiary : 다이어리가 추가되었습니다.");
        return response.success("다이어리가 추가되었습니다");
    }
    
    /**
     * 다이어리 수정
     *
     * @param accessToken access token
     * @param updateDiary 다이어리 수정 요청 dto
     * @return response
     */
    public ResponseEntity<?> updateDiary(String accessToken, UpdateDiary updateDiary) {
        // AT 검증
        if (!jwtTokenProvider.validateToken(accessToken)) {
            log.info("DiaryService.updateDiary : 만료된 Access Token 입니다.");
            return response.fail("만료된 Access Token 입니다.", HttpStatus.UNAUTHORIZED);
        }
        
        // 다이어리를 가져옵니다.
        Diary diary = diaryRepository.findById(updateDiary.getDiaryId()).orElse(null);
        if (diary == null || !diary.getDiaryStatus()) {
            log.info("DiaryService.updateDiary : 작성된 다이어리가 존재하지 않습니다.");
            return response.fail("작성된 다이어리가 존재하지 않습니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 일기 내용 암호화
        String encryptDiaryContent = encryptDecrypt.encrypt(updateDiary.getDiaryContent());
        
        // 다이어리를 수정합니다.
        diary.setDiaryContent(encryptDiaryContent);
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
        log.info("DiaryService.updateDiary : 다이어리가 수정되었습니다.");
        return response.success("다이어리가 수정되었습니다");
    }
    
    /**
     * 다이어리 삭제
     *
     * @param accessToken access token
     * @param deleteDiary 다이어리 삭제 요청 dto
     * @return response
     */
    public ResponseEntity<?> deleteDiary(String accessToken, DeleteDiary deleteDiary) {
        // AT 검증 (삭제를 위해 메서드를 호출한 경우 AT 검증을 생략합니다.)
        if (!accessToken.equals("deleteUser")) {
            if (!jwtTokenProvider.validateToken(accessToken)) {
                log.info("DiaryService.deleteDiary : 만료된 Access Token 입니다.");
                return response.fail("만료된 Access Token 입니다.", HttpStatus.UNAUTHORIZED);
            }
        }
        
        // 다이어리를 가져옵니다.
        Diary diary = diaryRepository.findById(deleteDiary.getDiaryId()).orElse(null);
        if (diary == null || !diary.getDiaryStatus()) {
            log.info("DiaryService.deleteDiary : 작성된 다이어리가 존재하지 않습니다.");
            return response.fail("작성된 다이어리가 존재하지 않습니다.", HttpStatus.BAD_REQUEST);
        }
        
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
        log.info("DiaryService.deleteDiary : 다이어리가 삭제되었습니다.");
        return response.success("다이어리가 삭제되었습니다");
    }
    
    /**
     * 다이어리 상세 조회
     *
     * @param accessToken access token
     * @param diaryId     다이어리 id
     * @return response
     */
    public ResponseEntity<?> findDiaryById(String accessToken, Long diaryId) {
        // AT 검증
        if (!jwtTokenProvider.validateToken(accessToken)) {
            log.info("DiaryService.findDiaryById : 만료된 Access Token 입니다.");
            return response.fail("만료된 Access Token 입니다.", HttpStatus.UNAUTHORIZED);
        }
        
        // 다이어리를 가져옵니다.
        Diary diary = diaryRepository.findById(diaryId).orElse(null);
        if (diary == null || !diary.getDiaryStatus()) {
            log.info("DiaryService.findDiaryById : 작성된 다이어리가 존재하지 않습니다.");
            return response.fail("작성된 다이어리가 존재하지 않습니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 일기 내용 복호화
        DiaryResponseDto diaryResponseDto      = this.diaryResponseDto.toDiaryDto(diary);
        String           decryptedDiaryContent = encryptDecrypt.decrypt(diary.getDiaryContent());
        diaryResponseDto.setDiaryContent(decryptedDiaryContent);
        
        log.info("DiaryService.findDiaryById : 다이어리 상세 조회 성공");
        return response.success(diaryResponseDto);
    }
    
    /**
     * 유저 토큰으로 다이어리 조회
     *
     * @param accessToken access token
     * @return response
     */
    public ResponseEntity<?> findDiaryByUserId(String accessToken) {
        // AT 검증
        if (!jwtTokenProvider.validateToken(accessToken)) {
            log.info("DiaryService.findDiaryByUserId : 만료된 Access Token 입니다.");
            return response.fail("만료된 Access Token 입니다.", HttpStatus.UNAUTHORIZED);
        }
        
        // 인증 객체 -> 유저 닉네임 -> 유저
        Authentication authentication = jwtTokenProvider.getAuthentication(accessToken);
        String         userNickname   = authentication.getName();
        User           user           = userRepository.findUserByUserNickname(userNickname).orElse(null);
        if (user == null || !user.getUserStatus()) {
            log.info("DiaryService.findDiaryByUserId : 존재하지 않는 유저입니다.");
            return response.fail("존재하지 않는 유저입니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 다이어리 리스트를 가져옵니다.
        List<Diary> findDiaries = diaryRepository.findAllByUser(user).orElse(Collections.emptyList());
        if (findDiaries.isEmpty()) {
            log.info("DiaryService.findDiaryByUserId : 다이어리가 존재하지 않습니다.");
            return response.fail("다이어리가 존재하지 않습니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 암호화된 다이어리 내용을 복호화 후 다이어리 DTO로 변환합니다.
        List<DiaryResponseDto> findDiaryDtoList = findDiaries.stream()
                .filter(Diary::getDiaryStatus)
                .map(diary -> {
                    // 일기 내용 복호화
                    String decryptedDiaryContent = encryptDecrypt.decrypt(diary.getDiaryContent());
                    
                    // 다이어리 DTO 생성
                    DiaryResponseDto diaryResponseDto = this.diaryResponseDto.toDiaryDto(diary);
                    diaryResponseDto.setDiaryContent(decryptedDiaryContent);
                    return diaryResponseDto;
                })
                .collect(Collectors.toList());
        
        if (findDiaryDtoList.isEmpty()) {
            log.info("DiaryService.findDiaryByUserId : 다이어리가 존재하지 않습니다.");
            return response.fail("다이어리가 존재하지 않습니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 다이어리 리스트를 리턴합니다.
        log.info("DiaryService.findDiaryByUserId : 유저 토큰으로 다이어리 조회 성공");
        return response.success(findDiaryDtoList);
    }
    
    /**
     * 달력에 표시할 다이어리 조회
     *
     * @param accessToken access token
     * @return response
     */
    public ResponseEntity<?> findDiaryByUserIdForCalendar(String accessToken) {
        // AT 검증
        if (!jwtTokenProvider.validateToken(accessToken)) {
            log.info("DiaryService.findDiaryByUserIdForCalendar : 만료된 Access Token 입니다.");
            return response.fail("만료된 Access Token 입니다.", HttpStatus.UNAUTHORIZED);
        }
        
        // 인증 객체 -> 유저 닉네임 -> 유저
        Authentication authentication = jwtTokenProvider.getAuthentication(accessToken);
        String         userNickname   = authentication.getName();
        User           user           = userRepository.findUserByUserNickname(userNickname).orElse(null);
        if (user == null || !user.getUserStatus()) {
            log.info("DiaryService.findDiaryByUserIdForCalendar : 존재하지 않는 유저입니다.");
            return response.fail("존재하지 않는 유저입니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 다이어리 리스트를 가져옵니다.
        List<Diary> findDiaries = diaryRepository.findAllByUser(user).orElse(Collections.emptyList());
        if (findDiaries.isEmpty()) {
            log.info("DiaryService.findDiaryByUserIdForCalendar : 다이어리가 존재하지 않습니다.");
            return response.fail("다이어리가 존재하지 않습니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 다이어리 리스트를 DTO 로 변환합니다. true 인 것만 가져옵니다.
        List<CalendarDiaryDto> findCalendarDiaryDtoList = findDiaries.stream()
                .filter(Diary::getDiaryStatus)
                .map(CalendarDiaryDto::fromEntity)
                .collect(Collectors.toList());
        
        if (findCalendarDiaryDtoList.isEmpty()) {
            log.info("DiaryService.findDiaryByUserIdForCalendar : 다이어리가 존재하지 않습니다.");
            return response.fail("다이어리가 존재하지 않습니다.", HttpStatus.BAD_REQUEST);
        }
        // 다이어리 리스트를 리턴합니다.
        log.info("DiaryService.findDiaryByUserIdForCalendar : 달력에 표시할 다이어리 조회 성공");
        return response.success(findCalendarDiaryDtoList);
    }
}
