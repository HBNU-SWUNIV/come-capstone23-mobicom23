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

    @Column(length = 100)
    private String type;
    @Column(length = 100)
    private String time;

    @Column(length = 100)
    private Double latitude;

    @Column(length = 100)
    private Double longitude;

    @Builder
    public DataEntity(Long id,String email, String type, String time, Double latitude, Double longitude) {
        this.id = id;
        this.email = email;
        this.type = type;
        this.time = time;
        this.latitude = latitude;
        this.longitude = longitude;
    }
}
