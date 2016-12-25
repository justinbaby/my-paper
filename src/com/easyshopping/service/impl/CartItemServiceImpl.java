/*
 * 

 * 
 */
package com.easyshopping.service.impl;

import javax.annotation.Resource;

import com.easyshopping.dao.CartItemDao;
import com.easyshopping.entity.CartItem;
import com.easyshopping.service.CartItemService;

import org.springframework.stereotype.Service;

/**
 * Service - 购物车项
 * 
 * 
 * @version 1.0
 */
@Service("cartItemServiceImpl")
public class CartItemServiceImpl extends BaseServiceImpl<CartItem, Long> implements CartItemService {

	@Resource(name = "cartItemDaoImpl")
	public void setBaseDao(CartItemDao cartItemDao) {
		super.setBaseDao(cartItemDao);
	}

}