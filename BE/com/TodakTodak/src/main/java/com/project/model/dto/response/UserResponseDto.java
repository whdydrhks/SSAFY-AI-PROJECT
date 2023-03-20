package com.project.model.dto.response;

import java.time.LocalDateTime;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserResponseDto {
    
    private Long               userId;
    private String             userNickname;
    private List<UserDiaryDto> userDiary;
    private LocalDateTime      userCreatedDate;
    private LocalDateTime      userModifiedDate;
    
    @Builder
    @Getter
    @AllArgsConstructor
    public static class TokenInfo {
        
        private String grantType;
        private String accessToken;
        private String refreshToken;
        private Long   refreshTokenExpirationTime;
    }
}
