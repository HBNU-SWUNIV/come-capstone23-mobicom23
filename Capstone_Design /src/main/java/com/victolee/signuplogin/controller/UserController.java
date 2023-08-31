package com.victolee.signuplogin.controller;
import com.victolee.signuplogin.JwT.JwtTokenProvider;
import com.victolee.signuplogin.domain.User;
import com.victolee.signuplogin.domain.UserAndData;
import com.victolee.signuplogin.domain.entity.DataEntity;
import com.victolee.signuplogin.domain.repository.DataRepository;
import com.victolee.signuplogin.domain.repository.UserRepository;
import com.victolee.signuplogin.service.DataService;
import com.victolee.signuplogin.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RequiredArgsConstructor
@RestController
public class UserController {

    private final PasswordEncoder passwordEncoder;
    private final JwtTokenProvider jwtTokenProvider;
    private final UserRepository userRepository;
    private final DataRepository dataRepository;
    private final DataService dataService;
    private final MemberService memberService;

    // 회원가입
//    @PostMapping("/join")
//    public Long join(@RequestBody Map<String, String> user) {
//        if (memberService.isEmailAlreadyExists(user.get("email"))) {
//            String message = "이미 사용 중인 이메일입니다.";
//            long response = Long.parseLong(message);
//            HttpStatus badRequest = HttpStatus.BAD_REQUEST;
//            return response;
//            //return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
//        }
//        return userRepository.save(User.builder()
//                .email(user.get("email"))
//                .password(passwordEncoder.encode(user.get("password")))
//                .roles(Collections.singletonList("ROLE_USER")) // 최초 가입시 USER 로 설정
//                .build()).getId();
//    }
    @CrossOrigin(origins = "http://172.20.10.7:*")

    //회원가입
    @PostMapping("/join")
    public ResponseEntity<String> join(@RequestBody Map<String, String> user) {
        if (memberService.isEmailAlreadyExists(user.get("email"))) {
            String message = "이미 사용 중인 이메일입니다.";
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(message);
        }
        userRepository.save(User.builder()
                .email(user.get("email"))
                .password(passwordEncoder.encode(user.get("password")))
                .roles(Collections.singletonList("ROLE_USER"))
                .build()).getId();
        String response = "POST 요청이 성공적으로 처리되었습니다.";
        return ResponseEntity.ok(response);
    }

    // 로그인
    @PostMapping("/login")
    public String login(@RequestBody Map<String, String> user) {
        User member = userRepository.findByEmail(user.get("email"))
                .orElseThrow(() -> new IllegalArgumentException("가입되지 않은 E-MAIL 입니다."));
        if (!passwordEncoder.matches(user.get("password"), member.getPassword())) {
            throw new IllegalArgumentException("잘못된 비밀번호입니다.");
        }
        return jwtTokenProvider.createToken(member.getUsername(), member.getRoles());
    }

    //모든 유저의 로그인 정보 확인
    @GetMapping("/list")
    public ResponseEntity<List<User>> getAllUsers() {
        List<User> users = memberService.getAllUsers(); // Corrected line
        return ResponseEntity.ok(users);
    }

    //해당 email유저의 로그인 정보 확인
    @GetMapping("/list/{email}")
    public ResponseEntity<User> getUserByEmail(@PathVariable String email) {
        User user = memberService.getUserByEmail(email);

        if (user == null) {
            return ResponseEntity.notFound().build();
        }

        return ResponseEntity.ok(user);
    }

    //해당 email유저의 데이터 정보 확인
    @GetMapping("/getData/{email}")
    public ResponseEntity<List<DataEntity>> getDuplicatedUsersByEmail(@PathVariable String email) {
        List<DataEntity> duplicatedUsers = dataRepository.findAllByEmail(email);

        if (duplicatedUsers.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        return ResponseEntity.ok(duplicatedUsers);
    }

    //해당 email유저의 로그인 정보와 데이터 정보 확인
    @GetMapping("/getUserAllData/{email}" )
    public ResponseEntity<Map<String, Object>> getUserDataAndDuplicatedUsersByEmail(@PathVariable String email) {
        User user = memberService.getUserByEmail(email);
        List<DataEntity> duplicatedUsers = dataRepository.findAllByEmail(email);

        Map<String, Object> response = new HashMap<>();

        if (user == null && duplicatedUsers.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        if (user != null) {
            response.put("user", user);
        }

        if (!duplicatedUsers.isEmpty()) {
            response.put("duplicatedUsers", duplicatedUsers);
        }

        return ResponseEntity.ok(response);
    }
}


