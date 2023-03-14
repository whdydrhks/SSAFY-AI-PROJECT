package com.project;

import com.project.model.dto.request.UserRequestDto.SignUp;
import com.project.model.service.UserService;
import javax.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class InitDb {
    
    private final initService initService;
    
    @PostConstruct
    public void init() {
        initService.userInit("김싸피", "Device1234!!");
        initService.userInit("김두한", "Device4321!!");
    }
    
    @Component
    @RequiredArgsConstructor
    static class initService {
        
        private final UserService userService;
        
        public void userInit(String userNickname, String userDevice) {
            SignUp signUp = new SignUp(userNickname, userDevice);
            userService.signUp(signUp);
        }
    }
}
