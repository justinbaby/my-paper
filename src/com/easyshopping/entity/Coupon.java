/*
 * 

 * 
 */
package com.easyshopping.entity;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.PreRemove;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Digits;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import com.easyshopping.util.FreemarkerUtils;

import org.apache.commons.lang.StringUtils;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

import freemarker.template.TemplateException;

/**
 * Entity - 优惠券
 * 
 * 
 * @version 1.0
 */
@Entity
@Table(name = "xx_coupon")
@SequenceGenerator(name = "sequenceGenerator", sequenceName = "xx_coupon_sequence")
public class Coupon extends BaseEntity {

	private static final long serialVersionUID = -7907808728349149722L;

	/** 名称 */
	private String name;

	/** 前缀 */
	private String prefix;

	/** 使用起始日期 */
	private Date beginDate;

	/** 使用结束日期 */
	private Date endDate;

	/** 最小商品数量 */
	private Integer minimumQuantity;

	/** 最大商品数量 */
	private Integer maximumQuantity;

	/** 最小商品价格 */
	private BigDecimal minimumPrice;

	/** 最大商品价格 */
	private BigDecimal maximumPrice;

	/** 价格运算表达式 */
	private String priceExpression;

	/** 是否启用 */
	private Boolean isEnabled;

	/** 是否允许积分兑换 */
	private Boolean isExchange;

	/** 积分兑换数 */
	private Long point;

	/** 介绍 */
	private String introduction;

	/** 优惠码 */
	private Set<CouponCode> couponCodes = new HashSet<CouponCode>();

	/** 促销 */
	private Set<Promotion> promotions = new HashSet<Promotion>();

	/** 订单 */
	private List<Order> orders = new ArrayList<Order>();

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
	 * 获取前缀
	 * 
	 * @return 前缀
	 */
	@NotEmpty
	@Length(max = 200)
	@Column(nullable = false)
	public String getPrefix() {
		return prefix;
	}

	/**
	 * 设置前缀
	 * 
	 * @param prefix
	 *            前缀
	 */
	public void setPrefix(String prefix) {
		this.prefix = prefix;
	}

	/**
	 * 获取使用起始日期
	 * 
	 * @return 使用起始日期
	 */
	public Date getBeginDate() {
		return beginDate;
	}

