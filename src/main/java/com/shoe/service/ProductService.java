package com.shoe.service;

import com.shoe.dto.ProductDTO;
import com.shoe.dto.ProductSizeDTO;
import com.shoe.dto.SizeDTO;
import com.shoe.entities.Product;
import com.shoe.mapper.ProductMapper;
import com.shoe.repositories.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductService {
    @Autowired
    ProductRepository productRepository;

    @Autowired
    ProductMapper productMapper;
    @Autowired
    ProductSizeService productSizeService;

    /**
     * Retrieves a list of similar products based on the product id.
     * The method first finds the category id of the given product id, then finds the top 4 products in the same category that are not deleted.
     * The products are then mapped to DTOs and returned.
     *
     * @param productId The id of the product for which similar products are to be found.
     * @return A list of DTOs for the similar products.
     */
    public List<ProductDTO> getSimilarProducts(int productId) {
        // Find the category id of the given product id.
        int categoryId = productRepository.findById(productId).get().getCategory().getId();

        // Find the top 4 products in the same category that are not deleted.
        // Map the products to DTOs and return the list.
        return productMapper.toDTOs(productRepository.findTop4ByCategoryIdAndIsDeletedFalse(categoryId));
    }

    /**
     * Retrieves a product by its id.
     * The method first finds the product by its id. If the product is not found, it returns null.
     * If the product is found, it is mapped to a DTO. The method then finds the product sizes for the product id,
     * maps the sizes to DTOs, and sets the sizes in the product DTO.
     * The product DTO is then returned.
     *
     * @param id The id of the product to be retrieved.
     * @return The DTO for the product, or null if the product is not found.
     */
    public ProductDTO getProductById(int id) {
        // Find the product by its id. If the product is not found, return null.
        Product product = productRepository.findById(id).orElse(null);
        if (product == null) {
            return null;
        }

        // If the product is found, map it to a DTO.
        ProductDTO dto = productMapper.toDTO(product);

        // Find the product sizes for the product id, map the sizes to DTOs.
        List<ProductSizeDTO> productSizes = productSizeService.findByProductId(id);

        // Convert the list of ProductSizeDTOs to a list of SizeDTOs.
        List<SizeDTO> list = productSizes.stream().map(ProductSizeDTO::getSize).toList();

        // Set the sizes in the product DTO.
        dto.setSizes(list);

        // Return the product DTO.
        return dto;
    }

    /**
     * Retrieves the top 4 hot products from the repository, maps them to DTOs, and returns the list.
     *
     * @return A list of DTOs for the top 4 hot products.
     */
    public List<ProductDTO> getHotProducts() {
        return productMapper.toDTOs(productRepository.findTop4ByIsHotTrueAndIsDeletedFalse());
    }

    /**
     * Retrieves all products from the repository, paginated according to the provided Pageable object,
     * maps them to DTOs, and returns the list.
     *
     * @param pageable A Pageable object specifying the pagination and sorting information.
     * @return A list of DTOs for the products.
     */
    public List<ProductDTO> getNewestProducts(Pageable pageable) {
        Page<Product> all = productRepository.findAll(pageable);
        return productMapper.toDTOs(all.stream().toList());
    }

    /**
     * Counts all products in the repository and returns the count.
     *
     * @return The total number of products in the repository.
     */
    public int countAllProducts() {
        return (int) productRepository.count();
    }


}
