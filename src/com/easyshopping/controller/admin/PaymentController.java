/*
 * 

 * 
 */
package com.easyshopping.controller.admin;

import javax.annotation.Resource;

import com.easyshopping.Message;
import com.easyshopping.Pageable;
import com.easyshopping.entity.Payment;
import com.easyshopping.service.PaymentService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Controller - 收款单
 * 
 * 
 * @version 1.0
 */
@Controller("adminPaymentController")
@RequestMapping("/admin/payment")
public class PaymentController extends BaseController {

	@Resource(name = "paymentServiceImpl")
	private PaymentService paymentService;

	/**
	 * 查看
	 */
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(Long id, ModelMap model) {
		model.addAttribute("payment", paymentService.find(id));
		return "/admin/payment/view";
	}

	/**
	 * 列表
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Pageable pageable, ModelMap model) {
		model.addAttribute("page", paymentService.findPage(pageable));
		return "/admin/payment/list";
	}

	/**
	 * 删除
	 */
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public @ResponseBody
	Message delete(Long[] ids) {
		if (ids != null) {
			for (Long id : ids) {
				Payment payment = paymentService.find(id);
				if (payment != null && payment.getExpire() != null && !payment.hasExpired()) {
					return Message.error("admin.payment.deleteUnexpiredNotAllowed");
				}
			}
			paymentService.delete(ids);
		}
		return SUCCESS_MESSAGE;
	}

}