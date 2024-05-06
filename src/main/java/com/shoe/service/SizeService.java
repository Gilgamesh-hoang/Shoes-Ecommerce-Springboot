package com.shoe.service;

import com.shoe.dto.SizeDTO;
import com.shoe.entities.Size;
import com.shoe.mapper.SizeMapper;
import com.shoe.repositories.ProductSizeRepository;
import com.shoe.repositories.SizeRepository;
import org.owasp.encoder.Encode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SizeService {
    @Autowired
    SizeRepository sizeRepository;
    @Autowired
    SizeMapper sizeMapper;
    @Autowired
    ProductSizeRepository productSizeRepository;

    // This method retrieves all sizes that are not marked as deleted
    public List<SizeDTO> getAllSizes() {
        // Convert the list of Size entities to a list of SizeDTOs and return it
        return sizeMapper.toDTOs(sizeRepository.findAllByIsDeletedFalse());
    }

    // This method adds a new size
    public void addSize(String name) {
        // Check if a size with the same name already exists and is not marked as deleted
        if (sizeRepository.findByNameAndIsDeletedFalse(name) == null) {
            // If not, save a new Size entity with the provided name
            name = Encode.forHtml(name);
            sizeRepository.save(new Size(name));
        }
    }

    // This method updates the name of an existing size
    public void updateSize(int id, String name) {
        // Find the Size entity with the provided ID
        Size size = sizeRepository.findById(id).orElse(null);
        // If the Size entity exists, update its name and save it
        if (size != null) {
            name = Encode.forHtml(name);
            size.setName(name);
            sizeRepository.save(size);
        }
    }

    // This method marks sizes as deleted
    public void deleteSizes(String[] ids) {
        // Iterate over the provided IDs
        for (String id : ids) {
            // Find the Size entity with the current ID
            Size size = sizeRepository.findById(Integer.parseInt(id)).orElse(null);
            // If the Size entity exists, mark it as deleted and save it
            if (size != null) {
                size.setDeleted(true);
                sizeRepository.save(size);

                // Also mark as deleted all ProductSize entities associated with the current size
                productSizeRepository.findBySizeIdAndIsDeletedFalse(Integer.parseInt(id)).forEach(productSize -> {
                    productSize.setDeleted(true);
                    productSizeRepository.save(productSize);
                });
            }
        }
    }
}
