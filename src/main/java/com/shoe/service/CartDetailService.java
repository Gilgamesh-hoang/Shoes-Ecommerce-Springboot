package com.shoe.service;

import com.shoe.dto.CartItemDTO;
import com.shoe.dto.ProductDTO;
import com.shoe.dto.request.CartRequest;
import com.shoe.entities.Cart;
import com.shoe.entities.CartItem;
import com.shoe.entities.ProductSize;
import com.shoe.entities.User;
import com.shoe.mapper.CartItemMapper;
import com.shoe.repositories.CartItemRepository;
import com.shoe.repositories.CartRepository;
import com.shoe.repositories.ProductSizeRepository;
import com.shoe.repositories.UserRepository;
import com.shoe.util.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartDetailService {
    @Autowired
    CartItemRepository itemRepository;
    @Autowired
    UserRepository userRepository;
    @Autowired
    CartRepository cartRepository;
    @Autowired
    CartItemMapper cartItemMapper;
    @Autowired
    ProductSizeRepository productSizeRepository;

    public void clearCart() {
        // Retrieve the currently authenticated user
        User user = SecurityUtils.getUserFromPrincipal(userRepository);

        // Find the cart associated with the user
        Cart cart = cartRepository.findByUser(user);

        // If the cart doesn't exist, return
        if (cart == null) {
            return;
        }

        // Retrieve all cart items associated with the cart
        List<CartItem> items = itemRepository.findByCartId(cart.getId());

        // Delete all cart items
        itemRepository.deleteAll(items);
    }

    public boolean deleteCartItem(Integer cartItemId) {
        // Check if the cartItemId is null or less than or equal to 0. If it is, return false.
        if (cartItemId == null || cartItemId <= 0)
            return false;

        // Find the cart item by its ID. If it doesn't exist, return false.
        CartItem item = itemRepository.findById(cartItemId).orElse(null);
        if (item == null)
            return false;

        // Delete the cart item from the repository.
        itemRepository.delete(item);

        // If the code execution reaches this point, it means the cart item was successfully deleted. So, return true.
        return true;
    }

    public boolean updateCart(CartRequest cartRequest) {
        // Check if the cartRequest is null. If it is, return false.
        if (cartRequest == null)
            return false;

        // Retrieve the cartItemId and quantity from the cartRequest.
        Integer cartItemId = cartRequest.getCartItemId();
        Integer quantity = cartRequest.getQuantity();

        // Check if the cartItemId or quantity is null or less than or equal to 0. If any of them is, return false.
        if (cartItemId == null || cartItemId <= 0 || quantity == null || quantity <= 0)
            return false;

        // Find the cart item by its ID. If it doesn't exist, return false.
        CartItem item = itemRepository.findById(cartItemId).orElse(null);
        if (item == null)
            return false;

        // Set the new quantity for the cart item.
        item.setQuantity(quantity);

        // Save the updated cart item in the repository. If the saved item is not null, return true.
        item = itemRepository.save(item);
        return item != null;
    }

    public List<CartItemDTO> getAllCartItems() {
        // Retrieve the currently authenticated user
        User user = SecurityUtils.getUserFromPrincipal(userRepository);

        // Find the cart associated with the user
        Cart cart = cartRepository.findByUser(user);

        // If the cart doesn't exist, return null
        if (cart == null) {
            return null;
        }

        // Retrieve all cart items associated with the cart
        List<CartItem> items = itemRepository.findByCartId(cart.getId());

        // Convert the list of CartItem entities to CartItemDTOs and return it
        return cartItemMapper.toDTOs(items);
    }

    public boolean addToCart(CartRequest cartRequest) {
        if (cartRequest == null)
            return false;

        // Retrieve the product ID and size ID from the cart request
        Integer productId = cartRequest.getProductId();
        Integer sizeId = cartRequest.getSizeId();

        // Validate the product ID and size ID. If they are null or less than or equal to 0, return false
        if (productId == null || productId <= 0 || sizeId == null || sizeId <= 0)
            return false;

        // Find the product size by product ID and size ID. If it doesn't exist, return false
        ProductSize productSize = productSizeRepository.findByProductIdAndSizeIdAndIsDeletedFalse(productId, sizeId);
        if (productSize == null) {
            return false;
        }

        // Get the currently authenticated user
        User user = SecurityUtils.getUserFromPrincipal(userRepository);

        // Find the cart by user. If it doesn't exist, create a new one
        Cart cart = cartRepository.findByUser(user);
        if (cart == null) {
            cart = cartRepository.save(new Cart(user));
        }

        // Find the cart item by cart and product size. If it exists, return true
        CartItem item = itemRepository.findByCartAndProductSize(cart, productSize);
        if (item != null) {
            return true;
        }

        // If the cart item doesn't exist, create a new one with quantity 1
        item = new CartItem(cart, productSize, 1);

        // Save the new cart item and return true if it's not null
        item = itemRepository.save(item);
        return item != null;
    }

    // Method to calculate the total price of a list of cart items
    public double getTotalPrice(List<CartItemDTO> items) {
        // Initialize the total price to 0
        double total = 0;
        // Iterate over each item in the list
        for (CartItemDTO item : items) {
            // Retrieve the product associated with the item
            ProductDTO product = item.getProductSize().getProduct();
            // Retrieve the price of the product
            double price = product.getPrice();
            // Add the price of the item (price * (1 - discount) * quantity) to the total price
            total += price * (1 - product.getDiscount()) * item.getQuantity();
        }
        // Return the total price
        return total;
    }

    // Method to calculate the total price of all items in the cart
    public double getTotalPrice() {
        // Retrieve all items in the cart
        List<CartItemDTO> items = getAllCartItems();
        // Calculate and return the total price of these items
        return getTotalPrice(items);
    }


}
