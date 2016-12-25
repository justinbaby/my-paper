/*
 * 

 * 
 */
package com.easyshopping.entity;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.PreRemove;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Digits;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

/**
 * Entity - 收款单
 * 
 * 
 * @version 1.0
 */
@Entity
@Table(name = "xx_payment")
@SequenceGenerator(name = "sequenceGenerator", sequenceName = "xx_payment_sequence")
public class Payment extends BaseEntity {

	private static final long serialVersionUID = -5052430116564638634L;

	/** 支付方式分隔符 */
	public static final String PAYMENT_METHOD_SEPARATOR = " - ";

	/**
	 * 类型
	 */
	public enum Type {

		/** 订单支付 */
		payment,

		/** 预存款充值 */
		recharge
	}

	/**
	 * 方式
	 */
	public enum Method {

		/** 在线支付 */
		online,

		/** 线下支付 */
		offline,

		/** 预存款支付 */
		deposit
	}

	/**
	 * 状态
	 */
	public enum Status {

		/** 等待支付 */
		wait,

		/** 支付成功 */
		success,

		/** 支付失败 */
		failure
	}

	/** 编号 */
	private String sn;
	
	/** 交易号 */
	private String tradeSn;

	/** 类型 */
	private Type type;

	/** 方式 */
	private Method method;

	/** 状态 */
	private Status status;

	/** 支付方式 */
	private String paymentMethod;

	/** 收款银行 */
	private String bank;

	/** 收款账号 */
	private String account;

	/** 支付手续费 */
	private BigDecimal fee;

	/** 付款金额 */
	private BigDecimal amount;

	/** 付款人 */
	private String payer;

	/** 操作员 */
	private String operator;

	/** 付款日期 */
	private Date paymentDate;

	/** 备注 */
	private String memo;

	/** 支付插件ID */
	private String paymentPluginId;

	/** 到期时间 */
	private Date expire;

	/** 预存款 */
	private Deposit deposit;

	/** 会员 */
	private Member member;

	/** 订单 */
	private Order order;

	/**
	 * 获取编号
	 * 
	 * @return 编号
	 */
	@Column(nullable = false, updatable = false, unique = true, length = 100)
	public String getSn() {
		return sn;
	}

	/**
	 * 设置编号
	 * 
	 * @param sn
	 *            编号
	 */
	public void setSn(String sn) {
		this.sn = sn;
	}

	/**
	 * 获取交易号
	 * 
	 * @return
	 */
	@Column(nullable = true, length = 100)
	public String getTradeSn() {
		return tradeSn;
	}

	/**
	 * 设置交易号
	 * 
	 * @param tradeSn
	 */
	public void setTradeSn(String tradeSn) {
		this.tradeSn = tradeSn;
	}

	/**
	 * 获取类型
	 * 
	 * @return 类型
	 */
	@Column(nullable = false, updatable = false)
	public Type getType() {
		return type;
	}

	/**
	 * 设置类型
	 * 
	 * @param type
	 *            类型
	 */
	public void setType(Type type) {
		this.type = type;
	}

	/**
	 * 获取方式
	 * 
	 * @return 方式
	 */
	@NotNull
	@Column(nullable = false, updatable = false)
	public Method getMethod() {
		return method;
	}

	/**
	 * 设置方式
	 * 
	 * @param method
	 *            方式
	 */
	public void setMethod(Method method) {
		this.method = method;
	}

	/**
	 * 获取状态
	 * 
	 * @return 状态
	 */
	@Column(nullable = false)
	public Status getStatus() {
		return status;
	}

	/**
	 * 设置状态
	 * 
	 * @param status
	 *            状态
	 */
	public void setStatus(Status status) {
		this.status = status;
	}

	/**
	 * 获取支付方式
	 * 
	 * @return 支付方式
	 */
	@Column(updatable = false)
	public String getPaymentMethod() {
		return paymentMethod;
	}

	/**
	 * 设置支付方式
	 * 
	 * @param paymentMethod
	 *            支付方式
	 */
	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	/**
	 * 获取收款银行
	 * 
	 * @return 收款银行
	 */
	@Length(max = 200)
	public String getBank() {
		return bank;
	}

	/**
	 * 设置收款银行
	 * 
	 * @param bank
	 *            收款银行
	 */
	public void setBank(String bank) {
		this.bank = bank;
	}

	/**
	 * 获取收款账号
	 * 
	 * @return 收款账号
	 */
	@Length(max = 200)
	public String getAccount() {
		return account;
	}

