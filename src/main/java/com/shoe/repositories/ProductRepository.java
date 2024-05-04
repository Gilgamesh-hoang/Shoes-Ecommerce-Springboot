package com.shoe.repositories;

import com.shoe.entities.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer> {
//    @Query("SELECT p FROM Product p WHERE " +
//            "(:categoryIds IS NULL OR p.category.id IN (:categoryIds)) AND " +
//            "(:sizeIds IS NULL OR p. IN (:sizeIds)) AND " +
//            "(:search IS NULL OR p.name LIKE %:search%)")
//    @Query("SELECT DISTINCT p FROM Product p INNER JOIN p.productSizes ps ")
    Page<Product> filter(String[] categoryIds, String[] sizeIds, String search, Pageable pageable);

    List<Product> findTop4ByIsHotTrueAndIsDeletedFalse();

    List<Product> findTop4ByCategoryIdAndIsDeletedFalse(int categoryId);

    List<Product> findByNameContainingAndIsDeletedFalse(String name);

    Page<Product> findByNameContainingAndIsDeletedFalse(String name, Pageable pageable);

    List<Product> findByCategoryIdAndIsDeletedFalse(int categoryId);

    Page<Product> findAllByIsDeletedFalse(Pageable pageable);

    Page<Product> findByCategoryIdAndIsDeletedFalse(int categoryId, Pageable pageRequest);
}

