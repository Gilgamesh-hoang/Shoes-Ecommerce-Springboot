package com.shoe.service;

import com.shoe.entities.User;
import com.shoe.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserDetailServiceImpl implements UserDetailsService {

    @Autowired
    private UserRepository userRepo;

    // This method is overridden from UserDetailsService interface.
    // It is used by Spring Security to authenticate and authorize user.
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // Fetching the user from the database using the provided username.
        User user = userRepo.findByUserName(username);

        // If the user is not found in the database, throw an exception.
        if (user == null) {
            throw new UsernameNotFoundException("User not found with username: " + username);
        }

        // If the user is found, create a UserDetails object with the user's username, password, and role.
        // This UserDetails object is used by Spring Security for authentication and authorization.
        return new org.springframework.security.core.userdetails.User(user.getUserName(), user.getPassword(),
                List.of(new SimpleGrantedAuthority(user.getRole())));
    }
}
