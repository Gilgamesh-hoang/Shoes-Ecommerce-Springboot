package com.shoe;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
//@ComponentScan({"com.shoe.controller", "com.shoe."})
public class ShoeProjectApplication {

    public static void main(String[] args) {
        SpringApplication.run(ShoeProjectApplication.class, args);
    }

}
//@SpringBootApplication(scanBasePackages = "com.shoe")
//public class ShoeProjectApplication extends SpringBootServletInitializer {
//
//    @Override
//    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
//        return builder.sources(ShoeProjectApplication.class);
//    }
//
//    public static void main(String[] args) {
//        SpringApplication.run(ShoeProjectApplication.class, args);
//    }
//
//}
