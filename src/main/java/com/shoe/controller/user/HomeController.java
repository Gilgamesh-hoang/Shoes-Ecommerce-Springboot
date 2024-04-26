package com.shoe.controller.user;

import com.shoe.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
    @Autowired
    ProductService productService;

    @GetMapping({"/", "/home"})
    public String home(Model model) {
        model.addAttribute("hotProducts", productService.getHotProducts());

        //paging with 6 products per page
        Pageable pageRequest = PageRequest.of(0, 6, Sort.unsorted());
        model.addAttribute("newestProducts", productService.getNewestProducts(pageRequest));
        return "user/home";
    }
}