package com.shoe.repositories;

import com.shoe.entities.Cart;
import com.shoe.entities.CartItem;
import com.shoe.entities.ProductSize;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CartItemRepository extends JpaRepository<CartItem, Integer> {
    List<CartItem> findByCartId(int cartId);

    CartItem findByCartAndProductSize(Cart cartId, ProductSize productId);
}

