package com.shoe.repositories;

import com.shoe.entities.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, Integer> {
    List<Order> findAllByIsDeletedFalse();
    Order findByIdAndIsDeletedFalse(Integer id);
}

