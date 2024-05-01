package com.shoe.service;

import com.shoe.dto.OrderDTO;
import com.shoe.entities.Order;
import com.shoe.entities.User;
import com.shoe.mapper.OrderMapper;
import com.shoe.repositories.OrderRepository;
import com.shoe.repositories.UserRepository;
import com.shoe.util.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;

@Service
public class OrderService {
    @Autowired
    UserRepository userRepository;
    @Autowired
    OrderMapper orderMapper;
    @Autowired
    OrderRepository orderRepository;
    @Autowired
    OrderItemService orderItemService;
    @Autowired
    CartDetailService cartDetailService;

    // Method to get user information
    public OrderDTO getUserInfor() {
        // Retrieve the currently authenticated user
        User user = SecurityUtils.getUserFromPrincipal(userRepository);
        // If the user is not authenticated, return null
        if (user == null) {
            return null;
        }
        // Build and return an OrderDTO object with the user's full name, email, and phone number
        return OrderDTO.builder()
                .fullName(user.getFullName())
                .email(user.getEmail())
                .phoneNumber(user.getPhoneNumber())
                .build();
    }

    // Method to save an order
    public OrderDTO saveOrder(OrderDTO orderDTO) {
        // Retrieve the currently authenticated user
        User user = SecurityUtils.getUserFromPrincipal(userRepository);
        // If the user is not authenticated, return false
        if (user == null) {
            return null;
        }
        // Convert the OrderDTO object to an Order entity
        Order order = orderMapper.toEntity(orderDTO);
        // Set the user, shipping fee, and creation time of the order
        order.setUser(user);
        order.setShippingFee(0);
        order.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        // Save the order to the database
        order = orderRepository.save(order);
        // If the order is not saved successfully, return false
        if (order == null) {
            return null;
        }
        // Save the order items associated with the order
        orderItemService.saveOrderItem(order);
        // Clear the user's cart
        cartDetailService.clearCart();
        // If the code execution reaches this point, it means the order was successfully saved. So, return true.
        return orderMapper.toDTO(order);
    }

    // Method to save an order without payment
    public OrderDTO saveOrderNotPayment(OrderDTO orderDTO) {
        // Retrieve the currently authenticated user
        User user = SecurityUtils.getUserFromPrincipal(userRepository);
        // If the user is not authenticated, return null
        if (user == null) {
            return null;
        }
        // Convert the OrderDTO object to an Order entity
        Order order = orderMapper.toEntity(orderDTO);
        // Set the user, shipping fee, and creation time of the order
        order.setUser(user);
        order.setShippingFee(0);
        order.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        // Mark the order as deleted (not paid)
        order.setDeleted(true);
        // Save the order to the database
        order = orderRepository.save(order);
        // If the order is not saved successfully, return null
        if (order == null) {
            return null;
        }
        // Save the order items associated with the order
        orderItemService.saveOrderItem(order);
        // Convert the saved Order entity back to an OrderDTO and return it
        return orderMapper.toDTO(order);
    }


    public boolean updateIsDeletedFalse(int orderId) {
        // Retrieve the order by its ID
        Order order = orderRepository.findById(orderId).orElse(null);
        // If the order does not exist, return false
        if (order == null) {
            return false;
        }
        // Mark the order as not deleted (paid)
        order.setDeleted(false);
        // Save the updated order to the database
        order = orderRepository.save(order);
        // Update the status of the order items associated with the order
        orderItemService.updateIsDeletedOrderItem(order, false);
        // Clear the user's cart
        cartDetailService.clearCart();
        // If the code execution reaches this point, it means the order status was successfully updated. So, return true.
        return true;
    }
}
