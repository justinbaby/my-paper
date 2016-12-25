/*
 * 

 * 
 */
package com.easyshopping.service.impl;

import java.util.List;

import javax.annotation.Resource;

import com.easyshopping.Filter;
import com.easyshopping.Order;
import com.easyshopping.dao.BrandDao;
import com.easyshopping.entity.Brand;
import com.easyshopping.service.BrandService;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service - 品牌
 * 
 * 
 * @version 1.0
 */
@Service("brandServiceImpl")
public class BrandServiceImpl extends BaseServiceImpl<Brand, Long> implements BrandService {

	@Resource(name = "brandDaoImpl")
	private BrandDao brandDao;

	@Resource(name = "brandDaoImpl")
	public void setBaseDao(BrandDao brandDao) {
		super.setBaseDao(brandDao);
	}

	@Transactional(readOnly = true)
	@Cacheable("brand")
	public List<Brand> findList(Integer count, List<Filter> filters, List<Order> orders, String cacheRegion) {
		return brandDao.findList(null, count, filters, orders);
	}

	@Override
	@Transactional
	@CacheEvict(value = "brand", allEntries = true)
	public void save(Brand brand) {
		super.save(brand);
	}

	@Override
	@Transactional
	@CacheEvict(value = "brand", allEntries = true)
	public Brand update(Brand brand) {
		return super.update(brand);
	}

	@Override
	@Transactional
	@CacheEvict(value = "brand", allEntries = true)
	public Brand update(Brand brand, String... ignoreProperties) {
		return super.update(brand, ignoreProperties);
	}

	@Override
	@Transactional
	@CacheEvict(value = "brand", allEntries = true)
	public void delete(Long id) {
		super.delete(id);
	}

	@Override
	@Transactional
	@CacheEvict(value = "brand", allEntries = true)
	public void delete(Long... ids) {
		super.delete(ids);
	}

	@Override
	@Transactional
	@CacheEvict(value = "brand", allEntries = true)
	public void delete(Brand brand) {
		super.delete(brand);
	}

}