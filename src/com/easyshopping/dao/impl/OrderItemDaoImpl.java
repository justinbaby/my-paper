/*
 * 

 * 
 */
package com.easyshopping.dao.impl;

import com.easyshopping.dao.OrderItemDao;
import com.easyshopping.entity.OrderItem;

import org.springframework.stereotype.Repository;

/**
 * Dao - 订单项
 * 
 * 
 * @version 1.0
 */
@Repository("orderItemDaoImpl")
public class OrderItemDaoImpl extends BaseDaoImpl<OrderItem, Long> implements OrderItemDao {

}