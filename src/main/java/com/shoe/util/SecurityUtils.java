package com.shoe.util;

import com.shoe.repositories.UserRepository;
import org.owasp.encoder.Encode;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;

public class SecurityUtils {

    // This method retrieves the currently authenticated user.
    // This method retrieves the currently authenticated user.
    public static User getPrincipal() {
        // Check if there is an Authentication object stored in the SecurityContext.
        if (SecurityContextHolder.getContext().getAuthentication() != null) {
            // Retrieve the principal from the Authentication object.
            Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            // If the principal is an instance of User,
            if (principal instanceof User) {
                // Cast the principal to User and return it.
                return (User) principal;
            }
        }
        // If there is no Authentication object or the principal is not an instance of User, return null.
        return null;
    }

    public static com.shoe.entities.User getUserFromPrincipal(UserRepository userRepository) {
        User principal = getPrincipal();
        com.shoe.entities.User user = userRepository.findByUserName(principal.getUsername());
        return principal == null ? null : user;
    }

}
