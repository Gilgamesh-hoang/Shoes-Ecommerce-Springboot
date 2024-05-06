package com.shoe.repositories;

import com.shoe.entities.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer> {
    @Query("SELECT DISTINCT p FROM Product p INNER JOIN p.productSizes ps INNER JOIN ps.size s " +
            "WHERE ((:search IS NULL OR :search = '' OR p.name LIKE %:search%) AND " +
            "(:categoryIds IS NULL OR p.category.id IN :categoryIds) AND " +
            "(:sizeIds IS NULL OR s.id IN :sizeIds))")
    Page<Product> filter(@Param("categoryIds") String[] categoryIds,
                         @Param("sizeIds") String[] sizeIds,
                         @Param("search") String search,
                         Pageable pageable);

    List<Product> findTop4ByIsHotTrueAndIsDeletedFalse();

    List<Product> findTop4ByCategoryIdAndIsDeletedFalse(int categoryId);

    List<Product> findByNameContainingAndIsDeletedFalse(String name);

    Page<Product> findByNameContainingAndIsDeletedFalse(String name, Pageable pageable);

    List<Product> findByCategoryIdAndIsDeletedFalse(int categoryId);

    Page<Product> findAllByIsDeletedFalse(Pageable pageable);

    Page<Product> findByCategoryIdAndIsDeletedFalse(int categoryId, Pageable pageRequest);
}

