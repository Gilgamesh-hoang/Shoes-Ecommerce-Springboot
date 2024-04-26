package com.shoe.controller.user;

import com.shoe.dto.ProductDTO;
import com.shoe.service.CategoryService;
import com.shoe.service.ProductService;
import com.shoe.service.SizeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/filter")
public class FilterController {
    @Autowired
    ProductService productService;
    @Autowired
    SizeService sizeService;
    @Autowired
    CategoryService categoryService;

    @GetMapping
    public String filterPage(Model model,
                             @RequestParam(value = "search", required = false, defaultValue = "") String search) {
        // The number of products to be displayed per page.
        int pageSize = 9;

        // Create a PageRequest object for pagination and sorting.
        Pageable pageRequest = PageRequest.of(0, pageSize, Sort.by("createdAt").descending());

        List<ProductDTO> result = productService.searchByProductName(search, pageRequest);

        int totalResult = productService.searchByProductName(search).size();

        model.addAttribute("search", search);
        // Calculate the maximum page number and add it to the model.
        model.addAttribute("maxPage", maxPage(totalResult, pageSize));

        // Add the current page number to the model.
        model.addAttribute("page", 1);

        // Add the sorting criteria to the model.
        model.addAttribute("sortBy", "latest");

        // Add the list of size to the model.
        model.addAttribute("sizes", sizeService.getAllSizes());

        // Add the list of categories to the model.
        model.addAttribute("categories", categoryService.getAllCategories());

        // Add the list of products to the model.
        model.addAttribute("products", result);
        return "user/filter";
    }

    /**
     * Calculates the maximum number of pages needed to display all items.
     *
     * @param totalItem   The total number of items.
     * @param maxPageItem The maximum number of items that can be displayed on a single page.
     * @return The maximum number of pages needed.
     */
    private static int maxPage(int totalItem, int maxPageItem) {
        return (totalItem % maxPageItem == 0) ? (totalItem / maxPageItem) : (totalItem / maxPageItem) + 1;
    }

}
