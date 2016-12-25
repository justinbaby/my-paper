/*
 * 

 * 
 */
package com.easyshopping.service.impl;

import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.easyshopping.Setting;
import com.easyshopping.dao.ShippingDao;
import com.easyshopping.entity.Shipping;
import com.easyshopping.service.ShippingService;
import com.easyshopping.util.SettingUtils;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * Service - 发货单
 * 
 * 
 * @version 1.0
 */
@Service("shippingServiceImpl")
public class ShippingServiceImpl extends BaseServiceImpl<Shipping, Long> implements ShippingService {

	@Resource(name = "shippingDaoImpl")
	private ShippingDao shippingDao;

	@Resource(name = "shippingDaoImpl")
	public void setBaseDao(ShippingDao shippingDao) {
		super.setBaseDao(shippingDao);
	}

	@Transactional(readOnly = true)
	public Shipping findBySn(String sn) {
		return shippingDao.findBySn(sn);
	}

	@SuppressWarnings("unchecked")
	@Transactional(readOnly = true)
	@Cacheable("shipping")
	public Map<String, Object> query(Shipping shipping) {
		Setting setting = SettingUtils.get();
		Map<String, Object> data = new HashMap<String, Object>();
		if (shipping != null && StringUtils.isNotEmpty(setting.getKuaidi100Key()) && StringUtils.isNotEmpty(shipping.getDeliveryCorpCode()) && StringUtils.isNotEmpty(shipping.getTrackingNo())) {
			try {
				ObjectMapper mapper = new ObjectMapper();
				URL url = new URL("http://api.kuaidi100.com/api?id=" + setting.getKuaidi100Key() + "&com=" + shipping.getDeliveryCorpCode() + "&nu=" + shipping.getTrackingNo() + "&show=0&muti=1&order=asc");
				//Handle JASON data.
				data = mapper.readValue(url, Map.class);
				
				//Handle html data.
				getShippingHtmlTrack(url);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return data;
	}

	@SuppressWarnings("all")
	private String getShippingHtmlTrack(URL url) throws Exception{
		StringBuilder content = null;
		InputStream urlStream = null;
		try
		{
			if(url == null){
				return "";
			}
			URLConnection con=url.openConnection();
			 con.setAllowUserInteraction(false);
			   urlStream = url.openStream();
			   String type = con.guessContentTypeFromStream(urlStream);
			   String charSet=null;
			   if (type == null)
			    type = con.getContentType();

			   if (type == null || type.trim().length() == 0 || type.trim().indexOf("text/html") < 0)
			    return "";

			   if(type.indexOf("charset=") > 0)
			    charSet = type.substring(type.indexOf("charset=") + 8);

			   byte b[] = new byte[10000];
			   int numRead = urlStream.read(b);
			  content = new StringBuilder(new String(b, 0, numRead, "utf-8"));
			   while (numRead != -1) {
			    numRead = urlStream.read(b);
			    if (numRead != -1) {
			     String newContent = new String(b, 0, numRead, "utf-8");
			     content.append(newContent);
			    }
			   }
		}finally{
			if(urlStream!=null){
				urlStream.close();
			}
		}
		System.out.println(content);
		return content==null?"":content.toString();
	}
}