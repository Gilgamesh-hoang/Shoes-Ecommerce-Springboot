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

    public double getTotalPrice(List<CartItemDTO> items) {
        double total = 0;
        for (CartItemDTO item : items) {
            ProductDTO product = item.getProductSize().getProduct();
            double price = product.getPrice();
            total += price * (1 - product.getDiscount()) * item.getQuantity();
        }
        return total;
    }
}
