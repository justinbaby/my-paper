/*
 * 

 * 
 */
package com.easyshopping.plugin.alipayPartner;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;

import com.easyshopping.Setting;
import com.easyshopping.entity.Payment;
import com.easyshopping.entity.PluginConfig;
import com.easyshopping.plugin.PaymentPlugin;
import com.easyshopping.util.SettingUtils;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;

/**
 * Plugin - 支付宝(担保交易)
 * 
 * 
 * @version 1.0
 */
@Component("alipayPartnerPlugin")
public class AlipayPartnerPlugin extends PaymentPlugin {

	private final String PLUGIN_VERSION = "1.0";
	
	private final String PLUGIN_NAME = "支付宝(担保交易)";

	private final String PLUGIN_AUTHOR = "EASY SHOPPING";
	
	/**
	 * 商城访问链接。
	 */
	private final String SITE_URL = "http://www.easyxmall.com:520";
	
	/**
	 * 支付宝接口请求链接。
	 */
	private final String REQUEST_URL = "https://mapi.alipay.com/gateway.do";
	
	/**
	 * 支付宝接口请求字符编码。
	 */
	private final String REQUEST_CHARSET = "UTF-8";
	
	@Override
	public String getName() {
		return PLUGIN_NAME;
	}

	@Override
	public String getVersion() {
		return PLUGIN_VERSION;
	}

	@Override
	public String getAuthor() {
		return PLUGIN_AUTHOR;
	}

	@Override
	public String getSiteUrl() {
		return SITE_URL;
	}

	@Override
	public String getInstallUrl() {
		return "alipay_partner/install.jhtml";
	}

	@Override
	public String getUninstallUrl() {
		return "alipay_partner/uninstall.jhtml";
	}

	@Override
	public String getSettingUrl() {
		return "alipay_partner/setting.jhtml";
	}

	@Override
	public String getRequestUrl() {
		return REQUEST_URL;
	}

	@Override
	public RequestMethod getRequestMethod() {
		return RequestMethod.get;
	}

	@Override
	public String getRequestCharset() {
		return REQUEST_CHARSET;
	}

	@Override
	public Map<String, Object> getParameterMap(String sn, String description, HttpServletRequest request) {
		Setting setting = SettingUtils.get();
		PluginConfig pluginConfig = getPluginConfig();
		Payment payment = getPayment(sn);
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		parameterMap.put("service", "create_partner_trade_by_buyer");
		parameterMap.put("partner", pluginConfig.getAttribute("partner"));
		parameterMap.put("_input_charset", "utf-8");
		parameterMap.put("sign_type", "MD5");
		parameterMap.put("return_url", getNotifyUrl(sn, NotifyMethod.sync));
		parameterMap.put("notify_url", getNotifyUrl(sn, NotifyMethod.async));
		parameterMap.put("out_trade_no", sn);
		parameterMap.put("subject", StringUtils.abbreviate(description.replaceAll("[^0-9a-zA-Z\\u4e00-\\u9fa5 ]", ""), 60));
		parameterMap.put("body", StringUtils.abbreviate(description.replaceAll("[^0-9a-zA-Z\\u4e00-\\u9fa5 ]", ""), 600));
		parameterMap.put("payment_type", "1");
		parameterMap.put("logistics_type", "EXPRESS");
		parameterMap.put("logistics_fee", "0");
		parameterMap.put("logistics_payment", "SELLER_PAY");
		parameterMap.put("price", payment.getAmount().setScale(2).toString());
		parameterMap.put("quantity", "1");
		parameterMap.put("seller_id", pluginConfig.getAttribute("partner"));
		parameterMap.put("total_fee", payment.getAmount().setScale(2).toString());
		parameterMap.put("show_url", setting.getSiteUrl());
		parameterMap.put("paymethod", "directPay");
		parameterMap.put("exter_invoke_ip", request.getLocalAddr());
		parameterMap.put("extra_common_param", "easyshop");
		parameterMap.put("sign", generateSign(parameterMap));
		return parameterMap;
	}

	@SuppressWarnings("all")
	@Override
	public boolean verifyNotify(String sn, NotifyMethod notifyMethod, HttpServletRequest request) {
		PluginConfig pluginConfig = getPluginConfig();
		Payment payment = getPayment(sn);
		Map readOnlyMap =   request.getParameterMap();
		Map writeAbleMap = new HashMap();
		writeAbleMap.putAll(readOnlyMap);
		if (generateSign(writeAbleMap).equals(request.getParameter("sign")) && pluginConfig.getAttribute("partner").equals(request.getParameter("seller_id")) && sn.equals(request.getParameter("out_trade_no")) && ("WAIT_SELLER_SEND_GOODS".equals(request.getParameter("trade_status")) || "TRADE_FINISHED".equals(request.getParameter("trade_status")))
				&& payment.getAmount().compareTo(new BigDecimal(request.getParameter("total_fee"))) == 0) {
			Map<String, Object> parameterMap = new HashMap<String, Object>();
			parameterMap.put("service", "notify_verify");
			parameterMap.put("partner", pluginConfig.getAttribute("partner"));
			parameterMap.put("notify_id", request.getParameter("notify_id"));
			if ("true".equals(post("https://mapi.alipay.com/gateway.do", parameterMap))) {
				return true;
			}
		}
		return false;
	}

	@Override
	public String getNotifyMessage(String sn, NotifyMethod notifyMethod, HttpServletRequest request) {
		if (notifyMethod == NotifyMethod.async) {
			return "success";
		}
		return null;
	}

	@Override
	public Integer getTimeout() {
		return 21600;
	}

	/**
	 * 生成签名
	 * 
	 * @param parameterMap
	 *            参数
	 * @return 签名
	 */
	private String generateSign(Map<String, Object> parameterMap) {
		PluginConfig pluginConfig = getPluginConfig();
		return DigestUtils.md5Hex(joinKeyValue(new TreeMap<String, Object>(parameterMap), null, pluginConfig.getAttribute("key"), "&", true, "sign_type", "sign"));
	}

}