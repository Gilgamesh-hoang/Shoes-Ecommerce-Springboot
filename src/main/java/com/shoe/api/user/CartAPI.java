package com.shoe.api.user;

import com.shoe.dto.request.CartRequest;
import com.shoe.service.CartDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/cart/items")
public class CartAPI {
    @Autowired
    CartDetailService cartDetailService;

    // This method is responsible for updating the cart.
    @PutMapping
    public ResponseEntity<Void> updateCart(@RequestBody(required = true) CartRequest cartRequest) {
        // The result (a boolean indicating whether the cart was successfully updated) is stored in the isUpdated variable.
        boolean isUpdated = cartDetailService.updateCart(cartRequest);

        // If the cart was successfully updated (isUpdated is true),
        if (isUpdated) {
            // a ResponseEntity with a No Content status (HTTP 204) is returned.
            return ResponseEntity.noContent().build();
        } else {
            // If the cart was not successfully updated (isUpdated is false),
            // a ResponseEntity with a Bad Request status (HTTP 400) is returned.
            return ResponseEntity.badRequest().build();
        }
    }

    // This method is responsible for deleting a cart item.
    @DeleteMapping
    public ResponseEntity<Void> deleteCartItem(@RequestBody(required = true) Integer cartItemId) {
        // The result (a boolean indicating whether the cart item was successfully deleted) is stored in the isDeleted variable.
        boolean isDeleted = cartDetailService.deleteCartItem(cartItemId);

        // If the cart item was successfully deleted (isDeleted is true),
        if (isDeleted) {
            // a ResponseEntity with a No Content status (HTTP 204) is returned.
            return ResponseEntity.noContent().build();
        } else {
            // If the cart item was not successfully deleted (isDeleted is false),
            // a ResponseEntity with a Bad Request status (HTTP 400) is returned.
            return ResponseEntity.badRequest().build();
        }
    }

    @PostMapping
    // This method is responsible for adding items to the cart.
    public ResponseEntity<Void> addToCart(@RequestBody(required = true) CartRequest cartRequest) {

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
