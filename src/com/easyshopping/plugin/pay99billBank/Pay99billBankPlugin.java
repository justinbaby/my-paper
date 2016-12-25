/*
 * 

 * 
 */
package com.easyshopping.plugin.pay99billBank;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.easyshopping.entity.Payment;
import com.easyshopping.entity.PluginConfig;
import com.easyshopping.plugin.PaymentPlugin;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;

/**
 * Plugin - 快钱支付(网银直连)
 * 
 * 
 * @version 1.0
 */
@Component("pay99billBankPlugin")
public class Pay99billBankPlugin extends PaymentPlugin {

	/** 默认银行 */
	private static final String DEFAULT_BANK = "ICBC";

	/** 银行参数名称 */
	public static final String BANK_PARAMETER_NAME = "bank";

	@Override
	public String getName() {
		return "快钱支付(网银直连)";
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
		return "pay_99bill_bank/install.jhtml";
	}

	@Override
	public String getUninstallUrl() {
		return "pay_99bill_bank/uninstall.jhtml";
	}

	@Override
	public String getSettingUrl() {
		return "pay_99bill_bank/setting.jhtml";
	}

	@Override
	public String getRequestUrl() {
		return "https://www.99bill.com/gateway/recvMerchantInfoAction.htm";
	}

	@Override
	public RequestMethod getRequestMethod() {
		return RequestMethod.get;
	}

	@Override
	public String getRequestCharset() {
		return "UTF-8";
	}

	@Override
	public Map<String, Object> getParameterMap(String sn, String description, HttpServletRequest request) {
		PluginConfig pluginConfig = getPluginConfig();
		Payment payment = getPayment(sn);
		Map<String, Object> parameterMap = new LinkedHashMap<String, Object>();
		parameterMap.put("inputCharset", "1");
		parameterMap.put("pageUrl", getNotifyUrl(sn, NotifyMethod.sync));
		parameterMap.put("bgUrl", getNotifyUrl(sn, NotifyMethod.async));
		parameterMap.put("version", "v2.0");
		parameterMap.put("language", "1");
		parameterMap.put("signType", "1");
		parameterMap.put("merchantAcctId", pluginConfig.getAttribute("partner"));
		parameterMap.put("payerIP", request.getLocalAddr());
		parameterMap.put("orderId", sn);
		parameterMap.put("orderAmount", payment.getAmount().multiply(new BigDecimal(100)).setScale(0).toString());
		parameterMap.put("orderTime", new SimpleDateFormat("yyyyMMddhhmmss").format(new Date()));
		parameterMap.put("orderTimestamp", new SimpleDateFormat("yyyyMMddhhmmss").format(new Date()));
		parameterMap.put("productName", StringUtils.abbreviate(description.replaceAll("[^0-9a-zA-Z\\u4e00-\\u9fa5 ]", ""), 100));
		parameterMap.put("productDesc", StringUtils.abbreviate(description.replaceAll("[^0-9a-zA-Z\\u4e00-\\u9fa5 ]", ""), 400));
		parameterMap.put("ext1", "easyshop");
		parameterMap.put("payType", "10");
		String bank = request.getParameter(BANK_PARAMETER_NAME);
		parameterMap.put("bankId", StringUtils.isNotEmpty(bank) ? bank : DEFAULT_BANK);
		parameterMap.put("signMsg", generateSign(parameterMap));
		return parameterMap;
	}

	@Override
	public boolean verifyNotify(String sn, NotifyMethod notifyMethod, HttpServletRequest request) {
		PluginConfig pluginConfig = getPluginConfig();
		Payment payment = getPayment(sn);
		Map<String, Object> parameterMap = new LinkedHashMap<String, Object>();
		parameterMap.put("merchantAcctId", request.getParameter("merchantAcctId"));
		parameterMap.put("version", request.getParameter("version"));
		parameterMap.put("language", request.getParameter("language"));
		parameterMap.put("signType", request.getParameter("signType"));
		parameterMap.put("payType", request.getParameter("payType"));
		parameterMap.put("bankId", request.getParameter("bankId"));
		parameterMap.put("orderId", request.getParameter("orderId"));
		parameterMap.put("orderTime", request.getParameter("orderTime"));
		parameterMap.put("orderAmount", request.getParameter("orderAmount"));
		parameterMap.put("bindCard", request.getParameter("bindCard"));
		parameterMap.put("bindMobile", request.getParameter("bindMobile"));
		parameterMap.put("dealId", request.getParameter("dealId"));
		parameterMap.put("bankDealId", request.getParameter("bankDealId"));
		parameterMap.put("dealTime", request.getParameter("dealTime"));
		parameterMap.put("payAmount", request.getParameter("payAmount"));
		parameterMap.put("fee", request.getParameter("fee"));
		parameterMap.put("ext1", request.getParameter("ext1"));
		parameterMap.put("ext2", request.getParameter("ext2"));
		parameterMap.put("payResult", request.getParameter("payResult"));
		parameterMap.put("errCode", request.getParameter("errCode"));
		parameterMap.put("signMsg", request.getParameter("signMsg"));
		if (generateSign(parameterMap).equals(request.getParameter("signMsg")) && pluginConfig.getAttribute("partner").equals(request.getParameter("merchantAcctId")) && sn.equals(request.getParameter("orderId")) && "10".equals(request.getParameter("payResult")) && payment.getAmount().multiply(new BigDecimal(100)).compareTo(new BigDecimal(request.getParameter("payAmount"))) == 0) {
			return true;
		}
		return false;
	}

	@Override
	public String getNotifyMessage(String sn, NotifyMethod notifyMethod, HttpServletRequest request) {
		if (notifyMethod == NotifyMethod.async) {
			return "<result>1</result>";
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
		return DigestUtils.md5Hex(joinKeyValue(parameterMap, null, "&key=" + pluginConfig.getAttribute("key"), "&", true, "signMsg")).toUpperCase();
	}

}