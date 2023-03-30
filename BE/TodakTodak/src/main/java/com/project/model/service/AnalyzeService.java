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
import java.text.DecimalFormat;
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
            return response.fail("만료된 Access Token 입니다.", HttpStatus.UNAUTHORIZED);
        }
        
        // 유저 검증
        String userNickname = jwtTokenProvider.getAuthentication(accessToken).getName();
        User   user         = userRepository.findUserByUserNickname(userNickname).orElse(null);
        if (user == null || !user.getUserStatus()) {
            return response.fail("존재하지 않는 사용자입니다.", HttpStatus.BAD_REQUEST);
        }
        // diaryList 반환
        List<Diary> diaryList = analyzeQueryRepository.findTrueAndMatchDateDiaryList(user.getUserId(), year, month)
                .orElse(Collections.emptyList());
        if (diaryList.isEmpty()) {
            return response.fail("해당 연월에 작성된 다이어리가 없습니다.", HttpStatus.BAD_REQUEST);
        }
        
        // date
        String yearMonth = year + "-" + month;
        
        // chart
        Map<BigDecimal, String> chart = getChart(diaryList, month);
        
        // top5
        Map<String, Integer> top5 = getTop5(diaryList);
        
        // icons
        Map<Integer, Map<String, Integer>> icons = new LinkedHashMap<>();
        for (int i = 5; i >= 1; i--) {
            icons.put(i,
                    getAll(analyzeQueryRepository.findTrueAndMatchDateFilterScoreDiary(user.getUserId(), i, year, month)
                            .orElse(Collections.emptyList())));
        }
        
        // average
        Map<String, Map<String, Double>> average = getAverage(diaryList);
        
        AnalyzeResponseDto analyzeResponseDto = new AnalyzeResponseDto(yearMonth, chart, top5, icons,
                average);
        
        return response.success(analyzeResponseDto);
    }
    
    /**
     * 유저아이디로 일기 찾기
     * 일기로 일기감정, 일기메트 중 트루 찾기
     * 점수 계산
     */
    public Map<String, Map<String, Double>> getAverage(List<Diary> diaryList) {
        Map<String, Map<String, Double>> average        = new LinkedHashMap<>();
        Map<String, Double>              emotionAverage = new LinkedHashMap<>();
        Map<String, Double>              metAverage     = new LinkedHashMap<>();
        // feel
        int sumFeel1       = 0;
        int countFeel1     = 0;
        int sumFeel2       = 0;
        int countFeel2     = 0;
        int sumFeel3       = 0;
        int countFeel3     = 0;
        int sumFeel4       = 0;
        int countFeel4     = 0;
        int sumFeel5       = 0;
        int countFeel5     = 0;
        int sumRelation1   = 0;
        int countRelation1 = 0;
        int sumRelation2   = 0;
        int countRelation2 = 0;
        int sumRelation3   = 0;
        int countRelation3 = 0;
        int sumRelation4   = 0;
        int countRelation4 = 0;
        int sumRelation5   = 0;
        int countRelation5 = 0;
        for (Diary diary : diaryList) {
            List<DiaryEmotion> diaryEmotionList = diary.getDiaryEmotions();
            for (DiaryEmotion diaryEmotion : diaryEmotionList) {
                if (diaryEmotion.getEmotion().getEmotionId() == 1) {
                    sumFeel1 += diary.getDiaryScore();
                    countFeel1++;
                } else if (diaryEmotion.getEmotion().getEmotionId() == 2) {
                    sumFeel2 += diary.getDiaryScore();
                    countFeel2++;
                } else if (diaryEmotion.getEmotion().getEmotionId() == 3) {
                    sumFeel3 += diary.getDiaryScore();
                    countFeel3++;
                } else if (diaryEmotion.getEmotion().getEmotionId() == 4) {
                    sumFeel4 += diary.getDiaryScore();
                    countFeel4++;
                } else if (diaryEmotion.getEmotion().getEmotionId() == 5) {
                    sumFeel5 += diary.getDiaryScore();
                    countFeel5++;
                }
            }
            // DecimalFormat 객체 생성
            // 기쁨 슬픔 화남 놀람 우울
            DecimalFormat df     = new DecimalFormat("0.0");
            String        avgStr = df.format((double) sumFeel1 / countFeel1);
            emotionAverage.put("기쁨", Double.parseDouble(avgStr));
            avgStr = df.format((double) sumFeel2 / countFeel2);
            emotionAverage.put("슬픔", Double.parseDouble(avgStr));
            avgStr = df.format((double) sumFeel3 / countFeel3);
            emotionAverage.put("화남", Double.parseDouble(avgStr));
            avgStr = df.format((double) sumFeel4 / countFeel4);
            emotionAverage.put("놀람", Double.parseDouble(avgStr));
            avgStr = df.format((double) sumFeel5 / countFeel5);
            emotionAverage.put("우울", Double.parseDouble(avgStr));
            
            List<DiaryMet> diaryMetList = diary.getDiaryMets();
            for (DiaryMet diaryMet : diaryMetList) {
                if (diaryMet.getMet().getMetId() == 1) {
                    sumRelation1 += diary.getDiaryScore();
                    countRelation1++;
                } else if (diaryMet.getMet().getMetId() == 2) {
                    sumRelation2 += diary.getDiaryScore();
                    countRelation2++;
                } else if (diaryMet.getMet().getMetId() == 3) {
                    sumRelation3 += diary.getDiaryScore();
                    countRelation3++;
                } else if (diaryMet.getMet().getMetId() == 4) {
                    sumRelation4 += diary.getDiaryScore();
                    countRelation4++;
                } else if (diaryMet.getMet().getMetId() == 5) {
                    sumRelation5 += diary.getDiaryScore();
                    countRelation5++;
                }
            }
            // DecimalFormat 객체 생성
            // 지인 가족 친구 연인 혼자
            avgStr = df.format((double) sumRelation1 / countRelation1);
            metAverage.put("지인", Double.parseDouble(avgStr));
            avgStr = df.format((double) sumRelation2 / countRelation2);
            metAverage.put("가족", Double.parseDouble(avgStr));
            avgStr = df.format((double) sumRelation3 / countRelation3);
            metAverage.put("친구", Double.parseDouble(avgStr));
            avgStr = df.format((double) sumRelation4 / countRelation4);
            metAverage.put("연인", Double.parseDouble(avgStr));
            avgStr = df.format((double) sumRelation5 / countRelation5);
            metAverage.put("혼자", Double.parseDouble(avgStr));
        }
        average.put("feel", emotionAverage);
        average.put("relation", metAverage);
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
        // 월 조회
        if (month != -1) {
            for (Diary diary : diaryList) {
                if (!diary.getDiaryStatus()) {
                    continue;
                }
                BigDecimal bigDecimal = getBigDecimal(diary.getDiaryCreateDate().getDayOfMonth(), month);
                int        score      = diary.getDiaryScore();
                chart.put(bigDecimal, decimalFormat.format(score));
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
        
        return chart;
    }
    
    /**
     * 그래프 제작을 위해 날짜 변환
     *
     * @param value day
     * @return bigDecimal
     */
    public BigDecimal getBigDecimal(int value, int month) {
        BigDecimal bigDecimal = new BigDecimal("1.0");
        for (int i = 1; i < value; i++) {
            bigDecimal = bigDecimal.add(new BigDecimal(month == -1 ? "1.0" : "0.2"));
        }
        return bigDecimal;
    }
}
