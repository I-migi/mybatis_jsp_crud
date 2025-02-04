package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.entity.Product;
import com.example.demo.repository.ProductMapper;

import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
public class ProductService {
	
	private final ProductMapper productMapper;
	
	public List<Product> findAllProducts() {
		return productMapper.findAllProducts();
	}
	
	public void addProduct(String productName, Double productPrice) {
		Product newProduct = new Product(productName, productPrice);
		productMapper.addProduct(newProduct);
	}
	
	public void updateProduct(String productName, Double productPrice, Long id) {
		productMapper.updateProduct(productName, productPrice, id);
	}
	
	public void deleteProduct(Long id) {
		productMapper.deleteProduct(id);
	}
	
	
	

}
