package com.shoe.repositories;

import com.shoe.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    User findByUserName(String username);

    boolean existsByEmail(String email);
    User findByEmail(String email);

    boolean existsByUserName(String userName);

}
