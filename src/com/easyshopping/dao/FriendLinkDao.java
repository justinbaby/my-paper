/*
 * 

 * 
 */
package com.easyshopping.dao;

import java.util.List;

import com.easyshopping.entity.FriendLink;
import com.easyshopping.entity.FriendLink.Type;

/**
 * Dao - 友情链接
 * 
 * 
 * @version 1.0
 */
public interface FriendLinkDao extends BaseDao<FriendLink, Long> {

	/**
	 * 查找友情链接
	 * 
	 * @param type
	 *            类型
	 * @return 友情链接
	 */
	List<FriendLink> findList(Type type);

}