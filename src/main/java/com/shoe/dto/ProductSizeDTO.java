package com.shoe.dto;


import com.shoe.entities.Product;
import com.shoe.entities.Size;
import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@NoArgsConstructor
public class ProductSizeDTO {
    private int id;
    private SizeDTO size;
    private ProductDTO product;
}
