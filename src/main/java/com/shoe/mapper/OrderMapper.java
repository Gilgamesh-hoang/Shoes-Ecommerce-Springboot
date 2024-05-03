package com.shoe.mapper;

import com.shoe.dto.OrderDTO;
import com.shoe.entities.Order;
import org.mapstruct.Mapper;

import java.util.List;

@Mapper(componentModel = "spring")
public interface OrderMapper {
    OrderDTO toDTO(Order order);
    List<OrderDTO> toDTOs(List<Order> orders);

    Order toEntity(OrderDTO orderDTO);
}
