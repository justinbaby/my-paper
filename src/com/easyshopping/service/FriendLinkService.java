/*
 * 

 * 
 */
package com.easyshopping.service;

import java.util.List;

import com.easyshopping.Filter;
import com.easyshopping.Order;
import com.easyshopping.entity.FriendLink;
import com.easyshopping.entity.FriendLink.Type;

/**
 * Service - 友情链接
 * 
 * 
 * @version 1.0
 */
public interface FriendLinkService extends BaseService<FriendLink, Long> {

	/**
	 * 查找友情链接
	 * 
	 * @param type
	 *            类型
	 * @return 友情链接
	 */
	List<FriendLink> findList(Type type);

	/**
	 * 查找友情链接(缓存)
	 * 
	 * @param count
	 *            数量
	 * @param filters
	 *            筛选
	 * @param orders
	 *            排序
	 * @param cacheRegion
	 *            缓存区域
	 * @return 友情链接(缓存)
	 */
	List<FriendLink> findList(Integer count, List<Filter> filters, List<Order> orders, String cacheRegion);

}