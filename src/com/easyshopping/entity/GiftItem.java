/*
 * 

 * 
 */
package com.easyshopping.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * Entity - 赠品项
 * 
 * 
 * @version 1.0
 */
@Entity
@Table(name = "xx_gift_item", uniqueConstraints = { @UniqueConstraint(columnNames = { "gift", "promotion" }) })
@SequenceGenerator(name = "sequenceGenerator", sequenceName = "xx_gift_item_sequence")
public class GiftItem extends BaseEntity {

	private static final long serialVersionUID = 6593657730952481829L;

	/** 数量 */
	private Integer quantity;

	/** 赠品 */
	private Product gift;

	/** 促销 */
	private Promotion promotion;

	/**
	 * 获取数量
	 * 
	 * @return 数量
	 */
	@JsonProperty
	@NotNull
	@Min(1)
	@Column(nullable = false)
	public Integer getQuantity() {
		return quantity;
	}

	/**
	 * 设置数量
	 * 
	 * @param quantity
	 *            数量
	 */
	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	/**
	 * 获取赠品
	 * 
	 * @return 赠品
	 */
	@JsonProperty
	@NotNull
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(nullable = false, updatable = false)
	public Product getGift() {
		return gift;
	}

	/**
	 * 设置赠品
	 * 
	 * @param gift
	 *            赠品
	 */
	public void setGift(Product gift) {
		this.gift = gift;
	}

	/**
	 * 获取促销
	 * 
	 * @return 促销
	 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(nullable = false, updatable = false)
	public Promotion getPromotion() {
		return promotion;
	}

	/**
	 * 设置促销
	 * 
	 * @param promotion
	 *            促销
	 */
	public void setPromotion(Promotion promotion) {
		this.promotion = promotion;
	}

}