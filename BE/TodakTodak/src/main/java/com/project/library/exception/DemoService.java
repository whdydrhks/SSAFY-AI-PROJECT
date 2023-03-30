package com.project.library.exception;

import org.springframework.stereotype.Service;

@Service
public class DemoService {
    
    public void triggerException() {
        throw new CustomException("Intentionally triggered exception");
    }
}
