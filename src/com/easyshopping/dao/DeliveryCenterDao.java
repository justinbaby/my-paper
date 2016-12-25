/*
 * 

 * 
 */
package com.easyshopping.dao;

import com.easyshopping.entity.DeliveryCenter;

/**
 * Dao - 发货点
 * 
 * 
 * @version 1.0
 */
public interface DeliveryCenterDao extends BaseDao<DeliveryCenter, Long> {

	/**
	 * 查找默认发货点
	 * 
	 * @return 默认发货点，若不存在则返回null
	 */
	DeliveryCenter findDefault();

}