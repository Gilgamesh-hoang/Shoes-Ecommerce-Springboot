package com.shoe.dto;

import com.shoe.entities.Category;
import com.shoe.entities.ProductImage;
import com.shoe.entities.ProductSize;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
public class ProductDTO {
    private int id;
    private String name;
    private String description;
    private String thumbnail;
    private String shortDescription;
    private double price;
    private boolean isHot;
    private int quantity;
    private Category category;
    private float discount;
    private List<ProductImageDTO> images;
    private List<SizeDTO> sizes;
}