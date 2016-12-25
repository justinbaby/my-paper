/*
 * 

 * 
 */
package com.easyshopping.controller.shop;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import com.easyshopping.Message;
import com.easyshopping.entity.Member;
import com.easyshopping.entity.Product;
import com.easyshopping.entity.ProductNotify;
import com.easyshopping.service.MemberService;
import com.easyshopping.service.ProductNotifyService;
import com.easyshopping.service.ProductService;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Controller - 到货通知
 * 
 * 
 * @version 1.0
 */
@Controller("shopProductNotifyController")
@RequestMapping("/product_notify")
public class ProductNotifyController extends BaseController {

	@Resource(name = "productNotifyServiceImpl")
	private ProductNotifyService productNotifyService;
	@Resource(name = "memberServiceImpl")
	private MemberService memberService;
	@Resource(name = "productServiceImpl")
	private ProductService productService;

	/**
	 * 获取当前会员E-mail
	 */
	@RequestMapping(value = "/email", method = RequestMethod.GET)
	public @ResponseBody
	Map<String, String> email() {
		Member member = memberService.getCurrent();
		String email = member != null ? member.getEmail() : null;
		Map<String, String> data = new HashMap<String, String>();
		data.put("email", email);
		return data;
	}

	/**
	 * 保存
	 */
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> save(String email, Long productId) {
		Map<String, Object> data = new HashMap<String, Object>();
		if (!isValid(ProductNotify.class, "email", email)) {
			data.put("message", ERROR_MESSAGE);
			return data;
		}
		Product product = productService.find(productId);
		if (product == null) {
			data.put("message", Message.warn("shop.productNotify.productNotExist"));
			return data;
		}
		if (!product.getIsMarketable()) {
			data.put("message", Message.warn("shop.productNotify.productNotMarketable"));
			return data;
		}
		if (!product.getIsOutOfStock()) {
			data.put("message", Message.warn("shop.productNotify.productInStock"));
		}
		if (productNotifyService.exists(product, email)) {
			data.put("message", Message.warn("shop.productNotify.exist"));
		} else {
			ProductNotify productNotify = new ProductNotify();
			productNotify.setEmail(email);
			productNotify.setHasSent(false);
			productNotify.setMember(memberService.getCurrent());
			productNotify.setProduct(product);
			productNotifyService.save(productNotify);
			data.put("message", SUCCESS_MESSAGE);
		}
		return data;
	}

}