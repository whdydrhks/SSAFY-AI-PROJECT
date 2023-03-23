package com.project.model.dto.request;

import javax.validation.constraints.NotEmpty;
import lombok.Getter;
import lombok.Setter;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;

public class UserRequestDto {
    
    @Getter
    @Setter
    public static class SignUp {
        
        private String userNickname;
        private String userDevice;
        
        public SignUp(String userNickname, String userDevice) {
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
        
        @NotEmpty(message = "accessToken 을 입력해주세요.")
        private String accessToken;
        
        @NotEmpty(message = "refreshToken 을 입력해주세요.")
        private String refreshToken;
    }
    
    @Getter
    @Setter
    public static class Logout {
        
        private String accessToken;
        private String refreshToken;
        
        public Logout(String accessToken, String refreshToken) {
            this.accessToken  = accessToken;
            this.refreshToken = refreshToken;
        }
    }
    
    @Getter
    @Setter
    public static class Delete {
        
        private String accessToken;
        private String refreshToken;
        
        public Delete(String accessToken, String refreshToken) {
            this.accessToken  = accessToken;
            this.refreshToken = refreshToken;
        }
    }
    
    @Getter
    @Setter
    public static class Backup {
        
        private String accessToken;
        private String refreshToken;
        private String newPassword;
        
        public Backup(String accessToken, String refreshToken, String newPassword) {
            this.accessToken  = accessToken;
            this.refreshToken = refreshToken;
            this.newPassword  = newPassword;
        }
    }
}
