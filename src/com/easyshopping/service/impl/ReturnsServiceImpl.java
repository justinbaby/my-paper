/*
 * 

 * 
 */
package com.easyshopping.service.impl;

import javax.annotation.Resource;

import com.easyshopping.dao.ReturnsDao;
import com.easyshopping.entity.Returns;
import com.easyshopping.service.ReturnsService;

import org.springframework.stereotype.Service;

/**
 * Service - 退货单
 * 
 * 
 * @version 1.0
 */
@Service("returnsServiceImpl")
public class ReturnsServiceImpl extends BaseServiceImpl<Returns, Long> implements ReturnsService {

	@Resource(name = "returnsDaoImpl")
	public void setBaseDao(ReturnsDao returnsDao) {
		super.setBaseDao(returnsDao);
	}

}