package com.shoe.controller.admin;

import com.shoe.dto.CategoryDTO;
import com.shoe.dto.ProductDTO;
import com.shoe.dto.SizeDTO;
import com.shoe.service.CategoryService;
import com.shoe.service.ProductService;
import com.shoe.service.SizeService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

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
    public String dashboard(Model model, @RequestParam(value = "page", required = false, defaultValue = "1") Integer page,
                            @RequestParam(value = "success", required = false) String success) {
        // Define the number of products to be displayed per page
        int pageSize = 12;

        // Create a Pageable object with the current page number and the page size
        Pageable pageable = PageRequest.of(page - 1, pageSize);

        // Retrieve the products for the current page
        List<ProductDTO> allProducts = productService.getAllProducts(pageable);

        // Add the products and the current page number to the model
        model.addAttribute("products", allProducts);
        model.addAttribute("page", page);
        model.addAttribute("success", success);

        // Calculate the maximum page number and add it to the model
        model.addAttribute("maxPage", maxPage(productService.countAllProducts(), pageSize));

        // Return the name of the view to be rendered
        return "admin/product";
    }

    @PostMapping(value = "/update", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public String addOrupdate(Model model,
                              @RequestParam(required = false, value = "thumbnailProduct") MultipartFile thumbnailProduct,
                              @RequestParam(required = false, value = "imageProduct") MultipartFile[] imageProduct,
                              @RequestParam(value = "sizeIds") String[] sizeIds,
                              @ModelAttribute("product") ProductDTO product) {

        // Check if the sizeIds array is null or empty, or if the product object is null
        if (sizeIds == null || sizeIds.length == 0 || product == null) {
            // If so, add an error message to the model and redirect to the previous page
            return "redirect:/admin/products/update?error=sizeError";
        } else {
            // Otherwise, try to save the product
            boolean isSaved = productService.saveProduct(product, thumbnailProduct, imageProduct, sizeIds);

            // If the product was saved successfully, add a success message to the model
            if (isSaved) {
                return "redirect:/admin/products?success=success";
            } else {
                // If the product was not saved successfully, add an error message to the model and redirect to the previous page
                return "redirect:/admin/products/update?error=error";
            }
        }
    }

    @GetMapping("/update")
    public String detailPage(Model model, @RequestParam(value = "id", required = false) Integer productId,
                             @RequestParam(value = "error", required = false) String error) {
        // Create a new ProductDTO object
        ProductDTO product = new ProductDTO();

        // Retrieve all categories and sizes
        List<CategoryDTO> allCategories = categoryService.getAllCategories();
        List<SizeDTO> sizesSizeDTOS = sizeService.getAllSizes();

        // Add the categories and sizes to the model
        model.addAttribute("categories", allCategories);
        model.addAttribute("sizes", sizesSizeDTOS);
        model.addAttribute("error", error);

        // If a product ID was provided, retrieve the product with that ID
        if (productId != null) {
            product = productService.getProductById(productId);
        }

        // Add the product to the model
        model.addAttribute("product", product);

        // Return the name of the view to be rendered
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
