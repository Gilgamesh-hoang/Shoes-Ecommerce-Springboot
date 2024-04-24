package com.shoe.entities;


import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@NoArgsConstructor
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

    @Column(name = "createdAt", columnDefinition = "DATETIME(0) DEFAULT current_timestamp(6)")
    private Timestamp createdAt;
    // Getters and setters
}