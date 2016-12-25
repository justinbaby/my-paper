/*
 * 

 * 
 */
package com.easyshopping.dao.impl;

import javax.persistence.FlushModeType;

import com.easyshopping.dao.LogDao;
import com.easyshopping.entity.Log;

import org.springframework.stereotype.Repository;

/**
 * Dao - 日志
 * 
 * 
 * @version 1.0
 */
@Repository("logDaoImpl")
public class LogDaoImpl extends BaseDaoImpl<Log, Long> implements LogDao {

	public void removeAll() {
		String jpql = "delete from Log log";
		entityManager.createQuery(jpql).setFlushMode(FlushModeType.COMMIT).executeUpdate();
	}

}