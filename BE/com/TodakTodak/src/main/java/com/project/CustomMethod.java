//package com.project;
//
//import com.project.library.JwtTokenProvider;
//import com.project.model.entity.User;
//import com.project.model.repository.UserRepository;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.core.Authentication;
//import org.springframework.stereotype.Component;
//
//@Component
//public class CustomMethod {
//
//    private JwtTokenProvider jwtTokenProvider;
//    private UserRepository   userRepository;
//
//    @Autowired
//    public CustomMethod(JwtTokenProvider jwtTokenProvider, UserRepository userRepository) {
//        this.jwtTokenProvider = jwtTokenProvider;
//        this.userRepository   = userRepository;
//    }
//
//
//    // accessToken -> Authentication -> userNickname -> User
//    public User getUserIdByAccessToken(String accessToken) {
//        Authentication authentication = jwtTokenProvider.getAuthentication(accessToken);
//        authentication.getName();
//    }
//}
