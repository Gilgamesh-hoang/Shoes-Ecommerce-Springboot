package com.shoe.controller.admin;

import com.shoe.dto.CategoryDTO;
import com.shoe.dto.ProductDTO;
import com.shoe.dto.SizeDTO;
import com.shoe.service.CategoryService;
import com.shoe.service.ProductService;
import com.shoe.service.SizeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller("ProductControllerAdmin")
@RequestMapping("/admin/products")
public class ProductController {
    @Autowired
    CategoryService categoryService;
    @Autowired
    ProductService productService;
    @Autowired
    SizeService sizeService;
    @GetMapping()
    public String dashboard(Model model, @RequestParam(value = "page", required = false, defaultValue = "1") Integer page) {
        int pageSize = 12;
        Pageable pageable = PageRequest.of(page-1, pageSize);
        List<ProductDTO> allProducts = productService.getAllProducts(pageable);
        model.addAttribute("products", allProducts);
        model.addAttribute("page", page);
        // Calculate the maximum page number and add it to the model.
        model.addAttribute("maxPage", maxPage(productService.countAllProducts(), pageSize));

        return "admin/product";
    }
    @GetMapping("/update")
    public String detailPage(Model model, @RequestParam(value = "id", required = false) Integer productId) {
        List<CategoryDTO> allCategories = categoryService.getAllCategories();
        List<SizeDTO> sizesSizeDTOS = sizeService.getAllSizes();
        model.addAttribute("categories", allCategories);
        model.addAttribute("sizes", sizesSizeDTOS);

        if(productId != null) {
            ProductDTO product = productService.getProductById(productId);
            if (product != null) {
                model.addAttribute("product", product);
            }else {
                return "redirect:/admin/products";
            }
        }

        return "admin/product-detail";
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
