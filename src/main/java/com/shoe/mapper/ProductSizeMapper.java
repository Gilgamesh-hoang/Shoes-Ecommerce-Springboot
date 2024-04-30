package com.shoe.mapper;

import com.shoe.dto.ProductDTO;
import com.shoe.dto.ProductSizeDTO;
import com.shoe.entities.Product;
import com.shoe.entities.ProductSize;
import org.mapstruct.Mapper;

import java.util.List;

@Mapper(componentModel = "spring")
public interface ProductSizeMapper {
    ProductSizeDTO toDTO(ProductSize product);
    ProductSize toEntity(ProductSizeDTO productSizeDTO);
    List<ProductSizeDTO> toDTOs(List<ProductSize> products);
}
