package com.shoe.service;

import com.cloudinary.Cloudinary;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Map;

@Service
public class CloudinaryService {
    @Autowired
    private Cloudinary cloudinary;

    /**
     * This method is responsible for uploading a file to Cloudinary.
     * It takes a MultipartFile as an argument, which represents the file to be uploaded.
     * The method attempts to upload the file by calling the upload method of the Cloudinary uploader.
     * If the upload is successful, a Map containing the upload result is returned.
     * If an IOException occurs during the upload, a RuntimeException is thrown with a message indicating that the upload failed.
     *
     * @param file The MultipartFile to be uploaded.
     * @return A Map containing the result of the upload.
     * @throws RuntimeException if an IOException occurs during the upload.
     */
    public Map<String, Object> upload(MultipartFile file) {
        try {
            // Attempt to upload the file to Cloudinary.
            // The file's bytes are passed to the upload method along with an empty configuration Map.
            return cloudinary.uploader().upload(file.getBytes(), Map.of());
        } catch (IOException io) {
            // If an IOException occurs, throw a RuntimeException indicating that the upload failed.
            throw new RuntimeException("Image upload fail");
        }
    }
}
