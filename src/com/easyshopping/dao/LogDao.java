/*
 * 

 * 
 */
package com.easyshopping.dao;

import com.easyshopping.entity.Log;

/**
 * Dao - 日志
 * 
 * 
 * @version 1.0
 */
public interface LogDao extends BaseDao<Log, Long> {

	/**
	 * 删除所有日志
	 */
	void removeAll();

}