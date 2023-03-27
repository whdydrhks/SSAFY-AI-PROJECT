package com.project.model.service;

import com.project.library.JwtTokenProvider;
import com.project.model.dto.Response;
import com.project.model.dto.response.AnalyzeResponseDto;
import com.project.model.entity.Diary;
import com.project.model.entity.DiaryEmotion;
import com.project.model.entity.DiaryMet;
import com.project.model.entity.User;
import com.project.model.repository.AnalyzeQueryRepository;
import com.project.model.repository.UserRepository;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
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
    
    private AnalyzeQueryRepository analyzeQueryRepository;
    private UserRepository         userRepository;
    private Response               response;
    private JwtTokenProvider       jwtTokenProvider;
    
    @Autowired
    public AnalyzeService(AnalyzeQueryRepository analyzeQueryRepository, UserRepository userRepository,
            Response response, JwtTokenProvider jwtTokenProvider) {
        this.analyzeQueryRepository = analyzeQueryRepository;
        this.userRepository         = userRepository;
        this.response               = response;
        this.jwtTokenProvider       = jwtTokenProvider;
    }
    
    /**
     * 사용자의 분석 데이터를 조회한다.
     * 1. 지정한 연, 월의 일자별 평점 조회
     * 2. top5 조회
     * 3. 평점별 아이콘 조회
     *
     * @param accessToken accessToken
     * @param year        연도
     * @param month       월
     * @return response
     */
    public ResponseEntity<?> findGraphByUser(String accessToken, int year, int month) {
        // AT 검증
        if (!jwtTokenProvider.validateToken(accessToken)) {
            return response.fail("만료된 Access Token 입니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 유저 검증
        String userNickname = jwtTokenProvider.getAuthentication(accessToken).getName();
        User   user         = userRepository.findUserByUserNickname(userNickname).orElse(null);
        if (user == null || !user.getUserStatus()) {
            return response.fail("존재하지 않는 사용자입니다.", HttpStatus.BAD_REQUEST);
        }
        
        // 1. 차트용 연월 맞는 트루 다이어리 반환
        List<Diary> findTrueAndMatchDateDiaryList = analyzeQueryRepository.findTrueAndMatchDateDiaryList(
                user.getUserId(), year, month).orElse(Collections.emptyList());
        
        // 2. 트루 다이어리 반환
        List<Diary> findTrueDiaryList = analyzeQueryRepository.findTrueDiaryList(user.getUserId())
                .orElse(Collections.emptyList());
        
        // 3. 평점 필터 트루 다이어리 반환
        Map<Integer, Map<String, Integer>> scoreTop5Map = new LinkedHashMap<>();
        for (int i = 1; i <= 5; i++) {
            scoreTop5Map.put(i, getTop5(analyzeQueryRepository.findTrueFilterScoreDiary(user.getUserId(), i)
                    .orElse(Collections.emptyList())));
        }
        
        AnalyzeResponseDto analyzeResponseDto = new AnalyzeResponseDto(getChart(findTrueAndMatchDateDiaryList),
                getTop5(findTrueDiaryList), scoreTop5Map);
        return response.success(analyzeResponseDto);
    }
    
    /**
     * 상위 5개 반환
     *
     * @param diaryList diaryList
     * @return top5
     */
    public Map<String, Integer> getTop5(List<Diary> diaryList) {
        Map<String, Integer> frequencyData = new HashMap<>();
        
        for (Diary diary : diaryList) {
            if (!diary.getDiaryStatus()) {
                continue;
            }
            List<DiaryEmotion> diaryEmotions = diary.getDiaryEmotions();
            List<DiaryMet>     diaryMets     = diary.getDiaryMets();
            
            for (DiaryEmotion diaryEmotion : diaryEmotions) {
                String emotionName = diaryEmotion.getEmotion().getEmotionName();
                frequencyData.merge(emotionName, 1, Integer::sum);
            }
            
            for (DiaryMet diaryMet : diaryMets) {
                String metName = diaryMet.getMet().getMetName();
                frequencyData.merge(metName, 1, Integer::sum);
            }
        }
        
        List<Map.Entry<String, Integer>> list = new ArrayList<>(frequencyData.entrySet());
        list.sort(Collections.reverseOrder(Map.Entry.comparingByValue()));
        
        Map<String, Integer> result = new LinkedHashMap<>();
        int                  count  = 0;
        for (Map.Entry<String, Integer> entry : list) {
            result.put(entry.getKey(), entry.getValue());
            count++;
            if (count >= 5) {
                break;
            }
        }
        return result;
    }
    
    
    /**
     * 연 / 월 / 일의 계층형 정보로 변환
     *
     * @param diaryList diaryList
     * @return chart
     */
    public Map<Integer, Map<Integer, Map<BigDecimal, Integer>>> getChart(List<Diary> diaryList) {
        Map<Integer, Map<Integer, Map<BigDecimal, Integer>>> yearMap = new TreeMap<>();
        
        for (Diary diary : diaryList) {
            if (!diary.getDiaryStatus()) {
                continue;
            }
            int        year  = diary.getDiaryCreateDate().getYear();
            int        month = diary.getDiaryCreateDate().getMonthValue();
            BigDecimal day   = getBigDecimal(diary.getDiaryCreateDate().getDayOfMonth());
            int        score = diary.getDiaryScore();
            
            if (!yearMap.containsKey(year)) {
                yearMap.put(year, new TreeMap<>());
            }
            
            if (!yearMap.get(year).containsKey(month)) {
                yearMap.get(year).put(month, new TreeMap<>());
            }
            
            if (!yearMap.get(year).get(month).containsKey(day)) {
                yearMap.get(year).get(month).put(day, score);
            }
        }
        return yearMap;
    }
    
    /**
     * 그래프 제작을 위해 날짜 변환
     *
     * @param day day
     * @return bigDecimal
     */
    public BigDecimal getBigDecimal(int day) {
        BigDecimal bigDecimal = new BigDecimal("1");
        for (int i = 1; i < day; i++) {
            bigDecimal = bigDecimal.add(new BigDecimal("0.2"));
        }
        return bigDecimal;
    }
}
