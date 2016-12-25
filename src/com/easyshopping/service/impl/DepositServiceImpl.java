/*
 * 

 * 
 */
package com.easyshopping.service.impl;

import javax.annotation.Resource;

import com.easyshopping.Page;
import com.easyshopping.Pageable;
import com.easyshopping.dao.DepositDao;
import com.easyshopping.entity.Deposit;
import com.easyshopping.entity.Member;
import com.easyshopping.service.DepositService;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service - 预存款
 * 
 * 
 * @version 1.0
 */
@Service("depositServiceImpl")
public class DepositServiceImpl extends BaseServiceImpl<Deposit, Long> implements DepositService {

	@Resource(name = "depositDaoImpl")
	private DepositDao depositDao;

	@Resource(name = "depositDaoImpl")
	public void setBaseDao(DepositDao depositDao) {
		super.setBaseDao(depositDao);
	}

	@Transactional(readOnly = true)
	public Page<Deposit> findPage(Member member, Pageable pageable) {
		return depositDao.findPage(member, pageable);
	}

}