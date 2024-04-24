package com.shoe.controller;

import com.shoe.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/products")
public class ProductController {

    @Autowired
    ProductService productService;

    /**
     * Handles the GET request for the "/newest" endpoint.
     * This method retrieves the newest products and adds them to the model.
     *
     * @param model  The model to which the attributes will be added.
     * @param page   The page number for pagination. Default value is 1.
     * @param sortBy The sorting criteria. Default value is "latest".
     * @return The name of the view to be rendered.
     */
    @GetMapping("/newest")
    public String newestProduct(Model model,
                                @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                                @RequestParam(value = "sortBy", required = false, defaultValue = "latest") String sortBy
    ) {
        // The number of products to be displayed per page.
        int pageSize = 8;

        // Get the Sort object based on the sortBy parameter. If sortBy is not a key in the map, use a default Sort object.
        Sort sort = sortOptions().getOrDefault(sortBy, Sort.by("price").ascending());

        // Create a PageRequest object for pagination and sorting.
        Pageable pageRequest = PageRequest.of(page - 1, pageSize, sort);

        // Add the newest products to the model.
        model.addAttribute("newestProducts", productService.getNewestProducts(pageRequest));

        // Calculate the maximum page number and add it to the model.
        model.addAttribute("maxPage", maxPage(productService.countAllProducts(), pageSize));

        // Add the current page number to the model.
        model.addAttribute("page", page);

        // Add the sorting criteria to the model.
        model.addAttribute("sortBy", sortBy);

        // Return the name of the view to be rendered.
        return "user/custom-deal-page";
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

    /**
     * Creates a map of sorting options for products.
     * <p>
     * The keys of the map are the names of the sorting options, and the values are the corresponding Sort objects.
     *
     * @return A map of sorting options for products.
     */
    private Map<String, Sort> sortOptions() {
        Map<String, Sort> sortOptions = new HashMap<>();
        sortOptions.put("latest", Sort.by("createdAt").descending());
        sortOptions.put("oldest", Sort.by("createdAt").ascending());
        sortOptions.put("highest", Sort.by("price").descending());
        sortOptions.put("lowest", Sort.by("price").ascending());
        return sortOptions;
    }
}
