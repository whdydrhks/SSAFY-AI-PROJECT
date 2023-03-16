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
        
        @NotEmpty(message = "이메일은 필수 입력값입니다.")
//        @Pattern(regexp = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,6}$", message = "이메일 형식에 맞지 않습니다.")
        private String nickname;
        
        @NotEmpty(message = "비밀번호는 필수 입력값입니다.")
        private String password;
        
        public UsernamePasswordAuthenticationToken toAuthentication() {
            return new UsernamePasswordAuthenticationToken(nickname, password);
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
        
        @NotEmpty(message = "잘못된 요청입니다.")
        private String accessToken;
        
        @NotEmpty(message = "잘못된 요청입니다.")
        private String refreshToken;
    }
}
