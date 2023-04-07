package com.project.model.service;

import com.project.library.JwtTokenProvider;
import com.project.model.dto.Response;
import com.project.model.dto.response.AnalyzeResponseDto;
import com.project.model.entity.*;
import com.project.model.repository.*;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
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
     *
     * @param accessToken accessToken
     * @param year        year
     * @param month       month
     * @return response
     */
    public ResponseEntity<?> findGraphByUser(String accessToken, int year, int month) {
        // AT 검증
        if (!jwtTokenProvider.validateToken(accessToken)) {
            log.info("AnalyzeService.findGraphByUser: 만료된 Access Token 입니다.");
            return response.fail("만료된 Access Token 입니다.", HttpStatus.UNAUTHORIZED);
        }
        
        // 유저 검증
        String userNickname = jwtTokenProvider.getAuthentication(accessToken).getName();
        User   user         = userRepository.findUserByUserNickname(userNickname).orElse(null);
        if (user == null || !user.getUserStatus()) {
            log.info("AnalyzeService.findGraphByUser: 존재하지 않는 사용자입니다.");
            return response.fail("존재하지 않는 사용자입니다.", HttpStatus.BAD_REQUEST);
        }
        
        // diaryList 반환
        List<Diary> diaryList = analyzeQueryRepository.findTrueAndMatchDateDiaryList(user.getUserId(), year, month)
                .orElse(Collections.emptyList());
        if (diaryList.isEmpty()) {
            log.info("AnalyzeService.findGraphByUser: 해당 연월에 작성된 다이어리가 없습니다.");
            return response.fail("해당 연월에 작성된 다이어리가 없습니다.", HttpStatus.BAD_REQUEST);
        }
        
        // date
        String yearMonth = year + "-" + month;
        
        // chart
        Map<BigDecimal, String> chart = getChart(diaryList, month);
        
        // top5
        Map<String, Integer> top5 = getTop5(diaryList);
        
        // icons
        Map<Integer, Map<String, Integer>> icons = getIcons(user.getUserId(), year, month);
        
        // average
        Map<String, Map<String, Double>> average = getAverage(diaryList);
        
        AnalyzeResponseDto analyzeResponseDto = new AnalyzeResponseDto(yearMonth, chart, top5, icons,
                average);
        
        log.info("AnalyzeService.findGraphByUser: 분석 데이터 조회 성공");
        return response.success(analyzeResponseDto);
    }
    
    /**
     * 평점별 데이터 반환
     *
     * @param userId userId
     * @param year   year
     * @param month  month
     * @return icons
     */
    public Map<Integer, Map<String, Integer>> getIcons(Long userId, int year, int month) {
        Map<Integer, Map<String, Integer>> icons = new LinkedHashMap<>();
        for (int i = 5; i >= 1; i--) {
            icons.put(i,
                    getAll(analyzeQueryRepository.findTrueAndMatchDateFilterScoreDiary(userId, i, year, month)
                            .orElse(Collections.emptyList())));
        }
        log.info("AnalyzeService.getIcons: 평점별 데이터 반환 성공");
        return icons;
    }
    
    /**
     * 일기 리스트로 감정, 메트 별 평균 반환
     *
     * @param diaryList diaryList
     * @return average
     */
    public Map<String, Map<String, Double>> getAverage(List<Diary> diaryList) {
        Map<String, Map<String, Double>> average        = new LinkedHashMap<>();
        Map<String, Double>              emotionAverage = new LinkedHashMap<>();
        Map<String, Double>              metAverage     = new LinkedHashMap<>();
        DecimalFormat                    df             = new DecimalFormat("0.0");
        
        String[] emotionNames = {"", "기쁨", "슬픔", "분노", "불안", "피곤"};
        String[] metNames     = {"", "지인", "가족", "친구", "연인", "혼자"};
        
        int[] sumFeel   = new int[6];
        int[] countFeel = new int[6];
        int[] sumMet    = new int[6];
        int[] countMet  = new int[6];
        
        for (Diary diary : diaryList) {
            
            for (DiaryEmotion diaryEmotion : diary.getDiaryEmotions()) {
                int emotionId = Math.toIntExact(diaryEmotion.getEmotion().getEmotionId());
                sumFeel[emotionId] += diary.getDiaryScore();
                countFeel[emotionId]++;
            }
            
            for (DiaryMet diaryMet : diary.getDiaryMets()) {
                int metId = Math.toIntExact(diaryMet.getMet().getMetId());
                sumMet[metId] += diary.getDiaryScore();
                countMet[metId]++;
            }
            
            for (int i = 1; i <= 5; i++) {
                String emotionName   = emotionNames[i];
                String averageString = nanCheck(df.format((double) sumFeel[i] / countFeel[i]));
                emotionAverage.put(emotionName, Double.parseDouble(averageString));
            }
            
            for (int i = 1; i <= 5; i++) {
                String metName       = metNames[i];
                String averageString = nanCheck(df.format((double) sumMet[i] / countMet[i]));
                metAverage.put(metName, Double.parseDouble(averageString));
            }
            
        }
        average.put("feel", emotionAverage);
        average.put("met", metAverage);
        
        log.info("AnalyzeService.getAverage: 일기 리스트로 감정, 메트 별 평균 반환 성공");
        return average;
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
        for (Map.Entry<String, Integer> entry : list) {
            result.put(entry.getKey(), entry.getValue());
        }
        
        log.info("AnalyzeService.getTop5: 상위 5개 반환 성공");
        return result;
    }
    
    public Map<String, Integer> getAll(List<Diary> diaryList) {
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
        for (Map.Entry<String, Integer> entry : list) {
            result.put(entry.getKey(), entry.getValue());
            
        }
        
        log.info("AnalyzeService.getAll: 전체 반환 성공");
        return result;
    }
    
    /**
     * 연 / 월 / 일의 계층형 정보로 변환
     *
     * @param diaryList diaryList
     * @return chart
     */
    public Map<BigDecimal, String> getChart(List<Diary> diaryList, int month) {
        Map<BigDecimal, String> chart         = new TreeMap<>();
        DecimalFormat           decimalFormat = new DecimalFormat("#.##");
        
        int[] monthPerScore = new int[6];
        int[] monthPerCount = new int[6];
        
        if (month != -1) {
            for (Diary diary : diaryList) {
                if (!diary.getDiaryStatus()) {
                    continue;
                }
                
                int dayOfMonth = diary.getDiaryCreateDate().getDayOfMonth();
                int index      = (dayOfMonth - 1) / 5;
                if (dayOfMonth == 31) {
                    index = 5;
                }
                monthPerScore[index] += diary.getDiaryScore();
                monthPerCount[index]++;
            }
            
            for (int i = 0; i < 6; i++) {
                if (monthPerCount[i] == 0) {
                    continue;
                }
                
                double     average    = (double) monthPerScore[i] / monthPerCount[i];
                BigDecimal bigDecimal = getBigDecimal(i + 1, month);
                chart.put(bigDecimal, decimalFormat.format(average));
            }
        }
        
        // 연 조회
        if (month == -1) {
            int[]    countPerMonth = new int[12];
            int[]    sumPerMonth   = new int[12];
            double[] average       = new double[12];
            
            for (Diary diary : diaryList) {
                if (!diary.getDiaryStatus()) {
                    continue;
                }
                int monthValue = diary.getDiaryCreateDate().getMonthValue();
                countPerMonth[monthValue - 1]++;
                sumPerMonth[monthValue - 1] += diary.getDiaryScore();
            }
            
            for (int i = 0; i < 12; i++) {
                if (countPerMonth[i] == 0) {
                    continue;
                }
                
                average[i] = (double) sumPerMonth[i] / countPerMonth[i];
                BigDecimal bigDecimal = getBigDecimal(i + 1, month);
                chart.put(bigDecimal, decimalFormat.format(average[i]));
            }
        }
        
        log.info("AnalyzeService.getChart: 연 / 월 / 일의 계층형 정보로 변환 성공");
        return chart;
    }
    
    /**
     * 그래프 제작을 위해 날짜 변환
     *
     * @param value day
     * @return bigDecimal
     */
    public BigDecimal getBigDecimal(int value, int month) {
        BigDecimal bigDecimal = null;
        if (month == -1) {
            bigDecimal = new BigDecimal("1.0");
            for (int i = 1; i < value; i++) {
                bigDecimal = bigDecimal.add(new BigDecimal("1.0"));
            }
        } else {
            bigDecimal = new BigDecimal("1.5");
            for (int i = 1; i < value; i++) {
                bigDecimal = bigDecimal.add(new BigDecimal("1.0"));
            }
        }
        
        log.info("AnalyzeService.getBigDecimal: 그래프 제작을 위해 날짜 변환 성공");
        return bigDecimal;
    }
    
    /**
     * NaN 체크
     *
     * @param str str
     * @return str
     */
    public String nanCheck(String str) {
        log.info("AnalyzeService.nanCheck: NaN 체크 성공");
        return str.equals("NaN") ? "0" : str;
    }
}
