package com.shoe.entities;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
import java.util.List;
@Data
@NoArgsConstructor
@Entity
@Table(name = "orders")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @ManyToOne
    @JoinColumn(name = "userId", referencedColumnName = "id")
    private User user;

    @Column(name = "shippingFee")
    private int shippingFee;

    @Column(name = "note")
    private String note;

    @Column(name = "address")
    private String address;

    @Column(name = "paymentMethod")
    private String paymentMethod;

    @Column(name = "createdAt", columnDefinition = "DATETIME(0) DEFAULT current_timestamp(6)")
    private Timestamp createdAt;

    @Column(name = "isDeleted", columnDefinition = "TINYINT(4) DEFAULT 0")
    private boolean isDeleted;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL)
    private List<OrderItem> orderItems;

    // Getters and setters
}
