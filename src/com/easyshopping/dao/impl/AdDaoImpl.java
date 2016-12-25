/*
 * 

 * 
 */
package com.easyshopping.dao.impl;

import com.easyshopping.dao.AdDao;
import com.easyshopping.entity.Ad;

import org.springframework.stereotype.Repository;

/**
 * Dao - 广告
 * 
 * 
 * @version 1.0
 */
@Repository("adDaoImpl")
public class AdDaoImpl extends BaseDaoImpl<Ad, Long> implements AdDao {

}