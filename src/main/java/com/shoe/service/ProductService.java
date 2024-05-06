package com.shoe.service;

import com.shoe.dto.ProductDTO;
import com.shoe.dto.ProductSizeDTO;
import com.shoe.dto.SizeDTO;
import com.shoe.dto.request.FilterRequest;
import com.shoe.entities.*;
import com.shoe.mapper.ProductMapper;
import com.shoe.repositories.CategoryRepository;
import com.shoe.repositories.ProductRepository;
import com.shoe.repositories.ProductSizeRepository;
import com.shoe.repositories.SizeRepository;
import org.owasp.encoder.Encode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

@Service
public class ProductService {
    @Autowired
    ProductRepository productRepository;
    @Autowired
    CloudinaryService cloudinaryService;
    @Autowired
    ProductMapper productMapper;
    @Autowired
    ProductSizeService productSizeService;
    @Autowired
    ProductImageService imageService;
    @Autowired
    CartDetailService cartDetailService;
    @Autowired
    CategoryRepository categoryRepository;
    @Autowired
    SizeRepository sizeRepository;
    @Autowired
    ProductSizeRepository productSizeRepository;

    public List<ProductDTO> getProductsByCategory(int categoryId, Pageable pageRequest) {
        Page<Product> products = productRepository.findByCategoryIdAndIsDeletedFalse(categoryId, pageRequest);
        return productMapper.toDTOs(products.stream().toList());
    }

    /**
     * Saves or updates a product along with its associated data such as thumbnail, images, and sizes.
     *
     * @param product          The DTO containing the product data to be saved or updated.
     * @param thumbnailProduct The thumbnail image file for the product.
     * @param imageProduct     The array of image files for the product.
     * @param sizeIds          The IDs of the sizes associated with the product.
     * @return True if the product is successfully saved or updated, otherwise false.
     */
    public boolean saveProduct(ProductDTO product, MultipartFile thumbnailProduct, MultipartFile[] imageProduct, String[] sizeIds) {
        Product newProduct = new Product();
        try {
            // Check if the product ID is provided and an existing product is to be updated
            if (product.getId() != 0) {
                newProduct = productRepository.findById(product.getId()).orElse(null);
                if (newProduct == null) {
                    // If the product does not exist, return false
                    return false;
                }
            }

            // Retrieve the category associated with the product
            Category category = categoryRepository.findById(product.getCategory().getId()).orElse(null);

            // Set the attributes of the product
            newProduct.setName(product.getName());
            newProduct.setPrice(product.getPrice());
            newProduct.setDescription(product.getDescription());
            newProduct.setShortDescription(product.getShortDescription());
            newProduct.setCategory(category);

            // Upload the thumbnail image if provided
            if (thumbnailProduct != null && !thumbnailProduct.isEmpty()) {
                String url = cloudinaryService.upload(thumbnailProduct).get("url").toString();
                newProduct.setThumbnail(url);
            }

            // Save or update the product in the database
            encodeHtml(newProduct);
            newProduct = productRepository.save(newProduct);

            // Upload and save the product images
            uploadImages(newProduct.getId(), imageProduct);

            // Save the product sizes
            saveProductSizes(newProduct.getId(), sizeIds);

            // Print the time taken for the operation

            // Return true to indicate successful operation
            return true;
        } catch (Exception e) {
            // Print the stack trace in case of exception
            e.printStackTrace();
        }
        // Return false in case of failure
        return false;
    }

    private void encodeHtml(Product product) {
        product.setName(Encode.forHtml(product.getName()));
        product.setDescription(Encode.forHtml(product.getDescription()));
        product.setShortDescription(Encode.forHtml(product.getShortDescription()));
    }


    private void uploadImages(int productId, MultipartFile[] imageProduct) {
        // Calculate the number of images in the 'imageProduct' array where the original filename is empty
        int size = Arrays.stream(imageProduct)
                .filter(part -> Objects.equals(part.getOriginalFilename(), ""))
                .toList()
                .size();

        // If there is at least one such image, return from the method
        if (size > 0) {
            return;
        }

        // If there are no such images, delete all images associated with the product ID
        imageService.deleteByProductId(productId);
        Product newProduct = productRepository.findById(productId).orElse(null);
        List<ProductImage> images = new ArrayList<>();

        // Create an ExecutorService with a fixed thread pool.
        ExecutorService executor = Executors.newFixedThreadPool(5);

        // Create a list to hold Future objects.
        List<Future<ProductImage>> futures = new ArrayList<>();

        for (MultipartFile image : imageProduct) {
            // Submit the task for execution and add its Future to the list.
            futures.add(executor.submit(() -> {
                String url = cloudinaryService.upload(image).get("url").toString();
                return ProductImage.builder().product(newProduct).imageUrl(url).build();
            }));
        }

        // Collect the results of the futures.
        for (Future<ProductImage> future : futures) {
            try {
                images.add(future.get());
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Shut down the executor service.
        executor.shutdown();
        imageService.saveAll(images);
    }

    private void saveProductSizes(int productId, String[] sizeIds) {
        productSizeService.deleteByProductId(productId);
        Product newProduct = productRepository.findById(productId).orElse(null);

        // Create an ExecutorService with a fixed thread pool.
        ExecutorService executor = Executors.newFixedThreadPool(5);

        // Create a list to hold Future objects.
        List<Future<Void>> futures = new ArrayList<>();

        for (String sizeId : sizeIds) {
            // Submit the task for execution and add its Future to the list.
            futures.add(executor.submit(() -> {
                Size size = sizeRepository.findById(Integer.parseInt(sizeId)).orElse(null);
                productSizeRepository.save(ProductSize.builder().product(newProduct).size(size).build());
                return null; // Callable needs to return a value, return null because we're not interested in the result.
            }));
        }

        // Collect the results of the futures.
        for (Future<Void> future : futures) {
            try {
                future.get(); // This will block until the future completes.
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        // Shut down the executor service.
        executor.shutdown();
    }

    // Deletes a product by its ID. If the product is found, it is marked as deleted and all its associated sizes and images are also deleted.
    public boolean deleteProduct(Integer id) {
        Product product = productRepository.findById(id).orElse(null);
        if (product == null) {
            return false;
        }
        product.setDeleted(true);
        productRepository.save(product);

        productSizeService.deleteByProductId(id);
        imageService.deleteByProductId(id);

        return true;
    }

    // Retrieves all non-deleted products, paginated according to the provided Pageable object.
    public List<ProductDTO> getAllProducts(Pageable pageable) {
        Page<Product> products = productRepository.findAllByIsDeletedFalse(pageable);
        return productMapper.toDTOs(products.stream().toList());
    }

    // This method filters products based on the provided FilterRequest and Pageable objects
    public List<ProductDTO> filter(FilterRequest filterRequest, Pageable pageRequest) {
        String[] categoryIds = filterRequest.getCategoryIds().length == 0 ? null : filterRequest.getCategoryIds();
        String[] sizeIds = filterRequest.getSizeIds().length == 0 ? null : filterRequest.getSizeIds();
        String search = filterRequest.getSearch();
        Page<Product> products = productRepository.filter(categoryIds, sizeIds, search, pageRequest);
        return productMapper.toDTOs(products.stream().toList());
    }

    // This method filters products based on the provided FilterRequest
    public List<ProductDTO> filter(FilterRequest filterRequest) {
        return filter(filterRequest, Pageable.unpaged());
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
        Page<Product> all = productRepository.findAllByIsDeletedFalse(pageable);
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