	/**
	 * 设置使用起始日期
	 * 
	 * @param beginDate
	 *            使用起始日期
	 */
	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}

	/**
	 * 获取使用结束日期
	 * 
	 * @return 使用结束日期
	 */
	public Date getEndDate() {
		return endDate;
	}

	/**
	 * 设置使用结束日期
	 * 
	 * @param endDate
	 *            使用结束日期
	 */
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	/**
	 * 获取最小商品数量
	 * 
	 * @return 最小商品数量
	 */
	@Min(0)
	public Integer getMinimumQuantity() {
		return minimumQuantity;
	}

	/**
	 * 设置最小商品数量
	 * 
	 * @param minimumQuantity
	 *            最小商品数量
	 */
	public void setMinimumQuantity(Integer minimumQuantity) {
		this.minimumQuantity = minimumQuantity;
	}

	/**
	 * 获取最大商品数量
	 * 
	 * @return 最大商品数量
	 */
	@Min(0)
	public Integer getMaximumQuantity() {
		return maximumQuantity;
	}

	/**
	 * 设置最大商品数量
	 * 
	 * @param maximumQuantity
	 *            最大商品数量
	 */
	public void setMaximumQuantity(Integer maximumQuantity) {
		this.maximumQuantity = maximumQuantity;
	}

	/**
	 * 获取最小商品价格
	 * 
	 * @return 最小商品价格
	 */
	@Min(0)
	@Digits(integer = 12, fraction = 3)
	@Column(precision = 21, scale = 6)
	public BigDecimal getMinimumPrice() {
		return minimumPrice;
	}

	/**
	 * 设置最小商品价格
	 * 
	 * @param minimumPrice
	 *            最小商品价格
	 */
	public void setMinimumPrice(BigDecimal minimumPrice) {
		this.minimumPrice = minimumPrice;
	}

	/**
	 * 获取最大商品价格
	 * 
	 * @return 最大商品价格
	 */
	@Min(0)
	@Digits(integer = 12, fraction = 3)
	@Column(precision = 21, scale = 6)
	public BigDecimal getMaximumPrice() {
		return maximumPrice;
	}

	/**
	 * 设置最大商品价格
	 * 
	 * @param maximumPrice
	 *            最大商品价格
	 */
	public void setMaximumPrice(BigDecimal maximumPrice) {
		this.maximumPrice = maximumPrice;
	}

	/**
	 * 获取价格运算表达式
	 * 
	 * @return 价格运算表达式
	 */
	public String getPriceExpression() {
		return priceExpression;
	}

	/**
	 * 设置价格运算表达式
	 * 
	 * @param priceExpression
	 *            价格运算表达式
	 */
	public void setPriceExpression(String priceExpression) {
		this.priceExpression = priceExpression;
	}

	/**
	 * 获取是否启用
	 * 
	 * @return 是否启用
	 */
	@NotNull
	@Column(nullable = false)
	public Boolean getIsEnabled() {
		return isEnabled;
	}

	/**
	 * 设置是否启用
	 * 
	 * @param isEnabled
	 *            是否启用
	 */
	public void setIsEnabled(Boolean isEnabled) {
		this.isEnabled = isEnabled;
	}

	/**
	 * 获取是否允许积分兑换
	 * 
	 * @return 是否允许积分兑换
	 */
	@NotNull
	@Column(nullable = false)
	public Boolean getIsExchange() {
		return isExchange;
	}

	/**
	 * 设置是否允许积分兑换
	 * 
	 * @param isExchange
	 *            是否允许积分兑换
	 */
	public void setIsExchange(Boolean isExchange) {
		this.isExchange = isExchange;
	}

	/**
	 * 获取积分兑换数
	 * 
	 * @return 积分兑换数
	 */
	@Min(0)
	public Long getPoint() {
		return point;
	}

	/**
	 * 设置积分兑换数
	 * 
	 * @param point
	 *            积分兑换数
	 */
	public void setPoint(Long point) {
		this.point = point;
	}

	/**
	 * 获取介绍
	 * 
	 * @return 介绍
	 */
	@Lob
	public String getIntroduction() {
		return introduction;
	}

	/**
	 * 设置介绍
	 * 
	 * @param introduction
	 *            介绍
	 */
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	/**
	 * 获取优惠码
	 * 
	 * @return 优惠码
	 */
	@OneToMany(mappedBy = "coupon", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
	public Set<CouponCode> getCouponCodes() {
		return couponCodes;
	}

	/**
	 * 设置优惠码
	 * 
	 * @param couponCodes
	 *            优惠码
	 */
	public void setCouponCodes(Set<CouponCode> couponCodes) {
		this.couponCodes = couponCodes;
	}

	/**
	 * 获取促销
	 * 
	 * @return 促销
	 */
	@ManyToMany(mappedBy = "coupons", fetch = FetchType.LAZY)
	public Set<Promotion> getPromotions() {
		return promotions;
	}

	/**
	 * 设置促销
	 * 
	 * @param promotions
	 *            促销
	 */
	public void setPromotions(Set<Promotion> promotions) {
		this.promotions = promotions;
	}

	/**
	 * 获取订单
	 * 
	 * @return 订单
	 */
	@ManyToMany(mappedBy = "coupons", fetch = FetchType.LAZY)
	public List<Order> getOrders() {
		return orders;
	}

	/**
	 * 设置订单
	 * 
	 * @param orders
	 *            订单
	 */
	public void setOrders(List<Order> orders) {
		this.orders = orders;
	}

	/**
	 * 判断是否已开始
	 * 
	 * @return 是否已开始
	 */
	@Transient
	public boolean hasBegun() {
		return getBeginDate() == null || new Date().after(getBeginDate());
	}

	/**
	 * 判断是否已过期
	 * 
	 * @return 是否已过期
	 */
	@Transient
	public boolean hasExpired() {
		return getEndDate() != null && new Date().after(getEndDate());
	}

	/**
	 * 计算优惠价格
	 * 
	 * @param quantity
	 *            商品数量
	 * @param price
	 *            商品价格
	 * @return 优惠价格
	 */
	@Transient
	public BigDecimal calculatePrice(Integer quantity, BigDecimal price) {
		if (price == null || StringUtils.isEmpty(getPriceExpression())) {
			return price;
		}
		BigDecimal result = new BigDecimal(0);
		try {
			Map<String, Object> model = new HashMap<String, Object>();
			model.put("quantity", quantity);
			model.put("price", price);
			result = new BigDecimal(FreemarkerUtils.process("#{(" + getPriceExpression() + ");M50}", model));
		} catch (IOException e) {
			e.printStackTrace();
		} catch (TemplateException e) {
			e.printStackTrace();
		}
		if (result.compareTo(price) > 0) {
			return price;
		}
		return result.compareTo(new BigDecimal(0)) > 0 ? result : new BigDecimal(0);
	}

	/**
	 * 删除前处理
	 */
	@PreRemove
	public void preRemove() {
		Set<Promotion> promotions = getPromotions();
		if (promotions != null) {
			for (Promotion promotion : promotions) {
				promotion.getCoupons().remove(this);
			}
		}
		List<Order> orders = getOrders();
		if (orders != null) {
			for (Order order : orders) {
				order.getCoupons().remove(this);
			}
		}
	}

}