package com.victolee.signuplogin.domain.entity;


import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
@Entity
@Table(name = "data")
public class DataEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String email;

    @Column(length = 20)
    private String data;

    @Column(length = 100)
    private String type;
    @Column(length = 100)
    private String time;

    @Column(length = 100)
    private String location;

    //@Column(length = 20, nullable = false)
    //private LocalDateTime time;

    @Builder
    public DataEntity(Long id,String email, String data, String type, String time, String location) {
        this.id = id;
        this.email = email;
        this.data = data;
        this.type = type;
        this.time = time;
        this.location = location;
    }
}
