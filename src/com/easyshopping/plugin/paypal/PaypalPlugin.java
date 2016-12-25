/*
 * 

 * 
 */
package com.easyshopping.plugin.paypal;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.easyshopping.entity.Payment;
import com.easyshopping.entity.PluginConfig;
import com.easyshopping.plugin.PaymentPlugin;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;

/**
 * Plugin - Paypal
 * 
 * 
 * @version 1.0
 */
@Component("paypalPlugin")
public class PaypalPlugin extends PaymentPlugin {

	/**
	 * 货币
	 */
	public enum Currency {

		/** 美元 */
		USD,

		/** 澳大利亚元 */
		AUD,

		/** 加拿大元 */
		CAD,

		/** 捷克克郎 */
		CZK,

		/** 丹麦克朗 */
		DKK,

		/** 欧元 */
		EUR,

		/** 港元 */
		HKD,

		/** 匈牙利福林 */
		HUF,

		/** 新西兰元 */
		NZD,

		/** 挪威克朗 */
		NOK,

		/** 波兰兹罗提 */
		PLN,

		/** 英镑 */
		GBP,

		/** 新加坡元 */
		SGD,

		/** 瑞典克朗 */
		SEK,

		/** 瑞士法郎 */
		CHF,

		/** 日元 */
		JPY
	}

	@Override
	public String getName() {
		return "Paypal";
	}

	@Override
	public String getVersion() {
		return "1.0";
	}

	@Override
	public String getAuthor() {
		return "EASY SHOPPING";
	}

	@Override
	public String getSiteUrl() {
		return "#";
	}

	@Override
	public String getInstallUrl() {
		return "paypal/install.jhtml";
	}

	@Override
	public String getUninstallUrl() {
		return "paypal/uninstall.jhtml";
	}

	@Override
	public String getSettingUrl() {
		return "paypal/setting.jhtml";
	}

	@Override
	public String getRequestUrl() {
		return "https://www.paypal.com/cgi-bin/webscr";
	}

	@Override
	public RequestMethod getRequestMethod() {
		return RequestMethod.post;
	}

	@Override
	public String getRequestCharset() {
		return "UTF-8";
	}

	@Override
	public Map<String, Object> getParameterMap(String sn, String description, HttpServletRequest request) {
		PluginConfig pluginConfig = getPluginConfig();
		Payment payment = getPayment(sn);
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		parameterMap.put("cmd", "_xclick");
		parameterMap.put("business", pluginConfig.getAttribute("partner"));
		parameterMap.put("item_name", StringUtils.abbreviate(description.replaceAll("[^0-9a-zA-Z\\u4e00-\\u9fa5 ]", ""), 100));
		parameterMap.put("amount", payment.getAmount().setScale(2).toString());
		parameterMap.put("currency_code", pluginConfig.getAttribute("currency"));
		parameterMap.put("return", getNotifyUrl(sn, NotifyMethod.sync));
		parameterMap.put("notify_url", getNotifyUrl(sn, NotifyMethod.async));
		parameterMap.put("invoice", sn);
		parameterMap.put("charset", "UTF-8");
		parameterMap.put("no_shipping", "1");
		parameterMap.put("no_note", "0");
		parameterMap.put("rm", "2");
		parameterMap.put("custom", "easyshop");
		return parameterMap;
	}

	@SuppressWarnings("all")
	@Override
	public boolean verifyNotify(String sn, NotifyMethod notifyMethod, HttpServletRequest request) {
		PluginConfig pluginConfig = getPluginConfig();
		Payment payment = getPayment(sn);
		if (pluginConfig.getAttribute("partner").equals(request.getParameter("receiver_email")) && sn.equals(request.getParameter("invoice")) && pluginConfig.getAttribute("currency").equals(request.getParameter("mc_currency")) && "Completed".equals(request.getParameter("payment_status")) && payment.getAmount().compareTo(new BigDecimal(request.getParameter("mc_gross"))) == 0) {
			Map<String, Object> parameterMap = new LinkedHashMap<String, Object>();
			parameterMap.put("cmd", "_notify-validate");
			parameterMap.putAll(request.getParameterMap());
			if ("VERIFIED".equals(post("https://www.paypal.com/cgi-bin/webscr", parameterMap))) {
				return true;
			}
		}
		return false;
	}

	@Override
	public String getNotifyMessage(String sn, NotifyMethod notifyMethod, HttpServletRequest request) {
		return null;
	}

	@Override
	public Integer getTimeout() {
		return 21600;
	}

}