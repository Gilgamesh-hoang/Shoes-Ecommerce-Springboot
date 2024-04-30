package com.shoe.entities;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@Entity
@Table(name = "cart_items")
public class CartItem {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "cartId", referencedColumnName = "id")
    private Cart cart;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "productSizeId", referencedColumnName = "id")
    private ProductSize productSize;

    @Column(name = "quantity")
    private int quantity;

    public CartItem(Cart cart, ProductSize productSize, int quantity) {
        this.cart = cart;
        this.productSize = productSize;
        this.quantity = quantity;
    }

    // Getters and setters
}
