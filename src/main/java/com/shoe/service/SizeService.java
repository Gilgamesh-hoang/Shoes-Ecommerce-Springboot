package com.shoe.service;

import com.shoe.dto.SizeDTO;
import com.shoe.mapper.SizeMapper;
import com.shoe.repositories.SizeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SizeService {
    @Autowired
    SizeRepository sizeRepository;
    @Autowired
    SizeMapper sizeMapper;

    public List<SizeDTO> getAllSizes() {
        return sizeMapper.toDTOs(sizeRepository.findAll());
    }
}
