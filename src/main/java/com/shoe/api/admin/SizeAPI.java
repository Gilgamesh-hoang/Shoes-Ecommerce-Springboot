package com.shoe.api.admin;

import com.shoe.dto.CategoryDTO;
import com.shoe.service.CategoryService;
import com.shoe.service.SizeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/admin/sizes")
public class SizeAPI {
    @Autowired
    SizeService sizeService;

    // This method is mapped to the HTTP DELETE method and the URL "/api/v1/sizes"
    @DeleteMapping
    public ResponseEntity<String> deleteCategory(@RequestBody String[] ids) {
        // Call the deleteSizes method of the sizeService with the provided IDs
        sizeService.deleteSizes(ids);
        // Return a response entity with a success message
        return ResponseEntity.ok("Size deleted successfully");
    }
}
