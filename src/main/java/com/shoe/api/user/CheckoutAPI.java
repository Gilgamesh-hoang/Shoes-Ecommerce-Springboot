package com.shoe.api.user;

import com.shoe.dto.OrderDTO;
import com.shoe.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/checkout")
public class CheckoutAPI {
    @Autowired
    OrderService orderService;

    @PostMapping
    public ResponseEntity<Void> checkoutHandle(@RequestBody OrderDTO orderDTO) {
        // Save the order and get the result
        OrderDTO order = orderService.saveOrder(orderDTO);
        // If the order is saved successfully, redirect to the cart page with a success message
        if (order != null) {
            return ResponseEntity.ok().build();
        }
        // If the order is not saved, redirect to the checkout page with an error message
        return ResponseEntity.badRequest().build();
    }
}
