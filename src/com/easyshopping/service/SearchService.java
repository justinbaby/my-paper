/*
 * 

 * 
 */
package com.easyshopping.service;

import java.math.BigDecimal;

import com.easyshopping.Page;
import com.easyshopping.Pageable;
import com.easyshopping.entity.Article;
import com.easyshopping.entity.Product;
import com.easyshopping.entity.Product.OrderType;

/**
 * Service - 搜索
 * 
 * 
 * @version 1.0
 */
public interface SearchService {

	/**
	 * 创建索引
	 */
	void index();

	/**
	 * 创建索引
	 * 
	 * @param type
	 *            索引类型
	 */
	void index(Class<?> type);

	/**
	 * 创建索引
	 * 
	 * @param article
	 *            文章
	 */
	void index(Article article);

	/**
	 * 创建索引
	 * 
	 * @param product
	 *            商品
	 */
	void index(Product product);

	/**
	 * 删除索引
	 */
	void purge();

	/**
	 * 删除索引
	 * 
	 * @param type
	 *            索引类型
	 */
	void purge(Class<?> type);

	/**
	 * 删除索引
	 * 
	 * @param article
	 *            文章
	 */
	void purge(Article article);

	/**
	 * 删除索引
	 * 
	 * @param product
	 *            商品
	 */
	void purge(Product product);

	/**
	 * 搜索文章分页
	 * 
	 * @param keyword
	 *            关键词
	 * @param pageable
	 *            分页信息
	 * @return 文章分页
	 */
	Page<Article> search(String keyword, Pageable pageable);

	/**
	 * 搜索商品分页
	 * 
	 * @param keyword
	 *            关键词
	 * @param startPrice
	 *            最低价格
	 * @param endPrice
	 *            最高价格
	 * @param orderType
	 *            排序类型
	 * @param pageable
	 *            分页信息
	 * @return 商品分页
	 */
	Page<Product> search(String keyword, BigDecimal startPrice, BigDecimal endPrice, OrderType orderType, Pageable pageable);

}