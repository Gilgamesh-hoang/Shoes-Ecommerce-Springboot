package com.shoe.dto.request;


import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class CartRequest {
    @NotNull(message = "productId cannot be null")
    @Min(value = 1, message = "productId must be greater than 0")
    private Integer productId;

    @NotNull(message = "sizeId cannot be null")
    @Min(value = 1, message = "sizeId must be greater than 0")
    private Integer sizeId;
}
