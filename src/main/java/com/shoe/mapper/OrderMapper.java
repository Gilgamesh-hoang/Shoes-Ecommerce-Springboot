package com.shoe.mapper;

import com.shoe.dto.OrderDTO;
import com.shoe.entities.Order;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface OrderMapper {
    OrderDTO toDTO(Order order);

    Order toEntity(OrderDTO orderDTO);
}
