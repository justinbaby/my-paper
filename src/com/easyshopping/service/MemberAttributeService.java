/*
 * 

 * 
 */
package com.easyshopping.service;

import java.util.List;

import com.easyshopping.entity.MemberAttribute;

/**
 * Service - 会员注册项
 * 
 * 
 * @version 1.0
 */
public interface MemberAttributeService extends BaseService<MemberAttribute, Long> {

	/**
	 * 查找未使用的对象属性序号
	 * 
	 * @return 未使用的对象属性序号，若无可用序号则返回null
	 */
	Integer findUnusedPropertyIndex();

	/**
	 * 查找会员注册项
	 * 
	 * @return 会员注册项，仅包含已启用会员注册项
	 */
	List<MemberAttribute> findList();

	/**
	 * 查找会员注册项(缓存)
	 * 
	 * @param cacheRegion
	 *            缓存区域
	 * @return 会员注册项(缓存)，仅包含已启用会员注册项
	 */
	List<MemberAttribute> findList(String cacheRegion);

}