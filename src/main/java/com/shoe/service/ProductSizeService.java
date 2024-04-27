package com.shoe.service;

import com.shoe.dto.ProductSizeDTO;
import com.shoe.entities.ProductSize;
import com.shoe.mapper.ProductSizeMapper;
import com.shoe.repositories.ProductSizeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductSizeService {
    @Autowired
    ProductSizeMapper productSizeMapper;
    @Autowired
    ProductSizeRepository productSizeRepository;

    /**
     * This method is responsible for finding product sizes by product ID.
     * It retrieves a list of ProductSize entities associated with the given product ID from the ProductSizeRepository.
     * The entities are then mapped to ProductSizeDTOs and returned.
     *
     * @param productId The ID of the product.
     * @return A list of ProductSizeDTOs associated with the product.
     */
    public List<ProductSizeDTO> findByProductId(int productId) {
        // Retrieve a list of ProductSize entities associated with the given product ID
        // from the ProductSizeRepository
        List<ProductSize> productSizes = productSizeRepository.findByProductIdAndIsDeletedFalse(productId);

        // Map the entities to ProductSizeDTOs and return
        return productSizeMapper.toDTOs(productSizes);
    }

    /**
     * This method is responsible for deleting product sizes by product ID.
     * It retrieves a list of ProductSize entities associated with the given product ID from the ProductSizeRepository.
     * Then, for each ProductSize in the list, it sets the 'deleted' field to true and saves the updated ProductSize back to the repository.
     *
     * @param id The ID of the product.
     */
    public void deleteByProductId(Integer id) {
        // Retrieve a list of ProductSize entities associated with the given product ID
        // from the ProductSizeRepository
        List<ProductSize> productSizes = productSizeRepository.findByProductIdAndIsDeletedFalse(id);

        // For each ProductSize in the list, set the 'deleted' field to true
        // and save the updated ProductSize back to the repository
        productSizes.forEach(productSize -> {
            productSize.setDeleted(true);
            productSizeRepository.save(productSize);
        });
    }
}
