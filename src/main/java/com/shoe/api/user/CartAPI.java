package com.shoe.api.user;

import com.shoe.dto.request.CartRequest;
import com.shoe.service.CartDetailService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/cart")
public class CartAPI {
    @Autowired
    CartDetailService cartDetailService;

    @PostMapping("/items")
    // This method is responsible for adding items to the cart.
    public ResponseEntity<Void> addToCart(
            @Valid @RequestBody(required = true) CartRequest cartRequest) {

        // The addToCart method of the cartDetailService is called with the cartRequest as a parameter.
        // The result (a boolean indicating whether the item was successfully added to the cart) is stored in the isAdded variable.
        boolean isAdded = cartDetailService.addToCart(cartRequest);

        // If the item was successfully added to the cart (isAdded is true),
        if (isAdded) {
            // a ResponseEntity with a No Content status (HTTP 204) is returned.
            return ResponseEntity.noContent().build();
        } else {
            // If the item was not successfully added to the cart (isAdded is false),
            // a ResponseEntity with a Bad Request status (HTTP 400) is returned.
            return ResponseEntity.badRequest().build();
        }
    }
}
