/*
 * 

 * 
 */
package com.easyshopping.service;

import com.easyshopping.entity.AdPosition;

/**
 * Service - 广告位
 * 
 * 
 * @version 1.0
 */
public interface AdPositionService extends BaseService<AdPosition, Long> {

	/**
	 * 查找广告位(缓存)
	 * 
	 * @param id
	 *            ID
	 * @param cacheRegion
	 *            缓存区域
	 * @return 广告位(缓存)
	 */
	AdPosition find(Long id, String cacheRegion);

}