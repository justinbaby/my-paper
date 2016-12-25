/*
 * 

 * 
 */
package com.easyshopping.service;

import java.util.List;

import com.easyshopping.entity.Area;

/**
 * Service - 地区
 * 
 * 
 * @version 1.0
 */
public interface AreaService extends BaseService<Area, Long> {

	/**
	 * 查找顶级地区
	 * 
	 * @return 顶级地区
	 */
	List<Area> findRoots();

	/**
	 * 查找顶级地区
	 * 
	 * @param count
	 *            数量
	 * @return 顶级地区
	 */
	List<Area> findRoots(Integer count);

}