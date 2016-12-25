/*
 * 

 * 
 */
package com.easyshopping.entity;

import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.PreRemove;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Digits;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import com.easyshopping.Setting;
import com.easyshopping.util.SettingUtils;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

/**
 * Entity - 配送方式
 * 
 * 
 * @version 1.0
 */
@Entity
@Table(name = "xx_shipping_method")
@SequenceGenerator(name = "sequenceGenerator", sequenceName = "xx_shipping_method_sequence")
public class ShippingMethod extends OrderEntity {

	private static final long serialVersionUID = 5873163245980853245L;

	/** 名称 */
	private String name;

	/** 首重量 */
	private Integer firstWeight;

	/** 续重量 */
	private Integer continueWeight;

	/** 首重价格 */
	private BigDecimal firstPrice;

	/** 续重价格 */
	private BigDecimal continuePrice;

	/** 图标 */
	private String icon;

	/** 介绍 */
	private String description;

	/** 默认物流公司 */
	private DeliveryCorp defaultDeliveryCorp;

	/** 支付方式 */
	private Set<PaymentMethod> paymentMethods = new HashSet<PaymentMethod>();

	/** 订单 */
	private Set<Order> orders = new HashSet<Order>();

	/**
	 * 获取名称
	 * 
	 * @return 名称
	 */
	@NotEmpty
	@Length(max = 200)
	@Column(nullable = false)
	public String getName() {
		return name;
	}

	/**
	 * 设置名称
	 * 
	 * @param name
	 *            名称
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * 获取首重量
	 * 
	 * @return 首重量
	 */
	@NotNull
	@Min(0)
	@Column(nullable = false)
	public Integer getFirstWeight() {
		return firstWeight;
	}

	/**
	 * 设置首重量
	 * 
	 * @param firstWeight
	 *            首重量
	 */
	public void setFirstWeight(Integer firstWeight) {
		this.firstWeight = firstWeight;
	}

	/**
	 * 获取续重量
	 * 
	 * @return 续重量
	 */
	@NotNull
	@Min(1)
	@Column(nullable = false)
	public Integer getContinueWeight() {
		return continueWeight;
	}

	/**
	 * 设置续重量
	 * 
	 * @param continueWeight
	 *            续重量
	 */
	public void setContinueWeight(Integer continueWeight) {
		this.continueWeight = continueWeight;
	}

	/**
	 * 获取首重价格
	 * 
	 * @return 首重价格
	 */
	@NotNull
	@Min(0)
	@Digits(integer = 12, fraction = 3)
	@Column(nullable = false, precision = 21, scale = 6)
	public BigDecimal getFirstPrice() {
		return firstPrice;
	}

	/**
	 * 设置首重价格
	 * 
	 * @param firstPrice
	 *            首重价格
	 */
	public void setFirstPrice(BigDecimal firstPrice) {
		this.firstPrice = firstPrice;
	}

	/**
	 * 获取续重价格
	 * 
	 * @return 续重价格
	 */
	@NotNull
	@Min(0)
	@Digits(integer = 12, fraction = 3)
	@Column(nullable = false, precision = 21, scale = 6)
	public BigDecimal getContinuePrice() {
		return continuePrice;
	}

	/**
	 * 设置续重价格
	 * 
	 * @param continuePrice
	 *            续重价格
	 */
	public void setContinuePrice(BigDecimal continuePrice) {
		this.continuePrice = continuePrice;
	}

	/**
	 * 获取图标
	 * 
	 * @return 图标
	 */
	@Length(max = 200)
	public String getIcon() {
		return icon;
	}

	/**
	 * 设置图标
	 * 
	 * @param icon
	 *            图标
	 */
	public void setIcon(String icon) {
		this.icon = icon;
	}

	/**
	 * 获取介绍
	 * 
	 * @return 介绍
	 */
	@Lob
	public String getDescription() {
		return description;
	}

	/**
	 * 设置介绍
	 * 
	 * @param description
	 *            介绍
	 */
	public void setDescription(String description) {
		this.description = description;
	}

	/**
	 * 获取默认物流公司
	 * 
	 * @return 默认物流公司
	 */
	@ManyToOne(fetch = FetchType.LAZY)
	public DeliveryCorp getDefaultDeliveryCorp() {
		return defaultDeliveryCorp;
	}

	/**
	 * 设置默认物流公司
	 * 
	 * @param defaultDeliveryCorp
	 *            默认物流公司
	 */
	public void setDefaultDeliveryCorp(DeliveryCorp defaultDeliveryCorp) {
		this.defaultDeliveryCorp = defaultDeliveryCorp;
	}

	/**
	 * 获取支付方式
	 * 
	 * @return 支付方式
	 */
	@ManyToMany(mappedBy = "shippingMethods", fetch = FetchType.LAZY)
	public Set<PaymentMethod> getPaymentMethods() {
		return paymentMethods;
	}

	/**
	 * 设置支付方式
	 * 
	 * @param paymentMethods
	 *            支付方式
	 */
	public void setPaymentMethods(Set<PaymentMethod> paymentMethods) {
		this.paymentMethods = paymentMethods;
	}

	/**
	 * 获取订单
	 * 
	 * @return 订单
	 */
	@OneToMany(mappedBy = "shippingMethod", fetch = FetchType.LAZY)
	public Set<Order> getOrders() {
		return orders;
	}

	/**
	 * 设置订单
	 * 
	 * @param orders
	 *            订单
	 */
	public void setOrders(Set<Order> orders) {
		this.orders = orders;
	}

	/**
	 * 计算运费
	 * 
	 * @param weight
	 *            重量
	 * @return 运费
	 */
	@Transient
	public BigDecimal calculateFreight(Integer weight) {
		Setting setting = SettingUtils.get();
		BigDecimal freight = new BigDecimal(0);
		if (weight != null) {
			if (weight <= getFirstWeight() || getContinuePrice().compareTo(new BigDecimal(0)) == 0) {
				freight = getFirstPrice();
			} else {
				double contiuneWeightCount = Math.ceil((weight - getFirstWeight()) / (double) getContinueWeight());
				freight = getFirstPrice().add(getContinuePrice().multiply(new BigDecimal(contiuneWeightCount)));
			}
		}
		return setting.setScale(freight);
	}

	/**
	 * 删除前处理
	 */
	@PreRemove
	public void preRemove() {
		Set<PaymentMethod> paymentMethods = getPaymentMethods();
		if (paymentMethods != null) {
			for (PaymentMethod paymentMethod : paymentMethods) {
				paymentMethod.getShippingMethods().remove(this);
			}
		}
		Set<Order> orders = getOrders();
		if (orders != null) {
			for (Order order : orders) {
				order.setShippingMethod(null);
			}
		}
	}

}