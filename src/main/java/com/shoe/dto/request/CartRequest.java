package com.shoe.dto.request;


import lombok.Data;

@Data
public class CartRequest {
    private Integer productId;
    private Integer sizeId;
    private Integer quantity;
    private Integer cartItemId;
}
