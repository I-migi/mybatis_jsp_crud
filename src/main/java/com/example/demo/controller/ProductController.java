package com.example.demo.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.NewsResponse;
import com.example.demo.dto.ProductRequest;
import com.example.demo.dto.ProductResponse;
import com.example.demo.service.NaverNewsCrawler;
import com.example.demo.service.ProductService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/products")
@RequiredArgsConstructor
public class ProductController {
	
	private final ProductService productService;
	
	private final NaverNewsCrawler naverNewsCrawler; 
	
	@GetMapping("/news")
	@ResponseBody
	public List<NewsResponse> getHotNews() {
		return naverNewsCrawler.getMainNews();
	}
	
	
	
	@GetMapping
	@ResponseBody
    public List<ProductResponse> getAllProducts() {
        return ProductResponse.fromEntityList(productService.findAllProducts());
    }

    @PostMapping
    public ResponseEntity<String> addProduct(@RequestBody ProductRequest productRequest) {
    	log.info("이름:{}",productRequest.getProductName());
    	
    	log.info("가격:{}",productRequest.getProductPrice().toString());
        productService.addProduct(productRequest.getProductName(), productRequest.getProductPrice());
        
        return ResponseEntity.ok("Product added succesfully");
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> updateProduct(@PathVariable Long id, @RequestBody ProductRequest productRequest) {
        productService.updateProduct(productRequest.getProductName(), productRequest.getProductPrice(), id);
        return ResponseEntity.ok("Product update succesfully");

    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteProduct(@PathVariable Long id) {
    	productService.deleteProduct(id);
        return ResponseEntity.ok("Product delete succesfully");

    }
	
	
}
