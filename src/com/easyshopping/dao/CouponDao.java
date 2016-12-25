/*
 * 

 * 
 */
package com.easyshopping.dao;

import com.easyshopping.Page;
import com.easyshopping.Pageable;
import com.easyshopping.entity.Coupon;

/**
 * Dao - 优惠券
 * 
 * 
 * @version 1.0
 */
public interface CouponDao extends BaseDao<Coupon, Long> {

	/**
	 * 查找优惠券分页
	 * 
	 * @param isEnabled
	 *            是否启用
	 * @param isExchange
	 *            是否允许积分兑换
	 * @param hasExpired
	 *            是否已过期
	 * @param pageable
	 *            分页信息
	 * @return 优惠券分页
	 */
	Page<Coupon> findPage(Boolean isEnabled, Boolean isExchange, Boolean hasExpired, Pageable pageable);

}