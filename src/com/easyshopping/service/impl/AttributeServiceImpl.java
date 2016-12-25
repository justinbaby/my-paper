/*
 * 

 * 
 */
package com.easyshopping.service.impl;

import javax.annotation.Resource;

import com.easyshopping.dao.AttributeDao;
import com.easyshopping.entity.Attribute;
import com.easyshopping.service.AttributeService;

import org.springframework.stereotype.Service;

/**
 * Service - 属性
 * 
 * 
 * @version 1.0
 */
@Service("attributeServiceImpl")
public class AttributeServiceImpl extends BaseServiceImpl<Attribute, Long> implements AttributeService {

	@Resource(name = "attributeDaoImpl")
	public void setBaseDao(AttributeDao attributeDao) {
		super.setBaseDao(attributeDao);
	}

}