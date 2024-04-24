package com.shoe.dto;

import com.shoe.entities.Category;
import lombok.Data;
import lombok.NoArgsConstructor;

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
    private Category category;
    private float discount;
}