	/**
	 * 设置收款账号
	 * 
	 * @param account
	 *            收款账号
	 */
	public void setAccount(String account) {
		this.account = account;
	}

	/**
	 * 获取支付手续费
	 * 
	 * @return 支付手续费
	 */
	@Column(nullable = false, precision = 21, scale = 6)
	public BigDecimal getFee() {
		return fee;
	}

	/**
	 * 设置支付手续费
	 * 
	 * @param fee
	 *            支付手续费
	 */
	public void setFee(BigDecimal fee) {
		this.fee = fee;
	}

	/**
	 * 获取付款金额
	 * 
	 * @return 付款金额
	 */
	@NotNull
	@Min(0)
	@Digits(integer = 12, fraction = 3)
	@Column(nullable = false, updatable = false, precision = 21, scale = 6)
	public BigDecimal getAmount() {
		return amount;
	}

	/**
	 * 设置付款金额
	 * 
	 * @param amount
	 *            付款金额
	 */
	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	/**
	 * 获取付款人
	 * 
	 * @return 付款人
	 */
	@Length(max = 200)
	public String getPayer() {
		return payer;
	}

	/**
	 * 设置付款人
	 * 
	 * @param payer
	 *            付款人
	 */
	public void setPayer(String payer) {
		this.payer = payer;
	}

	/**
	 * 获取操作员
	 * 
	 * @return 操作员
	 */
	@Column(updatable = false)
	public String getOperator() {
		return operator;
	}

	/**
	 * 设置操作员
	 * 
	 * @param operator
	 *            操作员
	 */
	public void setOperator(String operator) {
		this.operator = operator;
	}

	/**
	 * 获取付款日期
	 * 
	 * @return 付款日期
	 */
	public Date getPaymentDate() {
		return paymentDate;
	}

	/**
	 * 设置付款日期
	 * 
	 * @param paymentDate
	 *            付款日期
	 */
	public void setPaymentDate(Date paymentDate) {
		this.paymentDate = paymentDate;
	}

	/**
	 * 获取备注
	 * 
	 * @return 备注
	 */
	@Length(max = 200)
	public String getMemo() {
		return memo;
	}

	/**
	 * 设置备注
	 * 
	 * @param memo
	 *            备注
	 */
	public void setMemo(String memo) {
		this.memo = memo;
	}

	/**
	 * 获取支付插件ID
	 * 
	 * @return 支付插件ID
	 */
	@JoinColumn(updatable = false)
	public String getPaymentPluginId() {
		return paymentPluginId;
	}

	/**
	 * 设置支付插件ID
	 * 
	 * @param paymentPluginId
	 *            支付插件ID
	 */
	public void setPaymentPluginId(String paymentPluginId) {
		this.paymentPluginId = paymentPluginId;
	}

	/**
	 * 获取到期时间
	 * 
	 * @return 到期时间
	 */
	@JoinColumn(updatable = false)
	public Date getExpire() {
		return expire;
	}

	/**
	 * 设置到期时间
	 * 
	 * @param expire
	 *            到期时间
	 */
	public void setExpire(Date expire) {
		this.expire = expire;
	}

	/**
	 * 获取预存款
	 * 
	 * @return 预存款
	 */
	@OneToOne(mappedBy = "payment", fetch = FetchType.LAZY)
	public Deposit getDeposit() {
		return deposit;
	}

	/**
	 * 设置预存款
	 * 
	 * @param deposit
	 *            预存款
	 */
	public void setDeposit(Deposit deposit) {
		this.deposit = deposit;
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
	 * 获取订单
	 * 
	 * @return 订单
	 */
	@NotNull
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "orders", updatable = false)
	public Order getOrder() {
		return order;
	}

	/**
	 * 设置订单
	 * 
	 * @param order
	 *            订单
	 */
	public void setOrder(Order order) {
		this.order = order;
	}

	/**
	 * 获取有效金额
	 * 
	 * @return 有效金额
	 */
	@Transient
	public BigDecimal getEffectiveAmount() {
		BigDecimal effectiveAmount = getAmount().subtract(getFee());
		return effectiveAmount.compareTo(new BigDecimal(0)) > 0 ? effectiveAmount : new BigDecimal(0);
	}

	/**
	 * 判断是否已过期
	 * 
	 * @return 是否已过期
	 */
	@Transient
	public boolean hasExpired() {
		return getExpire() != null && new Date().after(getExpire());
	}

	/**
	 * 删除前处理
	 */
	@PreRemove
	public void preRemove() {
		if (getDeposit() != null) {
			getDeposit().setPayment(null);
		}
	}

}