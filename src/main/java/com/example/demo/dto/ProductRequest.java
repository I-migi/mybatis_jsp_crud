package com.example.demo.dto;

import com.example.demo.entity.Product;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class ProductRequest {
	
	private String productName;	
	
	private Double productPrice;

	public Product toEntity() {
		return new Product(productName, productPrice);
	}
}


