package com.victolee.signuplogin.domain.repository;


import com.victolee.signuplogin.domain.User;
import com.victolee.signuplogin.domain.entity.DataEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import javax.xml.crypto.Data;
import java.util.List;
import java.util.Optional;

public interface DataRepository extends JpaRepository<DataEntity, Long> {
    Optional<DataEntity> findByEmail(String email);
    List<DataEntity> findAllByEmail(String email);

}