/*
 * 

 * 
 */
package com.easyshopping.filter;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Iterator;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.filter.OncePerRequestFilter;

/**
 * Filter - 编码格式转换
 * 
 * 
 * @version 1.0
 */
public class EncodingConvertFilter extends OncePerRequestFilter {

	/** 原编码格式 */
	private String fromEncoding = "ISO-8859-1";

	/** 目标编码格式 */
	private String toEncoding = "UTF-8";

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
		if (request.getMethod().equalsIgnoreCase("GET")) {
			for (Iterator<String[]> iterator = request.getParameterMap().values().iterator(); iterator.hasNext();) {
				String[] parames = iterator.next();
				for (int i = 0; i < parames.length; i++) {
					try {
						parames[i] = new String(parames[i].getBytes(fromEncoding), toEncoding);
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				}
			}
		}
		filterChain.doFilter(request, response);
	}

	/**
	 * 获取原编码格式
	 * 
	 * @return 原编码格式
	 */
	public String getFromEncoding() {
		return fromEncoding;
	}

	/**
	 * 设置原编码格式
	 * 
	 * @param fromEncoding
	 *            原编码格式
	 */
	public void setFromEncoding(String fromEncoding) {
		this.fromEncoding = fromEncoding;
	}

	/**
	 * 获取目标编码格式
	 * 
	 * @return 目标编码格式
	 */
	public String getToEncoding() {
		return toEncoding;
	}

	/**
	 * 设置目标编码格式
	 * 
	 * @param toEncoding
	 *            目标编码格式
	 */
	public void setToEncoding(String toEncoding) {
		this.toEncoding = toEncoding;
	}

}