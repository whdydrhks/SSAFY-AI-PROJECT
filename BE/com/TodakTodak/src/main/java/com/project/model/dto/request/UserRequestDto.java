package com.project.model.dto.request;

import lombok.Getter;
import lombok.Setter;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;

public class UserRequestDto {
    
    @Getter
    @Setter
    public static class Signup {
        
        private String userNickname;
        private String userDevice;
        
        public Signup(String userNickname, String userDevice) {
            this.userNickname = userNickname;
            this.userDevice   = userDevice;
        }
    }
    
    
    @Getter
    @Setter
    public static class Login {
        
        private String userNickname;
        private String userDevice;
        
        public Login(String userNickname, String userDevice) {
            this.userNickname = userNickname;
            this.userDevice   = userDevice;
        }
        
        public UsernamePasswordAuthenticationToken toAuthentication() {
            return new UsernamePasswordAuthenticationToken(userNickname, userDevice);
        }
    }
    
    @Getter
    @Setter
    public static class Reissue {
        
        private String accessToken;
        private String refreshToken;
        
        public Reissue(String accessToken, String refreshToken) {
            this.accessToken  = accessToken;
            this.refreshToken = refreshToken;
        }
    }
}
