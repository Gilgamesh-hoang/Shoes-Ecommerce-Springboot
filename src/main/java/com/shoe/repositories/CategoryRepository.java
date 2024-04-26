package com.shoe.repositories;

import com.shoe.entities.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Integer> {
    List<Category> findAllByIsDeletedIsFalse();

    Category findByIdAndIsDeletedIsFalse(int id);

    Category findByCode(String code);

    Category findByNameAndCodeAndIsDeletedIsFalse(String name, String code);
}

