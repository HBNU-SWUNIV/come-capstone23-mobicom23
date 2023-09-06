package com.victolee.signuplogin.domain.repository;


import com.victolee.signuplogin.domain.entity.DataEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface DataRepository extends JpaRepository<DataEntity, Long> {
    Optional<DataEntity> findByEmail(String email);
    List<DataEntity> findAllByEmail(String email);
    @Query("SELECT email, COUNT(email) FROM DataEntity GROUP BY email HAVING COUNT(email) > 0")
    List<Object[]> findEmailsWithCount();

}