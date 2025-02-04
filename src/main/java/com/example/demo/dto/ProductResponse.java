package com.example.demo.dto;

import java.util.ArrayList;
import java.util.List;

import com.example.demo.entity.Product;
import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class ProductResponse {
	
	@JsonProperty("productName")
	private String productName;
	
	@JsonProperty("productPrice")
	private Double productPrice;
	
	public ProductResponse(Product product) {
		this.productName  = product.getName();
		this.productPrice = product.getPrice();
	}
	
	public static List<ProductResponse> fromEntityList(List<Product> products) {
		List<ProductResponse> responseList = new ArrayList<>();
		
		for (Product product : products) {
			responseList.add(new ProductResponse(product));
		}
		return responseList;
	}
	
	
}
