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

    public List<ProductSizeDTO> findByProductId(int productId) {
        return productSizeMapper.toDTOs(productSizeRepository.findByProductId(productId));
    }
}
