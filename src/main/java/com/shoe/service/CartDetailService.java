package com.shoe.service;

import com.shoe.repositories.CartItemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CartDetailService {
    @Autowired
    CartItemRepository itemRepository;

}
