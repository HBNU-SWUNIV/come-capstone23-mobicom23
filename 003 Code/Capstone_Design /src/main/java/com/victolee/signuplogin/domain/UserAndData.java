package com.victolee.signuplogin.domain;

import com.victolee.signuplogin.domain.entity.DataEntity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UserAndData {
    private User user;
    private DataEntity data;
}