package com.shoe.controller;

import com.shoe.dto.ProductDTO;
import com.shoe.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class HomeController {
    @Autowired
    ProductService productService;

    @GetMapping({"/", "/home"})
    public String home(Model model) {
        model.addAttribute("hotProducts", productService.getHotProducts());
        model.addAttribute("newestProducts", productService.getNewestProducts());
        return "user/home";
    }
//    @GetMapping({"/", "/home"})
//    public ModelAndView home(Model model) {
//        ModelAndView view = new ModelAndView();
//        List<ProductDTO> hotProducts =  productService.getHotProducts();
//        List<ProductDTO> a=productService.getNewestProducts();
//        view.addObject("hotProducts", productService.getHotProducts());
//        view.addObject("newestProducts", productService.getNewestProducts());
//        view.setViewName("user/home");
//        return view;
//    }
}