package com.shoe.config;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import java.io.IOException;

// This class extends SavedRequestAwareAuthenticationSuccessHandler to handle successful authentication events.
public class AuthenticationSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {

    // This method is called when a user has been successfully authenticated.
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws ServletException, IOException {
        // Check if the authenticated user has the "ADMIN" authority.
        boolean isAdmin = authentication.getAuthorities().stream()
                .anyMatch(grantedAuthority -> grantedAuthority.getAuthority().equals("ADMIN"));

        // If the user is an admin, set the default target URL to "/admin/products".
        if (isAdmin) {
            setDefaultTargetUrl("/admin/products");
        } else {
            // If the user is not an admin, set the default target URL to "/home".
            setDefaultTargetUrl("/home");
        }

        // Call the superclass's onAuthenticationSuccess method to continue the chain of authentication success handlers.
        super.onAuthenticationSuccess(request, response, authentication);
    }
}