/*
 * 

 * 
 */
package com.easyshopping.service;

import com.easyshopping.entity.Seo;
import com.easyshopping.entity.Seo.Type;

/**
 * Service - SEO设置
 * 
 * 
 * @version 1.0
 */
public interface SeoService extends BaseService<Seo, Long> {

	/**
	 * 查找SEO设置
	 * 
	 * @param type
	 *            类型
	 * @return SEO设置
	 */
	Seo find(Type type);

	/**
	 * 查找SEO设置(缓存)
	 * 
	 * @param type
	 *            类型
	 * @param cacheRegion
	 *            缓存区域
	 * @return SEO设置(缓存)
	 */
	Seo find(Type type, String cacheRegion);

}