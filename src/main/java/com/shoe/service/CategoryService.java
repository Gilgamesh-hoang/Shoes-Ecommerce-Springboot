package com.shoe.service;

import com.shoe.dto.CategoryDTO;
import com.shoe.entities.Category;
import com.shoe.entities.Product;
import com.shoe.mapper.CategoryMapper;
import com.shoe.repositories.CategoryRepository;
import com.shoe.repositories.ProductRepository;
import org.owasp.encoder.Encode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.nio.file.Path;
import java.util.List;

@Service
public class CategoryService {
    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private CategoryMapper categoryMapper;
    @Autowired
    private ProductRepository productRepository;

    // This method retrieves all categories that are not marked as deleted
    public List<CategoryDTO> getAllCategories() {
        // Fetch all non-deleted categories from the repository
        List<Category> all = categoryRepository.findAllByIsDeletedIsFalse();
        // Convert the list of Category entities to a list of CategoryDTOs and return it
        return categoryMapper.toDTOs(all);
    }

    // This method updates the name and code of an existing category
    public void updateCategory(int id, String name, String code) {
        // Fetch the non-deleted category with the provided ID from the repository
        Category category = categoryRepository.findByIdAndIsDeletedIsFalse(id);
        // Update the category's name and code
        category.setName(name);
        category.setCode(code);
        encodeHtml(category);
        // Save the updated category back to the repository
        categoryRepository.save(category);
    }

    // This method adds a new category
    public void addCategory(String name, String code) {
        // Check if a non-deleted category with the same name and code already exists
        if (categoryRepository.findByNameAndCodeAndIsDeletedIsFalse(name, code) == null) {
            // If not, create a new Category entity and save it to the repository
            Category category = new Category();
            category.setName(name);
            category.setCode(code);
            encodeHtml(category);
            categoryRepository.save(category);
        }
    }

    private void encodeHtml(Category category) {
        // Encode the name and code of the category
        category.setName(Encode.forHtml(category.getName()));
        category.setCode(Encode.forHtml(category.getCode()));
    }

    // This method marks categories as deleted
    public boolean deleteCategories(String[] ids) {
        // Fetch the category marked as "isDeleted" from the repository
        Category categoryDelete = categoryRepository.findByCode("isDeleted");
        // Iterate over the provided IDs
        for (String id : ids) {
            // Fetch the non-deleted category with the current ID from the repository
            Category category = categoryRepository.findByIdAndIsDeletedIsFalse(Integer.parseInt(id));
            // Mark the category as deleted and save it back to the repository
            category.setDeleted(true);
            categoryRepository.save(category);

            // Fetch all non-deleted products of this category from the repository
            List<Product> products = productRepository.findByCategoryIdAndIsDeletedFalse(Integer.parseInt(id));
            // For each product, set its category to "isDeleted" and save it back to the repository
            for (Product product : products) {
                product.setCategory(categoryDelete);
                productRepository.save(product);
            }
        }
        // Return true to indicate that the operation was successful
        return true;
    }

    public CategoryDTO getCategoryById(int categoryId) {
        // Fetch the non-deleted category with the provided ID from the repository
        Category category = categoryRepository.findByIdAndIsDeletedIsFalse(categoryId);
        // Convert the Category entity to a CategoryDTO and return it
        return categoryMapper.toDTO(category);
    }
}
