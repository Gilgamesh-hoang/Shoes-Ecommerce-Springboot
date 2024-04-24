package com.shoe.mapper;

import com.shoe.dto.CategoryDTO;
import com.shoe.entities.Category;
import org.mapstruct.Mapper;

import java.util.List;

@Mapper(componentModel = "spring")
public interface CategoryMapper {
    CategoryDTO toDTO(Category category);
    List<CategoryDTO> toDTOs(List<Category> category);
}
