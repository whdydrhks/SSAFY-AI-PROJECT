package com.project.model.service;

import com.project.model.dto.Response;
import com.project.model.entity.Diary;
import com.project.model.entity.User;
import com.project.model.repository.DiaryRepository;
import com.project.model.repository.UserRepository;
import java.time.LocalDate;
import java.util.List;
import java.util.TreeMap;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class AnalyzeService {
    
    private DiaryService    diaryService;
    private DiaryRepository diaryRepository;
    private UserRepository  userRepository;
    private Response        response;
    
    @Autowired
    public AnalyzeService(DiaryService diaryService, DiaryRepository diaryRepository, UserRepository userRepository,
            Response response) {
        this.diaryService    = diaryService;
        this.diaryRepository = diaryRepository;
        this.userRepository  = userRepository;
        this.response        = response;
    }
    
    public ResponseEntity<?> findGraphByUserId(Long userId) {
        User user = userRepository.findById(userId).get();
        // 다이어리 리스트를 가져옵니다. (다이어리 상태가 true 인 것만)
        List<Diary> findDiaries = diaryRepository.findAllByUser(user).stream()
                .filter(Diary::getDiaryStatus)
                .collect(Collectors.toList());
        // 다이어리가 존재하지 않습니다.
        if (findDiaries.isEmpty()) {
            return response.fail("다이어리가 존재하지 않습니다.", HttpStatus.BAD_REQUEST);
        }
        
        TreeMap<LocalDate, Integer> graphData = new TreeMap<>();
        for (Diary diary : findDiaries) {
            LocalDate diaryDate  = diary.getCreateDate().toLocalDate();
            Integer   diaryScore = diary.getDiaryScore();
            graphData.put(diaryDate, diaryScore);
        }
        
        return response.success(graphData);
    }
}
