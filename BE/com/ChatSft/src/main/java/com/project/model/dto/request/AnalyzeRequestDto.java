package com.project.model.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

public class AnalyzeRequestDto {
    
    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class Graph {
        
        private Long userId;
    }
}
