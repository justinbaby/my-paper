/*
 * 

 * 
 */
package com.easyshopping.dao.impl;

import javax.persistence.FlushModeType;
import javax.persistence.NoResultException;

import com.easyshopping.dao.SeoDao;
import com.easyshopping.entity.Seo;
import com.easyshopping.entity.Seo.Type;

import org.springframework.stereotype.Repository;

/**
 * Dao - SEO设置
 * 
 * 
 * @version 1.0
 */
@Repository("seoDaoImpl")
public class SeoDaoImpl extends BaseDaoImpl<Seo, Long> implements SeoDao {

	public Seo find(Type type) {
		if (type == null) {
			return null;
		}
		try {
			String jpql = "select seo from Seo seo where seo.type = :type";
			return entityManager.createQuery(jpql, Seo.class).setFlushMode(FlushModeType.COMMIT).setParameter("type", type).getSingleResult();
		} catch (NoResultException e) {
			return null;
		}
	}

}