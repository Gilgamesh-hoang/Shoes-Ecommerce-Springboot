package com.shoe.service;

import com.shoe.dto.ProductDTO;
import com.shoe.entities.Product;
import com.shoe.mapper.ProductMapper;
import com.shoe.repositories.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductService {
    @Autowired
    ProductRepository productRepository;

    @Autowired
    ProductMapper productMapper;

    /**
     * Retrieves the top 4 hot products from the repository, maps them to DTOs, and returns the list.
     *
     * @return A list of DTOs for the top 4 hot products.
     */
    public List<ProductDTO> getHotProducts() {
        return productMapper.toDTOs(productRepository.findTop4ByIsHotTrue());
    }

    /**
     * Retrieves all products from the repository, paginated according to the provided Pageable object,
     * maps them to DTOs, and returns the list.
     *
     * @param pageable A Pageable object specifying the pagination and sorting information.
     * @return A list of DTOs for the products.
     */
    public List<ProductDTO> getNewestProducts(Pageable pageable) {
        Page<Product> all = productRepository.findAll(pageable);
        return productMapper.toDTOs(all.stream().toList());
    }

    /**
     * Counts all products in the repository and returns the count.
     *
     * @return The total number of products in the repository.
     */
    public int countAllProducts() {
        return (int) productRepository.count();
    }


}
