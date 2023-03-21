package com.project.model.service;

import com.project.model.dto.Response;
import com.project.model.entity.Diary;
import com.project.model.entity.DiaryEmotion;
import com.project.model.entity.DiaryMet;
import com.project.model.entity.User;
import com.project.model.repository.DiaryRepository;
import com.project.model.repository.UserRepository;
import java.time.LocalDate;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
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
    
    private DiaryRepository diaryRepository;
    private UserRepository  userRepository;
    private Response        response;
    
    @Autowired
    public AnalyzeService(DiaryRepository diaryRepository, UserRepository userRepository, Response response) {
        this.diaryRepository = diaryRepository;
        this.userRepository  = userRepository;
        this.response        = response;
    }
    
    public boolean checkUser(Long userId) {
        return userRepository.findById(userId).isEmpty();
    }
    
    public boolean checkDiary(List<Diary> findDiaries) {
        return findDiaries.isEmpty();
    }
    
    public HashMap<String, Integer> getGraphData(List<Diary> findDiaries) {
        HashMap<String, Integer> graph = new HashMap<>();
        for (Diary diary : findDiaries) {
            LocalDate diaryDate  = diary.getDiaryCreateDate().toLocalDate();
            Integer   diaryScore = diary.getDiaryScore();
            graph.put(diaryDate.toString(), diaryScore);
        }
        return graph;
    }
    
    public HashMap<String, Integer> getFrequencyData(List<Diary> findDiaries) {
        HashMap<String, Integer> frequencyData = new HashMap<>();
        
        for (Diary diary : findDiaries) {
            List<DiaryEmotion> diaryEmotions = diary.getDiaryEmotions();
            List<DiaryMet>     diaryMets     = diary.getDiaryMets();
            
            for (DiaryEmotion diaryEmotion : diaryEmotions) {
                String emotionName = diaryEmotion.getEmotion().getEmotionName();
                if (frequencyData.containsKey(emotionName)) {
                    frequencyData.put(emotionName, frequencyData.get(emotionName) + 1);
                } else {
                    frequencyData.put(emotionName, 1);
                }
            }
            
            for (DiaryMet diaryMet : diaryMets) {
                String metName = diaryMet.getMet().getMetName();
                if (frequencyData.containsKey(metName)) {
                    frequencyData.put(metName, frequencyData.get(metName) + 1);
                } else {
                    frequencyData.put(metName, 1);
                }
            }
        }
        
        return sortHashMapByValue(frequencyData);
    }
    
    public HashMap<String, Integer> sortHashMapByValue(HashMap<String, Integer> frequencyData) {
        List<Map.Entry<String, Integer>> list = new LinkedList<>(frequencyData.entrySet());
        Collections.sort(list, new Comparator<Map.Entry<String, Integer>>() {
            public int compare(Map.Entry<String, Integer> o1, Map.Entry<String, Integer> o2) {
                return (o2.getValue()).compareTo(o1.getValue());
            }
        });
        HashMap<String, Integer> sortedMap = new LinkedHashMap<>();
        for (Map.Entry<String, Integer> entry : list) {
            sortedMap.put(entry.getKey(), entry.getValue());
        }
        
        return sortedMap;
    }
    
    public HashMap<String, Integer> getFilterGraphData(List<Diary> findDiaries, Integer score1, Integer score2) {
        HashMap<String, Integer> filterGraphData = new HashMap<>();
        
        for (Diary diary : findDiaries) {
            int diaryScore = diary.getDiaryScore();
            if (diaryScore != score1 && diaryScore != score2) {
                continue;
            }
            
            List<DiaryEmotion> diaryEmotions = diary.getDiaryEmotions();
            List<DiaryMet>     diaryMets     = diary.getDiaryMets();
            
            for (DiaryEmotion diaryEmotion : diaryEmotions) {
                String emotionName = diaryEmotion.getEmotion().getEmotionName();
                if (filterGraphData.containsKey(emotionName)) {
                    filterGraphData.put(emotionName, filterGraphData.get(emotionName) + 1);
                } else {
                    filterGraphData.put(emotionName, 1);
                }
            }
            
            for (DiaryMet diaryMet : diaryMets) {
                String metName = diaryMet.getMet().getMetName();
                if (filterGraphData.containsKey(metName)) {
                    filterGraphData.put(metName, filterGraphData.get(metName) + 1);
                } else {
                    filterGraphData.put(metName, 1);
                }
            }
        }
        
        return sortHashMapByValue(filterGraphData);
    }
    
    public ResponseEntity<?> findGraphByUserId(Long userId) {
        // check user
        User user = userRepository.findById(userId).get();
        if (checkUser(userId)) {
            return response.fail("유저가 존재하지 않습니다.", HttpStatus.BAD_REQUEST);
        }
        
        // check diary
        List<Diary> findDiaries = diaryRepository.findAllByUser(user).stream()
                .filter(Diary::getDiaryStatus)
                .collect(Collectors.toList());
        if (checkDiary(findDiaries)) {
            return response.fail("다이어리가 존재하지 않습니다.", HttpStatus.BAD_REQUEST);
        }
        
        HashMap<String, HashMap<String, Integer>> graphData = new HashMap<>();
        graphData.put("graph", getGraphData(findDiaries));
        graphData.put("frequency", getFrequencyData(findDiaries));
        graphData.put("filterGraph45", getFilterGraphData(findDiaries, 4, 5));
        graphData.put("filterGraph12", getFilterGraphData(findDiaries, 1, 2));
        return response.success(graphData);
    }
}
