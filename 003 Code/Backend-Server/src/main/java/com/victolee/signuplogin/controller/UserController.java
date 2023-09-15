package com.victolee.signuplogin.controller;
import com.victolee.signuplogin.JwT.JwtTokenProvider;
import com.victolee.signuplogin.domain.entity.User;
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
import java.time.LocalDateTime;
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

    @CrossOrigin(origins = "*")

    //회원가입
    @PostMapping("/join")
    public ResponseEntity<String> join(@RequestBody Map<String, String> user) {
        if (memberService.isEmailAlreadyExists(user.get("email"))) {
            String message = "이미 사용 중인 이메일입니다.";
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(message);
        }

        LocalDateTime localdatatime = LocalDateTime.now(); // 현재 날짜 및 시간을 가져옵니다.

        User newUser = User.builder()
                .email(user.get("email"))
                .password(passwordEncoder.encode(user.get("password")))
                .name(user.get("name"))
                .birth(user.get("birth"))
                .car_number(user.get("car_number"))
                .phone_number(user.get("phone_number"))
                .roles(Collections.singletonList("ROLE_USER"))
                .localDateTime(localdatatime) // 가입 날짜 및 시간 설정
                .build();

        userRepository.save(newUser);

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

  //  모든 유저 정보 확인
  //  이메일 아이디 가입시간 횟수
  @GetMapping("/list")
  public ResponseEntity<List<Map<String, Object>>> getAllUsersWithCount() {
      List<Object[]> emailCounts = dataService.getEmailsCount();
      List<User> users = memberService.getAllUsers();

      Map<String, Integer> dataCounts = new HashMap<>();
      for (Object[] row : emailCounts) {
          String email = (String) row[0];
          int count = ((Number) row[1]).intValue();
          dataCounts.put(email, count);
      }

      List<Map<String, Object>> usersWithCounts = new ArrayList<>();
      for (User user : users) {
          Map<String, Object> userData = new HashMap<>();
          userData.put("email", user.getEmail());
          userData.put("id",user.getId());
          userData.put("localDateTime", user.getLocalDateTime());

          String email = user.getEmail();
          int count = dataCounts.getOrDefault(email, 0);
          userData.put("dataCount", count);

          usersWithCounts.add(userData);
      }

      return ResponseEntity.ok(usersWithCounts);
  }


    //해당 email유저의 로그인 정보 확인
    @GetMapping("/list/{email}")
    public ResponseEntity<Map<String, Object>> getUserByEmail(@PathVariable String email) {
        User user = memberService.getUserByEmail(email);
        List<DataEntity> duplicatedUsers = dataRepository.findAllByEmail(email);

        int userDataCount = duplicatedUsers.size();

        Map<String, Object> response = new HashMap<>();

        if (user == null) {
            return ResponseEntity.notFound().build();
        }
        if (user != null) {
            response.put("UserInfo", user);
            response.put("UserDataCount", userDataCount);
        }

        return ResponseEntity.ok(response);
    }

    //해당 email유저의 데이터 정보 확인
    @GetMapping("/getData/{email}")
    public ResponseEntity<Map<String, Object>>getDuplicatedUsersByEmail(@PathVariable String email) {
        List<DataEntity> duplicatedUsers = dataRepository.findAllByEmail(email);

        Map<String, Object> response = new HashMap<>();

        int userDataCount = duplicatedUsers.size();
        response.put("DataCounts",userDataCount);
        response.put("DataInfo",duplicatedUsers);

        if (duplicatedUsers.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        return ResponseEntity.ok(response);
    }

    //해당 email유저의 로그인 정보와 데이터 정보 확인
    @GetMapping("/getUserAllData/{email}" )
    public ResponseEntity<Map<String, Object>> getUserDataAndDuplicatedUsersByEmail(@PathVariable String email) {
        User user = memberService.getUserByEmail(email);
        List<DataEntity> duplicatedUsers = dataRepository.findAllByEmail(email);
        int userDataCount = duplicatedUsers.size();

        Map<String, Object> response = new HashMap<>();

        if (user == null && duplicatedUsers.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        if (user != null) {
            response.put("UserInfo", user);
        }

        if (!duplicatedUsers.isEmpty()) {
            response.put("UsersData", duplicatedUsers);
            response.put("UserDataCount", userDataCount);
        }

        return ResponseEntity.ok(response);
    }

}

