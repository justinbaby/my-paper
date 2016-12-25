/*
 * 

 * 
 */
package com.easyshopping.service;

import javax.servlet.http.HttpServletRequest;

import com.easyshopping.entity.Payment;

/**
 * Service - 收款单
 * 
 * 
 * @version 1.0
 */
public interface PaymentService extends BaseService<Payment, Long> {

	/**
	 * 根据编号查找收款单
	 * 
	 * @param sn
	 *            编号(忽略大小写)
	 * @return 收款单，若不存在则返回null
	 */
	Payment findBySn(String sn);

	/**
	 * 支付处理
	 * 
	 * @param payment
	 *            收款单
	 */
	void handle(Payment payment, HttpServletRequest request);

}