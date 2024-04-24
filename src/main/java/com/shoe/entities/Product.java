package com.shoe.entities;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
import java.util.List;

@Data
@NoArgsConstructor
@Entity
@Table(name = "products")
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "name")
    private String name;

    @Column(name = "description", length = 1000)
    private String description;

    @Column(name = "thumbnail")
    private String thumbnail;

    @Column(name = "shortDescription")
    private String shortDescription;

    @Column(name = "price")
    private double price;

    @Column(name = "discount", columnDefinition = "FLOAT(2,1) DEFAULT 0")
    private float discount;

    @Column(name = "isHot", columnDefinition = "TINYINT(4) DEFAULT 0")
    private boolean isHot;

    @ManyToOne
    @JoinColumn(name = "categoryId", referencedColumnName = "id")
    private Category category;

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL)
    private List<ProductImage> images;

    @Column(name = "createdAt", columnDefinition = "DATETIME(0) DEFAULT current_timestamp(6)")
    private Timestamp createdAt;

    @Column(name = "isDeleted", columnDefinition = "TINYINT(4) DEFAULT 0")
    private boolean isDeleted;

    // Getters and setters
}