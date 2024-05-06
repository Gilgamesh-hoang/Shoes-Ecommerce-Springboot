package com.shoe.service;

import com.shoe.dto.UserDTO;
import com.shoe.entities.User;
import com.shoe.mapper.UserMapper;
import com.shoe.repositories.UserRepository;
import org.owasp.encoder.Encode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
public class UserService {
    @Autowired
    UserRepository userRepository;
    @Autowired
    PasswordEncoder passwordEncoder;
    @Autowired
    UserMapper userMapper;
    @Autowired
    MailService mailService;

    public boolean isUserNameExists(String userName) {
        return userRepository.existsByUserName(userName);
    }

    public boolean isEmailExists(String email) {
        return userRepository.existsByEmail(email);
    }

    // This method is responsible for signing up a new user.
    public String signup(UserDTO userDTO) {
        // Convert the UserDTO object to a User entity.
        User user = userMapper.toEntity(userDTO);

        // Encode the user's password for security purposes.
        user.setPassword(passwordEncoder.encode(userDTO.getPassword()));

        // Generate a One-Time Password (OTP) for the user.
        user.setOtp(generateOTP());

        // Set the user's role to "USER".
        user.setRole("USER");

        // Save the user to the database.
        encodeHtml(user);
        user = userRepository.save(user);

        // If the user was saved successfully, send an OTP to the user's email.
        if (user != null) {
            mailService.sendMailOTP(user.getEmail(), user.getOtp(), user.getFullName());

            // Return the user's email.
            return user.getEmail();
        }

        // If the user was not saved successfully, return null.
        return null;
    }

    private void encodeHtml(User user) {
        user.setFullName(Encode.forHtml(user.getFullName()));
        user.setUserName(Encode.forHtml(user.getUserName()));
        user.setEmail(Encode.forHtml(user.getEmail()));
        user.setPhoneNumber(Encode.forHtml(user.getPhoneNumber()));
    }

    // This method is responsible for verifying a user's OTP.
    public boolean verify(String email, String otp) {
        // Find the user by their email.
        User user = userRepository.findByEmail(email);

        // If the user exists and the provided OTP matches the user's OTP, verify the user.
        if (user != null && user.getOtp().equals(otp)) {
            // Remove the OTP from the user's account.
            user.setOtp(null);

            // Save the user to the database.
            userRepository.save(user);

            // Return true to indicate that the user was verified successfully.
            return true;
        }

        // If the user does not exist or the provided OTP does not match the user's OTP, return false.
        return false;
    }

    private String generateOTP() {
        return UUID.randomUUID().toString().replaceAll("-", "").substring(0, 6);
    }

}
