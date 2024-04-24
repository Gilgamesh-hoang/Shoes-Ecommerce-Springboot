package com.shoe.api;

import com.shoe.dto.CategoryDTO;
import com.shoe.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1/categories")
public class CategoryAPI {
    @Autowired
    CategoryService categoryService;
    @GetMapping
    public ResponseEntity<List<CategoryDTO>> getAllCategories() {
        List<CategoryDTO>allCategories = categoryService.getAllCategories();
        return ResponseEntity.ok(allCategories);
    }
}
