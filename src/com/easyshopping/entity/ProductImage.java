/*
 * 

 * 
 */
package com.easyshopping.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Transient;
import javax.validation.constraints.Min;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.builder.CompareToBuilder;
import org.hibernate.validator.constraints.Length;
import org.springframework.web.multipart.MultipartFile;

/**
 * Entity - 商品图片
 * 
 * 
 * @version 1.0
 */
@Embeddable
public class ProductImage implements Serializable, Comparable<ProductImage> {

	private static final long serialVersionUID = -673883300094536107L;

	/** 标题 */
	private String title;

	/** 原图片 */
	private String source;

	/** 大图片 */
	private String large;

	/** 中图片 */
	private String medium;

	/** 缩略图 */
	private String thumbnail;

	/** 排序 */
	private Integer order;

	/** 文件 */
	private MultipartFile file;

	/**
	 * 获取标题
	 * 
	 * @return 标题
	 */
	@Length(max = 200)
	public String getTitle() {
		return title;
	}

	/**
	 * 设置标题
	 * 
	 * @param title
	 *            标题
	 */
	public void setTitle(String title) {
		this.title = title;
	}

	/**
	 * 获取原图片
	 * 
	 * @return 原图片
	 */
	public String getSource() {
		return source;
	}

	/**
	 * 设置原图片
	 * 
	 * @param source
	 *            原图片
	 */
	public void setSource(String source) {
		this.source = source;
	}

	/**
	 * 获取大图片
	 * 
	 * @return 大图片
	 */
	public String getLarge() {
		return large;
	}

	/**
	 * 设置大图片
	 * 
	 * @param large
	 *            大图片
	 */
	public void setLarge(String large) {
		this.large = large;
	}

	/**
	 * 获取中图片
	 * 
	 * @return 中图片
	 */
	public String getMedium() {
		return medium;
	}

	/**
	 * 设置中图片
	 * 
	 * @param medium
	 *            中图片
	 */
	public void setMedium(String medium) {
		this.medium = medium;
	}

	/**
	 * 获取缩略图
	 * 
	 * @return 缩略图
	 */
	public String getThumbnail() {
		return thumbnail;
	}

	/**
	 * 设置缩略图
	 * 
	 * @param thumbnail
	 *            缩略图
	 */
	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}

	/**
	 * 获取排序
	 * 
	 * @return 排序
	 */
	@Min(0)
	@Column(name = "orders")
	public Integer getOrder() {
		return order;
	}

	/**
	 * 设置排序
	 * 
	 * @param order
	 *            排序
	 */
	public void setOrder(Integer order) {
		this.order = order;
	}

	/**
	 * 获取文件
	 * 
	 * @return 文件
	 */
	@Transient
	public MultipartFile getFile() {
		return file;
	}

	/**
	 * 设置文件
	 * 
	 * @param file
	 *            文件
	 */
	public void setFile(MultipartFile file) {
		this.file = file;
	}

	/**
	 * 判断是否为空
	 * 
	 * @return 是否为空
	 */
	@Transient
	public boolean isEmpty() {
		return (getFile() == null || getFile().isEmpty()) && (StringUtils.isEmpty(getSource()) || StringUtils.isEmpty(getLarge()) || StringUtils.isEmpty(getMedium()) || StringUtils.isEmpty(getThumbnail()));
	}

	/**
	 * 实现compareTo方法
	 * 
	 * @param productImage
	 *            商品图片
	 * @return 比较结果
	 */
	public int compareTo(ProductImage productImage) {
		return new CompareToBuilder().append(getOrder(), productImage.getOrder()).toComparison();
	}

}