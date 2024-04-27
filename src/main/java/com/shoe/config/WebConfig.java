package com.shoe.config;

import com.cloudinary.Cloudinary;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.HashMap;
import java.util.Map;

@Configuration
public class WebConfig {
    @Bean
    public Cloudinary getCloudinary(){
        Map<String, Object> config = new HashMap<String, Object>();
        config.put("cloud_name", "dvh2rphf4");
        config.put("api_key", "931715965692388");
        config.put("api_secret", "b0WsvdPyNTX98Djp0tM5GTQRYb4");
        config.put("secure", true);
        return new Cloudinary(config);
    }

}
