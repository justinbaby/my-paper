/*
 * 

 * 
 */
package com.easyshopping.service.impl;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import com.easyshopping.dao.GoodsDao;
import com.easyshopping.dao.ProductDao;
import com.easyshopping.entity.Goods;
import com.easyshopping.entity.Product;
import com.easyshopping.service.GoodsService;
import com.easyshopping.service.StaticService;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.Predicate;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

/**
 * Service - 货品
 * 
 * 
 * @version 1.0
 */
@Service("goodsServiceImpl")
public class GoodsServiceImpl extends BaseServiceImpl<Goods, Long> implements GoodsService {

	@Resource(name = "goodsDaoImpl")
	private GoodsDao goodsDao;
	@Resource(name = "productDaoImpl")
	private ProductDao productDao;
	@Resource(name = "staticServiceImpl")
	private StaticService staticService;

	@Resource(name = "goodsDaoImpl")
	public void setBaseDao(GoodsDao goodsDao) {
		super.setBaseDao(goodsDao);
	}

	@Override
	@Transactional
	@CacheEvict(value = { "product", "productCategory", "review", "consultation" }, allEntries = true)
	public void save(Goods goods) {
		Assert.notNull(goods);

		super.save(goods);
		goodsDao.flush();
		if (goods.getProducts() != null) {
			for (Product product : goods.getProducts()) {
				staticService.build(product);
			}
		}
	}

	@Override
	@Transactional
	@CacheEvict(value = { "product", "productCategory", "review", "consultation" }, allEntries = true)
	public Goods update(Goods goods) {
		Assert.notNull(goods);

		Set<Product> excludes = new HashSet<Product>();
		CollectionUtils.select(goods.getProducts(), new Predicate() {
			public boolean evaluate(Object object) {
				Product product = (Product) object;
				return product != null && product.getId() != null;
			}
		}, excludes);
		List<Product> products = productDao.findList(goods, excludes);
		for (Product product : products) {
			staticService.delete(product);
		}
		Goods pGoods = super.update(goods);
		goodsDao.flush();
		if (pGoods.getProducts() != null) {
			for (Product product : pGoods.getProducts()) {
				staticService.build(product);
			}
		}
		return pGoods;
	}

	@Override
	@Transactional
	@CacheEvict(value = { "product", "productCategory", "review", "consultation" }, allEntries = true)
	public Goods update(Goods goods, String... ignoreProperties) {
		return super.update(goods, ignoreProperties);
	}

	@Override
	@Transactional
	@CacheEvict(value = { "product", "productCategory", "review", "consultation" }, allEntries = true)
	public void delete(Long id) {
		super.delete(id);
	}

	@Override
	@Transactional
	@CacheEvict(value = { "product", "productCategory", "review", "consultation" }, allEntries = true)
	public void delete(Long... ids) {
		super.delete(ids);
	}

	@Override
	@Transactional
	@CacheEvict(value = { "product", "productCategory", "review", "consultation" }, allEntries = true)
	public void delete(Goods goods) {
		if (goods != null && goods.getProducts() != null) {
			for (Product product : goods.getProducts()) {
				staticService.delete(product);
			}
		}
		super.delete(goods);
	}

}