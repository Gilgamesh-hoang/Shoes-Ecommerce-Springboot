package com.shoe.dto;

import com.shoe.entities.OrderItem;
import com.shoe.entities.User;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class OrderDTO {
    private int id;
    private String note;
    private String address;
    private String fullName;
    private String email;
    private String phoneNumber;
    private String paymentMethod;
    private Timestamp createdAt;
    private double total;
    private List<OrderItemDTO> orderItems;
}
