package com.shoe.mapper;

import com.shoe.dto.CategoryDTO;
import com.shoe.dto.SizeDTO;
import com.shoe.entities.Category;
import com.shoe.entities.Size;
import org.mapstruct.Mapper;

import java.util.List;

@Mapper(componentModel = "spring")
public interface SizeMapper {
    SizeDTO toDTO(Size size);
    List<SizeDTO> toDTOs(List<Size> sizes);
}
