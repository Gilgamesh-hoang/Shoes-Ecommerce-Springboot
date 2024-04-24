package com.shoe.mapper;

import com.shoe.dto.ProductDTO;
import com.shoe.entities.Product;
import org.mapstruct.Mapper;

import java.util.List;

@Mapper(componentModel = "spring")
public interface ProductMapper {
    ProductDTO toDTO(Product product);
    List<ProductDTO> toDTOs(List<Product> products);
}
