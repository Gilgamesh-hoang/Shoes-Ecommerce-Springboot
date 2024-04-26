package com.shoe.dto;

import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class FilterDTO {
    private int page;
    private int maxPage;
    List<ProductDTO> list;
}
