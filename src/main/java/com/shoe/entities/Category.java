package com.shoe.entities;


import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.sql.Timestamp;

@Data
@NoArgsConstructor
@EntityListeners(AuditingEntityListener.class)
@Entity
@Table(name = "categories")
public class Category {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "name")
    private String name;

    @Column(name = "code")
    private String code;

    @Column(name = "isDeleted", columnDefinition = "TINYINT(4) DEFAULT 0")
    private boolean isDeleted;

    @Column(name = "createdAt")
    @Temporal(TemporalType.TIMESTAMP)
    @CreatedDate
    private Timestamp createdAt;
}