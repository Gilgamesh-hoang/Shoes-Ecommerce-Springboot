package com.shoe.service;

import com.shoe.entities.ProductImage;
import com.shoe.repositories.ProductImageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductImageService {
    @Autowired
    ProductImageRepository imageRepository;


    // This method is responsible for marking all ProductImage entities associated with a given product ID as deleted.
    // It first retrieves a list of ProductImage entities associated with the given product ID from the ProductImageRepository.
    // Then, for each ProductImage in the list, it sets the 'deleted' field to true and saves the updated ProductImage back to the repository.
    public void deleteByProductId(Integer id) {
        List<ProductImage> imageList = imageRepository.findByProductId(id);
        imageList.forEach(image -> {
            image.setDeleted(true);
            imageRepository.save(image);
        });
    }

    // This method is responsible for saving a list of ProductImage entities to the ProductImageRepository.
    // It takes a list of ProductImage entities as an argument and saves them all to the repository using the saveAll method.
    public void saveAll(List<ProductImage> images) {
        imageRepository.saveAll(images);
    }
}
