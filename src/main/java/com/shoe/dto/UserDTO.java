package com.shoe.dto;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@NoArgsConstructor
public class UserDTO {
    private int id;
    private String userName;
    private String email;
    private String password;
    private String confirmPassword;
    private String fullName;
    private String role;
    private String phoneNumber;
}

