package com.shoe.repositories;

import com.shoe.entities.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer> {
    List<Product> findTop4ByIsHotTrueAndIsDeletedFalse();

    List<Product> findTop4ByCategoryIdAndIsDeletedFalse(int categoryId);

    List<Product> findByNameContainingAndIsDeletedFalse(String name);

    Page<Product> findByNameContainingAndIsDeletedFalse(String name, Pageable pageable);

    List<Product> findByCategoryIdAndIsDeletedFalse(int categoryId);

    Page<Product> findAllByIsDeletedFalse(Pageable pageable);
}

