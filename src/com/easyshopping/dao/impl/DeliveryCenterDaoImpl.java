/*
 * 

 * 
 */
package com.easyshopping.dao.impl;

import javax.persistence.FlushModeType;
import javax.persistence.NoResultException;

import com.easyshopping.dao.DeliveryCenterDao;
import com.easyshopping.entity.DeliveryCenter;

import org.springframework.stereotype.Repository;
import org.springframework.util.Assert;

/**
 * Dao - 发货点
 * 
 * 
 * @version 1.0
 */
@Repository("deliveryCenterDaoImpl")
public class DeliveryCenterDaoImpl extends BaseDaoImpl<DeliveryCenter, Long> implements DeliveryCenterDao {

	public DeliveryCenter findDefault() {
		try {
			String jpql = "select deliveryCenter from DeliveryCenter deliveryCenter where deliveryCenter.isDefault = true";
			return entityManager.createQuery(jpql, DeliveryCenter.class).setFlushMode(FlushModeType.COMMIT).getSingleResult();
		} catch (NoResultException e) {
			return null;
		}
	}

	/**
	 * 处理默认并保存
	 * 
	 * @param deliveryCenter
	 *            发货点
	 */
	@Override
	public void persist(DeliveryCenter deliveryCenter) {
		Assert.notNull(deliveryCenter);
		if (deliveryCenter.getIsDefault()) {
			String jpql = "update DeliveryCenter deliveryCenter set deliveryCenter.isDefault = false where deliveryCenter.isDefault = true";
			entityManager.createQuery(jpql).setFlushMode(FlushModeType.COMMIT).executeUpdate();
		}
		super.persist(deliveryCenter);
	}

	/**
	 * 处理默认并更新
	 * 
	 * @param deliveryCenter
	 *            发货点
	 * @return 发货点
	 */
	@Override
	public DeliveryCenter merge(DeliveryCenter deliveryCenter) {
		Assert.notNull(deliveryCenter);
		if (deliveryCenter.getIsDefault()) {
			String jpql = "update DeliveryCenter deliveryCenter set deliveryCenter.isDefault = false where deliveryCenter.isDefault = true and deliveryCenter != :deliveryCenter";
			entityManager.createQuery(jpql).setFlushMode(FlushModeType.COMMIT).setParameter("deliveryCenter", deliveryCenter).executeUpdate();
		}
		return super.merge(deliveryCenter);
	}

}