package com.shoe.mapper;

import com.shoe.dto.UserDTO;
import com.shoe.entities.User;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface UserMapper {
    UserDTO toDTO(User user);
    User toEntity(UserDTO userDTO);
}
