package com.shoe.mapper;

import com.shoe.dto.CartItemDTO;
import com.shoe.dto.CategoryDTO;
import com.shoe.entities.CartItem;
import com.shoe.entities.Category;
import org.mapstruct.Mapper;

import java.util.List;

@Mapper(componentModel = "spring")
public interface CartItemMapper {
    CartItemDTO toDTO(CartItem cartItem);
    List<CartItemDTO> toDTOs(List<CartItem> items);
}
