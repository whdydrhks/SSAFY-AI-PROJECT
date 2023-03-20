package com.project.library.exception;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/exception")
public class DemoController {
    
    private final DemoService demoService;
    
    public DemoController(DemoService demoService) {
        this.demoService = demoService;
    }
    
    @GetMapping("/trigger-exception")
    public String triggerException() {
        demoService.triggerException();
        return "This will not be executed";
    }
}
