package com.project.model.dto.response;

import com.project.model.entity.Diary;
import com.project.model.entity.User;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.springframework.stereotype.Component;

@Getter
@Setter
@Component
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
    
    public UserResponseDto toUserDto(User user) {
        // DTO 생성
        UserResponseDto userResponseDto = new UserResponseDto();
        userResponseDto.setUserId(user.getUserId());
        userResponseDto.setUserNickname(user.getUserNickname());
        // 일기 정보 추가
        userResponseDto.setUserDiary(user.getDiaries().stream()
                .filter(Diary::getDiaryStatus)
                .map(diary -> {
                    UserDiaryDto userDiaryDto = new UserDiaryDto();
                    userDiaryDto.setDiaryId(diary.getDiaryId());
                    userDiaryDto.setDiaryContent(diary.getDiaryContent());
                    userDiaryDto.setDiaryScore(diary.getDiaryScore());
                    // 감정 정보 추가
                    userDiaryDto.setEmotions(diary.getDiaryEmotions().stream()
                            .map(de -> {
                                EmotionResponseDto emotionResponseDto = new EmotionResponseDto();
                                emotionResponseDto.setEmotionId(de.getEmotion().getEmotionId());
                                emotionResponseDto.setEmotionName(de.getEmotion().getEmotionName());
                                return emotionResponseDto;
                            })
                            .collect(Collectors.toList()));
                    // 메트 정보 추가
                    userDiaryDto.setMets(diary.getDiaryMets().stream()
                            .map(dm -> {
                                MetResponseDto metResponseDto = new MetResponseDto();
                                metResponseDto.setMetId(dm.getMet().getMetId());
                                metResponseDto.setMetName(dm.getMet().getMetName());
                                return metResponseDto;
                            })
                            .collect(Collectors.toList()));
                    return userDiaryDto;
                })
                .collect(Collectors.toList()));
        userResponseDto.setUserCreatedDate(user.getCreateDate());
        userResponseDto.setUserModifiedDate(user.getModifiedDate());
        // DTO 리턴
        return userResponseDto;
    }
}
