/*
 * 

 * 
 */
package com.easyshopping.plugin.yeepay;

import java.math.BigDecimal;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;

import com.easyshopping.entity.Payment;
import com.easyshopping.entity.PluginConfig;
import com.easyshopping.plugin.PaymentPlugin;
import com.easyshopping.util.WebUtils;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;

/**
 * Plugin - 易宝支付
 * 
 * 
 * @version 1.0
 */
@Component("yeepayPlugin")
public class YeepayPlugin extends PaymentPlugin {

	@Override
	public String getName() {
		return "易宝支付";
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
		return "yeepay/install.jhtml";
	}

	@Override
	public String getUninstallUrl() {
		return "yeepay/uninstall.jhtml";
	}

	@Override
	public String getSettingUrl() {
		return "yeepay/setting.jhtml";
	}

	@Override
	public String getRequestUrl() {
		return "https://www.yeepay.com/app-merchant-proxy/node";
	}

	@Override
	public RequestMethod getRequestMethod() {
		return RequestMethod.get;
	}

	@Override
	public String getRequestCharset() {
		return "GBK";
	}

	@Override
	public Map<String, Object> getParameterMap(String sn, String description, HttpServletRequest request) {
		PluginConfig pluginConfig = getPluginConfig();
		Payment payment = getPayment(sn);
		Map<String, Object> parameterMap = new LinkedHashMap<String, Object>();
		parameterMap.put("p0_Cmd", "Buy");
		parameterMap.put("p1_MerId", pluginConfig.getAttribute("partner"));
		parameterMap.put("p2_Order", sn);
		parameterMap.put("p3_Amt", payment.getAmount().setScale(2).toString());
		parameterMap.put("p4_Cur", "CNY");
		parameterMap.put("p5_Pid", StringUtils.abbreviate(description.replaceAll("[^0-9a-zA-Z\\u4e00-\\u9fa5 ]", ""), 20));
		parameterMap.put("p7_Pdesc", StringUtils.abbreviate(description.replaceAll("[^0-9a-zA-Z\\u4e00-\\u9fa5 ]", ""), 20));
		parameterMap.put("p8_Url", getNotifyUrl(sn, NotifyMethod.general));
		parameterMap.put("p9_SAF", "0");
		parameterMap.put("pa_MP", "easyshop");
		parameterMap.put("pr_NeedResponse", "1");
		parameterMap.put("hmac", generateSign(parameterMap));
		return parameterMap;
	}

	@Override
	public boolean verifyNotify(String sn, NotifyMethod notifyMethod, HttpServletRequest request) {
		PluginConfig pluginConfig = getPluginConfig();
		Payment payment = getPayment(sn);
		Map<String, String[]> parameterValuesMap = WebUtils.getParameterMap(request.getQueryString(), "GBK");
		Map<String, Object> parameterMap = new LinkedHashMap<String, Object>();
		parameterMap.put("p1_MerId", parameterValuesMap.get("p1_MerId"));
		parameterMap.put("r0_Cmd", parameterValuesMap.get("r0_Cmd"));
		parameterMap.put("r1_Code", parameterValuesMap.get("r1_Code"));
		parameterMap.put("r2_TrxId", parameterValuesMap.get("r2_TrxId"));
		parameterMap.put("r3_Amt", parameterValuesMap.get("r3_Amt"));
		parameterMap.put("r4_Cur", parameterValuesMap.get("r4_Cur"));
		parameterMap.put("r5_Pid", parameterValuesMap.get("r5_Pid"));
		parameterMap.put("r6_Order", parameterValuesMap.get("r6_Order"));
		parameterMap.put("r7_Uid", parameterValuesMap.get("r7_Uid"));
		parameterMap.put("r8_MP", parameterValuesMap.get("r8_MP"));
		parameterMap.put("r9_BType", parameterValuesMap.get("r9_BType"));
		if (generateSign(parameterMap).equals(parameterValuesMap.get("hmac")[0]) && pluginConfig.getAttribute("partner").equals(parameterValuesMap.get("p1_MerId")[0]) && sn.equals(parameterValuesMap.get("r6_Order")[0]) && "1".equals(parameterValuesMap.get("r1_Code")[0]) && payment.getAmount().compareTo(new BigDecimal(parameterValuesMap.get("r3_Amt")[0])) == 0) {
			return true;
		}
		return false;
	}

	@Override
	public String getNotifyMessage(String sn, NotifyMethod notifyMethod, HttpServletRequest request) {
		if ("2".equals(WebUtils.getParameter(request.getQueryString(), "GBK", "r9_BType"))) {
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
		return hmacDigest(joinValue(parameterMap, null, null, null, false, "hmac"), pluginConfig.getAttribute("key"));
	}

	/**
	 * Hmac加密
	 * 
	 * @param value
	 *            值
	 * @param key
	 *            密钥
	 * @return 密文
	 */
	private String hmacDigest(String value, String key) {
		try {
			Mac mac = Mac.getInstance("HmacMD5");
			mac.init(new SecretKeySpec(key.getBytes("UTF-8"), "HmacMD5"));
			byte[] bytes = mac.doFinal(value.getBytes("UTF-8"));

			StringBuffer digest = new StringBuffer();
			for (int i = 0; i < bytes.length; i++) {
				String hex = Integer.toHexString(0xFF & bytes[i]);
				if (hex.length() == 1) {
					digest.append("0");
				}
				digest.append(hex);
			}
			return digest.toString();
		} catch (Exception e) {
			return null;
		}
	}

}