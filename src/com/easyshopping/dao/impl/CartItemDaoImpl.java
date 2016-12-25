/*
 * 

 * 
 */
package com.easyshopping.dao.impl;

import com.easyshopping.dao.CartItemDao;
import com.easyshopping.entity.CartItem;

import org.springframework.stereotype.Repository;

/**
 * Dao - 购物车项
 * 
 * 
 * @version 1.0
 */
@Repository("cartItemDaoImpl")
public class CartItemDaoImpl extends BaseDaoImpl<CartItem, Long> implements CartItemDao {

}