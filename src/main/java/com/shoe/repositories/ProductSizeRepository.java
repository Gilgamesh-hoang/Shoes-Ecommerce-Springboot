package com.shoe.repositories;

import com.shoe.entities.ProductSize;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductSizeRepository extends JpaRepository<ProductSize, Integer> {
    List<ProductSize> findByProductIdAndIsDeletedFalse(int productId);
    List<ProductSize> findBySizeIdAndIsDeletedFalse(int sizeId);

    ProductSize findByProductIdAndSizeIdAndIsDeletedFalse(int productId, int sizeId);
}
