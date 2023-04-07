package com.project.model.service;

import com.project.model.dto.Response;
import com.project.model.dto.request.MetRequestDto;
import com.project.model.entity.Met;
import com.project.model.repository.MetRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class MetService {
    
    
    private Response      response;
    private MetRepository metRepository;
    
    @Autowired
    public MetService(Response response, MetRepository metRepository) {
        this.response      = response;
        this.metRepository = metRepository;
    }
    
    /**
     * 메트 추가
     *
     * @param addMet
     * @return response
     */
    public ResponseEntity<?> addMet(MetRequestDto.AddMet addMet) {
        if (metRepository.existsMetByMetName(addMet.getMetName())) {
            return response.fail("이미 존재하는 메트입니다.", HttpStatus.BAD_REQUEST);
        }
        
        Met met = Met.builder()
                .metName(addMet.getMetName())
                .build();
        metRepository.save(met);
        
        return response.success("메트 추가에 성공했습니다.");
    }
}
