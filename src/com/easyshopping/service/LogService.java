/*
 * 

 * 
 */
package com.easyshopping.service;

import com.easyshopping.entity.Log;

/**
 * Service - 日志
 * 
 * 
 * @version 1.0
 */
public interface LogService extends BaseService<Log, Long> {

	/**
	 * 清空日志
	 */
	void clear();

}