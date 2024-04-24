package com.shoe.service;

import com.shoe.dto.ProductDTO;
import com.shoe.mapper.ProductMapper;
import com.shoe.repositories.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductService {
    @Autowired
    ProductRepository productRepository;

    @Autowired
    ProductMapper productMapper;

    public List<ProductDTO> getHotProducts() {
        return productMapper.toDTOs(productRepository.findTop4ByIsHotTrue());
    }

    public List<ProductDTO> getNewestProducts() {
        return productMapper.toDTOs(productRepository.findTop6ByOrderByCreatedAtDesc());
    }
}
