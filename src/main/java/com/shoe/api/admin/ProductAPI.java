package com.shoe.api.admin;

import com.shoe.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/admin/products")
public class ProductAPI {
    @Autowired
    ProductService productService;

    @DeleteMapping
    public ResponseEntity<String> deleteProduct(@RequestParam("id") Integer id) {
        boolean isDeleted = productService.deleteProduct(id);
        // Return a response entity with a success message
        if (isDeleted)
            return ResponseEntity.ok("Product deleted successfully");
        else {
            // Return a response entity with an error message
            return ResponseEntity.status(500).body("Failed to delete Product");
        }
    }
}
