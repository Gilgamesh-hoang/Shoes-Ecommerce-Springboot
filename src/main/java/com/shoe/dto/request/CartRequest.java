package com.shoe.dto.request;

import com.shoe.entities.Product;
import com.shoe.repositories.ProductRepository;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Component;

@Data
@Component
public class CartRequest {
    private Integer productId;
    private Integer sizeId;
    private Integer quantity;
    private Integer cartItemId;
}
