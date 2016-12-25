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

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

/**
 * Entity - 到货通知
 * 
 * 
 * @version 1.0
 */
@Entity
@Table(name = "xx_product_notify")
@SequenceGenerator(name = "sequenceGenerator", sequenceName = "xx_product_notify_sequence")
public class ProductNotify extends BaseEntity {

	private static final long serialVersionUID = 3192904068727393421L;

	/** E-mail */
	private String email;

	/** 是否已发送 */
	private Boolean hasSent;

	/** 会员 */
	private Member member;

	/** 商品 */
	private Product product;

	/**
	 * 获取E-mail
	 * 
	 * @return E-mail
	 */
	@NotEmpty
	@Email
	@Length(max = 200)
	@Column(nullable = false, updatable = false)
	public String getEmail() {
		return email;
	}

	/**
	 * 设置E-mail
	 * 
	 * @param email
	 *            E-mail
	 */
	public void setEmail(String email) {
		this.email = email;
	}

	/**
	 * 获取是否已发送
	 * 
	 * @return 是否已发送
	 */
	@Column(nullable = false)
	public Boolean getHasSent() {
		return hasSent;
	}

	/**
	 * 设置是否已发送
	 * 
	 * @param hasSent
	 *            是否已发送
	 */
	public void setHasSent(Boolean hasSent) {
		this.hasSent = hasSent;
	}

	/**
	 * 获取会员
	 * 
	 * @return 会员
	 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(updatable = false)
	public Member getMember() {
		return member;
	}

	/**
	 * 设置会员
	 * 
	 * @param member
	 *            会员
	 */
	public void setMember(Member member) {
		this.member = member;
	}

	/**
	 * 获取商品
	 * 
	 * @return 商品
	 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(nullable = false, updatable = false)
	public Product getProduct() {
		return product;
	}

	/**
	 * 设置商品
	 * 
	 * @param product
	 *            商品
	 */
	public void setProduct(Product product) {
		this.product = product;
	}

}