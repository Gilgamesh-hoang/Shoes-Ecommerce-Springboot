package com.shoe.api.user;

import com.shoe.dto.FilterDTO;
import com.shoe.dto.ProductDTO;
import com.shoe.dto.request.FilterRequest;
import com.shoe.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/filter")
public class FilterAPI {
    @Autowired
    ProductService productService;


    // This method is responsible for filtering the products based on the request parameters
    @PostMapping
    public ResponseEntity<FilterDTO> filterPage(@RequestBody FilterRequest filterRequest) {
        // Set the page size
        int pageSize = 9;

        // Get the sort option based on the sort by value in the request
        Sort sort = sortOptions().get(filterRequest.getSortBy());

        // Get the total number of products that match the filter criteria
        int totalResult = productService.filter(filterRequest).size();
        int maxPage = maxPage(totalResult, pageSize);
        if (filterRequest.getPage() > maxPage) {
            filterRequest.setPage(maxPage);
        }

        // Create a PageRequest object with the page number, page size, and sort option
        Pageable pageRequest = PageRequest.of(filterRequest.getPage() - 1, pageSize, sort);



        // Get the list of products for the requested page
        List<ProductDTO> result = productService.filter(filterRequest, pageRequest);

        // Build a FilterDTO object with the page number, product list, and maximum page number
        FilterDTO filterDTO = FilterDTO.builder().page(filterRequest.getPage())
                .list(result).maxPage(maxPage).build();

        // Return the FilterDTO object in the response
        return ResponseEntity.ok(filterDTO);
    }

    private Map<String, Sort> sortOptions() {
        Map<String, Sort> sortOptions = new HashMap<>();
        sortOptions.put("latest", Sort.by("createdAt").descending());
        sortOptions.put("oldest", Sort.by("createdAt").ascending());
        sortOptions.put("highest", Sort.by("price").descending());
        sortOptions.put("lowest", Sort.by("price").ascending());
        return sortOptions;
    }

    private static int maxPage(int totalItem, int maxPageItem) {
        return (totalItem % maxPageItem == 0) ? (totalItem / maxPageItem) : (totalItem / maxPageItem) + 1;
    }
}
