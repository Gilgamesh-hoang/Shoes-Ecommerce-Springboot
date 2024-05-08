
package com.shoe.vnpay;

import com.shoe.service.OrderService;
import com.shoe.util.TripleDESEncoder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Objects;

@Controller
@RequestMapping("/checkout/vnpay")
public class VNPAYController {
    @Autowired
    OrderService orderService;

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