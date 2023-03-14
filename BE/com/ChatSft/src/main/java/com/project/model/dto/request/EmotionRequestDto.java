package com.project.model.dto.request;

import lombok.Getter;
import lombok.Setter;

public class EmotionRequestDto {
    
    @Getter
    @Setter
    public static class AddEmotion {
        
        private String emotionName;
        
        public AddEmotion(String emotionName) {
            this.emotionName = emotionName;
        }
    }
}
