package com.shoe.dto.request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
public class FilterRequest {
    private String[] categoryIds;
    private String[] sizeIds;
    private String search;
    private String sortBy;
    private int page;
}
