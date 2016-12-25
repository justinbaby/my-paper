/*
 * 

 * 
 */
package com.easyshopping.dao.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.persistence.FlushModeType;

import com.easyshopping.dao.GoodsDao;
import com.easyshopping.dao.ProductDao;
import com.easyshopping.dao.SnDao;
import com.easyshopping.entity.Goods;
import com.easyshopping.entity.Product;
import com.easyshopping.entity.Sn.Type;
import com.easyshopping.entity.SpecificationValue;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.builder.CompareToBuilder;
import org.springframework.stereotype.Repository;
import org.springframework.util.Assert;

/**
 * Dao - 货品
 * 
 * 
 * @version 1.0
 */
@Repository("goodsDaoImpl")
public class GoodsDaoImpl extends BaseDaoImpl<Goods, Long> implements GoodsDao {

	@Resource(name = "productDaoImpl")
	private ProductDao productDao;
	@Resource(name = "snDaoImpl")
	private SnDao snDao;

	/**
	 * 设置值并保存
	 * 
	 * @param goods
	 *            货品
	 */
	@Override
	public void persist(Goods goods) {
		Assert.notNull(goods);

		if (goods.getProducts() != null) {
			for (Product product : goods.getProducts()) {
				setValue(product);
			}
		}
		super.persist(goods);
	}

	/**
	 * 设置值并更新
	 * 
	 * @param goods
	 *            货品
	 * @return 货品
	 */
	@Override
	public Goods merge(Goods goods) {
		Assert.notNull(goods);

		if (goods.getProducts() != null) {
			for (Product product : goods.getProducts()) {
				if (product.getId() != null) {
					if (!product.getIsGift()) {
						String jpql = "delete from GiftItem giftItem where giftItem.gift = :product";
						entityManager.createQuery(jpql).setFlushMode(FlushModeType.COMMIT).setParameter("product", product).executeUpdate();
					}
					if (!product.getIsMarketable() || product.getIsGift()) {
						String jpql = "delete from CartItem cartItem where cartItem.product = :product";
						entityManager.createQuery(jpql).setFlushMode(FlushModeType.COMMIT).setParameter("product", product).executeUpdate();
					}
				}
				setValue(product);
			}
		}
		return super.merge(goods);
	}

	/**
	 * 设置值
	 * 
	 * @param product
	 *            商品
	 */
	private void setValue(Product product) {
		if (product == null) {
			return;
		}
		if (StringUtils.isEmpty(product.getSn())) {
			String sn;
			do {
				sn = snDao.generate(Type.product);
			} while (productDao.snExists(sn));
			product.setSn(sn);
		}
		StringBuffer fullName = new StringBuffer(product.getName());
		if (product.getSpecificationValues() != null && !product.getSpecificationValues().isEmpty()) {
			List<SpecificationValue> specificationValues = new ArrayList<SpecificationValue>(product.getSpecificationValues());
			Collections.sort(specificationValues, new Comparator<SpecificationValue>() {
				public int compare(SpecificationValue a1, SpecificationValue a2) {
					return new CompareToBuilder().append(a1.getSpecification(), a2.getSpecification()).toComparison();
				}
			});
			fullName.append(Product.FULL_NAME_SPECIFICATION_PREFIX);
			int i = 0;
			for (Iterator<SpecificationValue> iterator = specificationValues.iterator(); iterator.hasNext(); i++) {
				if (i != 0) {
					fullName.append(Product.FULL_NAME_SPECIFICATION_SEPARATOR);
				}
				fullName.append(iterator.next().getName());
			}
			fullName.append(Product.FULL_NAME_SPECIFICATION_SUFFIX);
		}
		product.setFullName(fullName.toString());
	}

}