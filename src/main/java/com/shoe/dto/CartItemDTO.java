package com.shoe.dto;

import com.shoe.entities.Cart;
import com.shoe.entities.ProductSize;
import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class CartItemDTO {
    private int id;
    private ProductSizeDTO productSize;
    private int quantity;

}
