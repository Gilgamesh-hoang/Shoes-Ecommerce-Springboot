package com.shoe.config;

import com.shoe.service.UserDetailServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfig {
    @Autowired
    private UserDetailServiceImpl userDetails;

    @Bean
    // This method configures the security filter chain for the application.
    public SecurityFilterChain filterChain(HttpSecurity httpSecurity) throws Exception {
        return httpSecurity
                // Disable CSRF (Cross-Site Request Forgery) protection.
                .csrf(AbstractHttpConfigurer::disable)
                // Configure authorization rules for HTTP requests.
                .authorizeHttpRequests(registry -> {
                    // Requests to "/admin/**" and "/api/v1/admin/**" require the user to have the "ADMIN" authority.
                    registry.requestMatchers("/admin/**", "/api/v1/admin/**").hasAuthority("ADMIN");
                    registry.requestMatchers("/cart", "/api/v1/cart/items", "/checkout/**",
                                    "/api/v1/checkout")
                            .hasAnyAuthority("USER", "ADMIN");
                    // All other requests are permitted for all users.
                    registry.requestMatchers("/**").permitAll();
                })
                // Configure form login.
                .formLogin(httpSecurityFormLoginConfigurer -> {
                    // The login page is at "/auth/login", and the login processing URL (the action of the login form) is "/j_spring_security_check".
                    httpSecurityFormLoginConfigurer
                            .loginPage("/auth/login").loginProcessingUrl("/j_spring_security_check")
                            // The parameters for the username and password in the login form are "j_username" and "j_password", respectively.
                            .usernameParameter("j_username").passwordParameter("j_password")
                            // Use the custom AuthenticationSuccessHandler for successful logins.
                            .successHandler(new AuthenticationSuccessHandler())
                            // If login fails, redirect to "/auth/login?error".
                            .failureUrl("/auth/login?error")
                            // The login page is accessible to all users.
                            .permitAll();
                })
                // Configure logout.
                .logout(httpSecurityLogoutConfigurer -> {
                    httpSecurityLogoutConfigurer
                            // The logout URL is "/auth/logout".
                            .logoutUrl("/auth/logout")
                            // After logout, redirect to "/home".
                            .logoutSuccessUrl("/home")
                            // Invalidate the HTTP session after logout.
                            .invalidateHttpSession(true)
                            // Delete the "JSESSIONID" cookie after logout.
                            .deleteCookies("JSESSIONID");
                })
                // Build the SecurityFilterChain.
                .build();
    }


    @Bean
    public AuthenticationProvider authenticationProvider() {
        // This method is a Spring Bean that configures the AuthenticationProvider.
        // Create a new DaoAuthenticationProvider which is a concrete implementation of AuthenticationProvider.
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();

        // Set the UserDetailsService for the AuthenticationProvider.
        // UserDetailsService is used to retrieve user-related data.
        authProvider.setUserDetailsService(userDetails);

        // Set the PasswordEncoder for the AuthenticationProvider.
        // PasswordEncoder is used for encoding passwords.
        authProvider.setPasswordEncoder(passwordEncoder());

        // Return the configured AuthenticationProvider.
        return authProvider;
    }

    // This method is a Spring Bean that configures the AuthenticationManager.
    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration configuration) throws Exception {
        // Return the AuthenticationManager from the provided AuthenticationConfiguration.
        // AuthenticationManager is used to authenticate a user in the Spring Security framework.
        return configuration.getAuthenticationManager();
    }

    @Bean
    public UserDetailsService userDetailsService() {
        return userDetails;
    }

    @Bean
    PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(10);
    }
}


