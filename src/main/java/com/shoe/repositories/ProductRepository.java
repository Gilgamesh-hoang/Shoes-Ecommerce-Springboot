package com.shoe.repositories;

import com.shoe.entities.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer> {
    List<Product> findTop4ByIsHotTrue();

    //get 6 newest products
    List<Product> findTop6ByOrderByCreatedAtDesc();
}

