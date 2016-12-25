/*
 * 

 * 
 */
package com.easyshopping.entity;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.validation.Valid;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * Entity - 参数组
 * 
 * 
 * @version 1.0
 */
@Entity
@Table(name = "xx_parameter_group")
@SequenceGenerator(name = "sequenceGenerator", sequenceName = "xx_parameter_group_sequence")
public class ParameterGroup extends OrderEntity {

	private static final long serialVersionUID = 192003501177471941L;

	/** 名称 */
	private String name;

	/** 绑定分类 */
	private ProductCategory productCategory;

	/** 参数 */
	private List<Parameter> parameters = new ArrayList<Parameter>();

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
	 * 获取绑定分类
	 * 
	 * @return 绑定分类
	 */
	@NotNull
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(nullable = false)
	public ProductCategory getProductCategory() {
		return productCategory;
	}

	/**
	 * 设置绑定分类
	 * 
	 * @param productCategory
	 *            绑定分类
	 */
	public void setProductCategory(ProductCategory productCategory) {
		this.productCategory = productCategory;
	}

	/**
	 * 获取参数
	 * 
	 * @return 参数
	 */
	@JsonProperty
	@Valid
	@NotEmpty
	@OneToMany(mappedBy = "parameterGroup", fetch = FetchType.LAZY, cascade = CascadeType.ALL, orphanRemoval = true)
	@OrderBy("order asc")
	public List<Parameter> getParameters() {
		return parameters;
	}

	/**
	 * 设置参数
	 * 
	 * @param parameters
	 *            参数
	 */
	public void setParameters(List<Parameter> parameters) {
		this.parameters = parameters;
	}

}