package com.victolee.signuplogin.controller;


import com.victolee.signuplogin.JwT.JwtTokenProvider;
import com.victolee.signuplogin.domain.entity.DataEntity;
import com.victolee.signuplogin.service.DataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.parameters.P;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@RestController
@RequestMapping( "/data")
public class DataController {
    private final DataService dataService;
    private final JwtTokenProvider jwtTokenProvider;
    @Autowired
    public DataController(DataService dataService, JwtTokenProvider jwtTokenProvider){
        this.jwtTokenProvider= jwtTokenProvider;
        this.dataService = dataService;
    }

    @PostMapping("/endpost")
    public ResponseEntity<String> createUser(@RequestBody DataEntity dataEntity) {
        dataService.saveData(dataEntity);
        String response = "POST 요청이 성공적으로 처리되었습니다.";
        System.out.println(dataEntity);
        return ResponseEntity.ok(response);
        //return "redirect:/user/login";
    }

    @PostMapping("/save")
    public ResponseEntity<String> saveData(HttpServletRequest request, @RequestBody DataEntity dataEntity) {
        String jwtToken = jwtTokenProvider.resolveToken(request);

        if (jwtToken != null && jwtTokenProvider.validateToken(jwtToken)) {
            String userPk = jwtTokenProvider.getUserPk(jwtToken); //사용자 식별

            dataService.saveData(dataEntity);
            return ResponseEntity.ok("Data saved successfully");

        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid or expired token");
        }
    }
}

