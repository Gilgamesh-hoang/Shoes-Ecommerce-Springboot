package com.shoe.dto;

import com.shoe.entities.ProductSize;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class OrderItemDTO {
    private ProductSizeDTO productSize;
    private int quantity;
    private double price;
}

