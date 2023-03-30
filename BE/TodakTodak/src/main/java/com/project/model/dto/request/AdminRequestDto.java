package com.project.model.dto.request;

import lombok.Getter;
import lombok.Setter;

public class AdminRequestDto {
    
    @Getter
    @Setter
    public static class AdminSignup {
        
        private String password;
        private String userNickname;
        private String userDevice;
        
        public AdminSignup(String password, String userNickname, String userDevice) {
            this.password     = password;
            this.userNickname = userNickname;
            this.userDevice   = userDevice;
        }
    }
}
