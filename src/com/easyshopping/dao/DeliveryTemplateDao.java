/*
 * 

 * 
 */
package com.easyshopping.dao;

import com.easyshopping.entity.DeliveryTemplate;

/**
 * Dao - 快递单模板
 * 
 * 
 * @version 1.0
 */
public interface DeliveryTemplateDao extends BaseDao<DeliveryTemplate, Long> {

	/**
	 * 查找默认快递单模板
	 * 
	 * @return 默认快递单模板，若不存在则返回null
	 */
	DeliveryTemplate findDefault();

}