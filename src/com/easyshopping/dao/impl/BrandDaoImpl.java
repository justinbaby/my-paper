/*
 * 

 * 
 */
package com.easyshopping.dao.impl;

import com.easyshopping.dao.BrandDao;
import com.easyshopping.entity.Brand;

import org.springframework.stereotype.Repository;

/**
 * Dao - 品牌
 * 
 * 
 * @version 1.0
 */
@Repository("brandDaoImpl")
public class BrandDaoImpl extends BaseDaoImpl<Brand, Long> implements BrandDao {

}