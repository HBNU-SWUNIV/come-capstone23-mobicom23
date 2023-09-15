package com.victolee.signuplogin.domain.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
public class User implements UserDetails {

    @Id
    @JsonIgnore
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 100, nullable = false, unique = true)
    private String email;

    @Column(length = 100, nullable = false)
    private String password;
    @Column(length = 100)
    private String name;
    @Column(columnDefinition = "TIMESTAMP")
    private LocalDateTime localDateTime;
    @Column(length = 100)
    private String birth;
    @Column(length = 100)
    private String car_number;
    @Column(length = 100)
    private String phone_number;

    @ElementCollection(fetch = FetchType.EAGER)
    @Builder.Default
    @JsonIgnore
    private List<String> roles = new ArrayList<>();

    @JsonIgnore
    public LocalDateTime getRegistrationDateTime() {
        return localDateTime;
    }


    @Override
    @JsonIgnore
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return this.roles.stream()
                .map(SimpleGrantedAuthority::new)
                .collect(Collectors.toList());
    }


    @Override
    @JsonIgnore
    public boolean isAccountNonExpired() {
        return false;
    }

    @Override
    @JsonIgnore
    public boolean isAccountNonLocked() {
        return false;
    }

    @Override
    @JsonIgnore
    public boolean isCredentialsNonExpired() {
        return false;
    }

    @Override
    @JsonIgnore
    public boolean isEnabled() {
        return false;
    }
    /////////////////////
    @Override
    @JsonIgnore
    public String getUsername() {
        return email;
    }
    @JsonIgnore
    public String getPassword() {
        return this.password;
    }

    @JsonIgnore
    public void getName(String name) {
        this.name = name;
    }
    @JsonIgnore
    public void getBirth(String birth) {
        this.birth = birth;
    }
    @JsonIgnore
    public void getCar_number(String car_number){
        this.car_number= car_number;
    }
    @JsonIgnore
    public void getPhone_number(String phone_number){
        this.phone_number = phone_number;
    }
}
