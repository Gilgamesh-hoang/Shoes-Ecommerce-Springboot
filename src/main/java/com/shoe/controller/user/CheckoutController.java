package com.shoe.controller.user;

import com.shoe.dto.CartItemDTO;
import com.shoe.service.CartDetailService;
import com.shoe.service.OrderService;
import com.shoe.util.TripleDESEncoder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Objects;

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

    @GetMapping("/vnpay")
    public String handleCheckoutVNPAY(@RequestParam("id") String encryptId) {
        // Check if the encrypted order ID is not null
        if (encryptId != null) {
            // Decrypt the encrypted order ID and parse it to an integer
            int orderId = Integer.parseInt(Objects.requireNonNull(TripleDESEncoder.decrypt(encryptId)));
            // Update the status of the order to not deleted (meaning the order has been paid)
            boolean isUpdated = orderService.updateIsDeletedFalse(orderId);
            // If the order status was successfully updated, redirect to the cart page with a success message
            if (isUpdated) {
                return "redirect:/cart?checkoutSuccess=true";
            }
        }
        // If the order ID is null or the order status was not successfully updated, redirect to the checkout page with an error message
        return "redirect:/checkout?error=true";
    }
}
