package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.entity.Product;

@Mapper
public interface ProductMapper {
	
	@Select("SELECT * FROM products")
	List<Product> findAllProducts();
	
	@Insert("INSERT INTO products (name, price) VALUES(#{name}, #{price})")
	@Options(useGeneratedKeys = true, keyProperty = "id")
	void addProduct(Product product);
	
	@Update("UPDATE products SET name = #{name}, price = #{price} WHERE id = #{id}")
	void updateProduct(@Param("name") String name, @Param("price") Double price, @Param("id") Long id);
	
	@Delete("DELETE FROM products WHERE id = #{id}")
	void deleteProduct(@Param("id") Long id);
	

}
