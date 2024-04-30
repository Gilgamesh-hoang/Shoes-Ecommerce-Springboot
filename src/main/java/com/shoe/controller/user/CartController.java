package com.shoe.controller.user;

import com.shoe.dto.CartItemDTO;
import com.shoe.service.CartDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/cart")
public class CartController {
    @Autowired
    CartDetailService cartDetailService;

    @GetMapping
    public String cartPage(Model model, @RequestParam(value = "checkoutSuccess", required = false) String checkoutSuccess) {
        // Retrieve all cart items
        List<CartItemDTO> items = cartDetailService.getAllCartItems();

        // If the cart is empty or null, return the view for an empty cart
        if (items == null || items.isEmpty()) {
            model.addAttribute("checkoutSuccess", checkoutSuccess);
            return "user/cart-empty";
        } else {
            // If the cart is not empty, calculate the total price of the items in the cart
            model.addAttribute("totalPrice", cartDetailService.getTotalPrice(items));

            // Add the list of cart items to the model
            model.addAttribute("items", items);
        }

        // Return the view for the cart page
        return "user/cart";
    }
}
