/*
 * 

 * 
 */
package com.easyshopping.dao;

import com.easyshopping.entity.Cart;

/**
 * Dao - 购物车
 * 
 * 
 * @version 1.0
 */
public interface CartDao extends BaseDao<Cart, Long> {

	/**
	 * 清除过期购物车
	 */
	void evictExpired();

}