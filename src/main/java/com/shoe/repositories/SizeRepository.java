package com.shoe.repositories;

import com.shoe.entities.Size;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SizeRepository extends JpaRepository<Size, Integer> {
    List<Size> findAllByIsDeletedFalse();
    Size findByNameAndIsDeletedFalse(String name);
}

