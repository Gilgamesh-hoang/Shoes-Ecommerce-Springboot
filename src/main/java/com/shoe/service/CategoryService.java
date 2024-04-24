package com.shoe.service;

import com.shoe.dto.CategoryDTO;
import com.shoe.entities.Category;
import com.shoe.mapper.CategoryMapper;
import com.shoe.repositories.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryService {
    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private CategoryMapper categoryMapper;

    public List<CategoryDTO> getAllCategories() {
        List<Category> all = categoryRepository.findAll();
        return categoryMapper.toDTOs(all);
    }

}
