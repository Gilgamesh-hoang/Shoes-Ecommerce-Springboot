package com.shoe.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.domain.AuditorAware;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.Optional;

@Configuration
// Enable JPA Auditing with a reference to an AuditorAware bean
@EnableJpaAuditing(auditorAwareRef = "auditorProvider")
public class JpaAuditingConfig {
    @Bean
    public AuditorAware<String> auditorProvider() {
        // Return an instance of the AuditorAwareImpl class
        return new AuditorAwareImpl();
    }

    // Define a static class that implements the AuditorAware interface
    public static class AuditorAwareImpl implements AuditorAware<String> {
        @Override
        public Optional<String> getCurrentAuditor() {
            // Get the current authentication object from the security context
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            // If the authentication object is null or not authenticated, return an empty Optional
            if (authentication == null || !authentication.isAuthenticated()) {
                return Optional.empty();
            }
            // Otherwise, return an Optional containing the name of the authenticated user
            return Optional.of(authentication.getName());
        }
    }
}