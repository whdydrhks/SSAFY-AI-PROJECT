package com.project.model.dto.response;

import java.math.BigDecimal;
import java.util.Map;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.stereotype.Component;

@Getter
@Setter
@Component
@NoArgsConstructor
public class AnalyzeResponseDto {
    
    private String                             date;
    private Map<BigDecimal, String>            chart;
    private Map<String, Integer>               top5;
    private Map<Integer, Map<String, Integer>> icons;
    private Map<String, Map<String, Double>>   average;
    
    public AnalyzeResponseDto(String date, Map<BigDecimal, String> chart, Map<String, Integer> top5,
            Map<Integer, Map<String, Integer>> icons, Map<String, Map<String, Double>> average) {
        this.date    = date;
        this.chart   = chart;
        this.top5    = top5;
        this.icons   = icons;
        this.average = average;
    }
}
