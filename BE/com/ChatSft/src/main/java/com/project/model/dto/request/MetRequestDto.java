package com.project.model.dto.request;

import lombok.Getter;
import lombok.Setter;

public class MetRequestDto {
    
    @Getter
    @Setter
    public static class AddMet {
        
        private String metName;
    }
}
