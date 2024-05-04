package com.shoe.entities;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.sql.Timestamp;
import java.util.List;
@Data
@NoArgsConstructor
@EntityListeners(AuditingEntityListener.class)
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

    @Column(name = "phoneNumber")
    private String phoneNumber;

    @Column(name = "fullName")
    private String fullName;

    @Column(name = "email")
    private String email;

    @Column(name = "shippingFee")
    private int shippingFee;

    @Column(name = "note")
    private String note;

    @Column(name = "address")
    private String address;

    @Column(name = "paymentMethod")
    private String paymentMethod;

    @Column(name = "createdAt")
    @Temporal(TemporalType.TIMESTAMP)
    @CreatedDate
    private Timestamp createdAt;

    @Column(name = "isDeleted", columnDefinition = "TINYINT(4) DEFAULT 0")
    private boolean isDeleted;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL)
    private List<OrderItem> orderItems;

    // Getters and setters
}
