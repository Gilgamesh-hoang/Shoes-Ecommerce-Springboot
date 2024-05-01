package com.shoe.service;

import com.shoe.dto.CartItemDTO;
import com.shoe.entities.Order;
import com.shoe.entities.OrderItem;
import com.shoe.mapper.ProductSizeMapper;
import com.shoe.repositories.OrderItemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderItemService {
    @Autowired
    CartDetailService cartDetailService;
    @Autowired
    OrderItemRepository orderItemRepository;
    @Autowired
    ProductSizeMapper productSizeMapper;

    // Method to save order items
    public void saveOrderItem(Order order) {
        // Retrieve all items in the cart
        List<CartItemDTO> items = cartDetailService.getAllCartItems();

        // Iterate over each item in the cart
        for (CartItemDTO item : items) {
            // Calculate the price of the item after applying any product discount
            double price = item.getProductSize().getProduct().getPrice() * (1 - item.getProductSize().getProduct().getDiscount());

            // Create a new order item with the quantity, product size, order, and calculated price
            OrderItem orderItem = OrderItem.builder()
                    .quantity(item.getQuantity())
                    .productSize(productSizeMapper.toEntity(item.getProductSize()))
                    .order(order)
                    .isDeleted(order.isDeleted())
                    .price(price).build();

            // Save the new order item to the database
            orderItemRepository.save(orderItem);
        }
    }

    public void updateIsDeletedOrderItem(Order order, boolean isDeleted) {
        List<OrderItem> orderItems = orderItemRepository.findAllByOrder(order);
        for (OrderItem orderItem : orderItems) {
            orderItem.setDeleted(isDeleted);
            orderItemRepository.save(orderItem);
        }
    }
}
