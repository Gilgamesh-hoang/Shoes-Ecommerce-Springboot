package com.shoe.controller.user;

import com.shoe.dto.CartItemDTO;
import com.shoe.service.CartDetailService;
import com.shoe.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/checkout")
public class CheckoutController {
    @Autowired
    CartDetailService cartDetailService;
    @Autowired
    OrderService orderService;


    @GetMapping
    public String checkoutPage(Model model, @RequestParam(value = "error", required = false) String error) {
        // Fetch all items in the cart
        List<CartItemDTO> items = cartDetailService.getAllCartItems();

        // If the cart is empty, redirect to the cart-empty page
        if (items == null || items.isEmpty()) {
            return "user/cart-empty";
        } else {
            // If the cart is not empty, add the total price, items, user information and any error message to the model
            model.addAttribute("totalPrice", cartDetailService.getTotalPrice(items));
            model.addAttribute("items", items);
            model.addAttribute("order", orderService.getUserInfor());
            model.addAttribute("error", error);
        }
        // Return the checkout page view
        return "user/checkout";
    }


}
