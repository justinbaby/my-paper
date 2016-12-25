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

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * Entity - 参数
 * 
 * 
 * @version 1.0
 */
@Entity
@Table(name = "xx_parameter")
@SequenceGenerator(name = "sequenceGenerator", sequenceName = "xx_parameter_sequence")
public class Parameter extends OrderEntity {

	private static final long serialVersionUID = -5833568086582136314L;

	/** 名称 */
	private String name;

	/** 参数组 */
	private ParameterGroup parameterGroup;

	/**
	 * 获取名称
	 * 
	 * @return 名称
	 */
	@JsonProperty
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
	 * 获取参数组
	 * 
	 * @return 参数组
	 */
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(nullable = false)
	public ParameterGroup getParameterGroup() {
		return parameterGroup;
	}

	/**
	 * 设置参数组
	 * 
	 * @param parameterGroup
	 *            参数组
	 */
	public void setParameterGroup(ParameterGroup parameterGroup) {
		this.parameterGroup = parameterGroup;
	}

}