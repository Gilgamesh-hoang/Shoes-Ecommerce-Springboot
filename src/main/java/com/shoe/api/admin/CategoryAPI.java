package com.shoe.api.admin;

import com.shoe.dto.CategoryDTO;
import com.shoe.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController("CategoryAPIAdmin")
@RequestMapping("/api/v1/admin/categories")
public class CategoryAPI {
    @Autowired
    CategoryService categoryService;

    // This method is mapped to the HTTP DELETE method and the URL "/api/v1/categories"
    @DeleteMapping
    public ResponseEntity<String> deleteCategory(@RequestBody String[] ids) {
        // Call the deleteCategories method of the categoryService with the provided IDs
        categoryService.deleteCategories(ids);
        // Return a response entity with a success message
        return ResponseEntity.ok("Category deleted successfully");
    }
}
