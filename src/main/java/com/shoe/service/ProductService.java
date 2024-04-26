package com.shoe.service;

import com.shoe.dto.ProductDTO;
import com.shoe.dto.ProductSizeDTO;
import com.shoe.dto.SizeDTO;
import com.shoe.dto.request.FilterRequest;
import com.shoe.entities.Product;
import com.shoe.mapper.ProductMapper;
import com.shoe.repositories.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
public class ProductService {
    @Autowired
    ProductRepository productRepository;

    @Autowired
    ProductMapper productMapper;
    @Autowired
    ProductSizeService productSizeService;

    // This method filters products based on the provided FilterRequest and Pageable objects
    public List<ProductDTO> filter(FilterRequest filterRequest, Pageable pageRequest) {
        // Initialize an empty list to store the filtered products
        List<ProductDTO> list = new ArrayList<>();

        // Convert the size IDs and category IDs from the FilterRequest to lists
        List<String> sizes = Arrays.asList(filterRequest.getSizeIds());
        List<String> categories = Arrays.asList(filterRequest.getCategoryIds());

        // Search for products by name using the search term from the FilterRequest and the Pageable object
        List<ProductDTO> products = searchByProductName(filterRequest.getSearch(), pageRequest);

        // Iterate over the found products
        for (ProductDTO product : products) {
            // Get the size IDs for the product
            List<Integer> sizeIds = productSizeService.findByProductId(product.getId())
                    .stream()
                    .map(ProductSizeDTO::getSize)
                    .map(SizeDTO::getId)
                    .toList();

            // If there are no categories specified, or the product's category is in the list of categories, add the product to the list
            if (categories == null || categories.isEmpty() || categories.contains(product.getCategory().getId() + "")) {
                list.add(product);
            }
            // If there are no sizes specified, or the product's size is in the list of sizes, add the product to the list
            else if (sizes == null || sizes.isEmpty() || sizes.stream().anyMatch(size -> size.contains(sizeIds + ""))) {
                list.add(product);
            }
        }

        // Return the list of filtered products
        return list;
    }

    // This method filters products based on the provided FilterRequest
    public List<ProductDTO> filter(FilterRequest filterRequest) {
        // Initialize an empty list to store the filtered products
        List<ProductDTO> list = new ArrayList<>();

        // Convert the size IDs and category IDs from the FilterRequest to lists
        List<String> sizes = Arrays.asList(filterRequest.getSizeIds());
        List<String> categories = Arrays.asList(filterRequest.getCategoryIds());

        // Search for products by name using the search term from the FilterRequest
        List<ProductDTO> products = searchByProductName(filterRequest.getSearch());

        // Iterate over the found products
        for (ProductDTO product : products) {
            // Get the size IDs for the product
            List<Integer> sizeIds = productSizeService.findByProductId(product.getId())
                    .stream()
                    .map(ProductSizeDTO::getSize)
                    .map(SizeDTO::getId)
                    .toList();

            // If there are no categories specified, or the product's category is in the list of categories, add the product to the list
            if (categories == null || categories.isEmpty()) {
                list.add(product);
            } else if (categories.contains(product.getCategory().getId() + "")) {
                list.add(product);
            }
            // If there are no sizes specified, or the product's size is in the list of sizes, add the product to the list
            else if (sizes == null || sizes.isEmpty()) {
                list.add(product);
            } else {
                // If the product's size is in the list of sizes, add the product to the list
                for (String size : sizes) {
                    if (size.contains(sizeIds + "")) {
                        list.add(product);
                        break;
                    }
                }
            }
        }

        // Return the list of filtered products
        return list;
    }

    // This method searches for products by name using the provided search term and Pageable object
    public List<ProductDTO> searchByProductName(String search, Pageable pageRequest) {
        // Initialize an empty list to store the found products
        List<ProductDTO> result = new ArrayList<>();

        // Search for products by name that are not deleted
        Page<Product> products = productRepository.findByNameContainingAndIsDeletedFalse(search, pageRequest);

        // Iterate over the found products and map each one to a ProductDTO
        for (Product product : products) {
            result.add(productMapper.toDTO(product));
        }

        // Return the list of found products
        return result;
    }

    // This method searches for products by name using the provided search term
    public List<ProductDTO> searchByProductName(String search) {
        // If the search term is null or empty, return all products
        if (search == null || search.isEmpty()) {
            return productMapper.toDTOs(productRepository.findAll().stream().toList());
        }

        // Initialize an empty list to store the found products
        List<ProductDTO> result = new ArrayList<>();

        // Search for products by name that are not deleted
        List<Product> products = productRepository.findByNameContainingAndIsDeletedFalse(search);

        // Iterate over the found products and map each one to a ProductDTO
        for (Product product : products) {
            result.add(productMapper.toDTO(product));
        }

        // Return the list of found products
        return result;
    }

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
