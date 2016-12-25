/*
 * 

 * 
 */
package com.easyshopping.dao;

import com.easyshopping.entity.Seo;
import com.easyshopping.entity.Seo.Type;

/**
 * Dao - SEO设置
 * 
 * 
 * @version 1.0
 */
public interface SeoDao extends BaseDao<Seo, Long> {

	/**
	 * 查找SEO设置
	 * 
	 * @param type
	 *            类型
	 * @return SEO设置
	 */
	Seo find(Type type);

}