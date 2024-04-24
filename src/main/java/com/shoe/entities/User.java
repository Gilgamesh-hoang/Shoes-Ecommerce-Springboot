package com.shoe.entities;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@NoArgsConstructor
@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "userName")
    private String userName;

    @Column(name = "email", unique = true)
    private String email;

    @Column(name = "password")
    private String password;

    @Column(name = "fullName")
    private String fullName;

    @Column(name = "role")
    private String role;

    @Column(name = "phoneNumber")
    private String phoneNumber;

    @Column(name = "otp")
    private String otp;

    @Column(name = "isDeleted", columnDefinition = "TINYINT(4) DEFAULT 0")
    private boolean isDeleted;
    @Column(name = "createdAt", columnDefinition = "DATETIME(0) DEFAULT current_timestamp(6)")
    private Timestamp createdAt;
}

