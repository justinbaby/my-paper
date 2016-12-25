/*
 * 

 * 
 */
package com.easyshopping.controller.admin;

import javax.annotation.Resource;

import com.easyshopping.Message;
import com.easyshopping.Pageable;
import com.easyshopping.service.ReturnsService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Controller - 退货单
 * 
 * 
 * @version 1.0
 */
@Controller("adminReturnsController")
@RequestMapping("/admin/returns")
public class ReturnsController extends BaseController {

	@Resource(name = "returnsServiceImpl")
	private ReturnsService returnsService;

	/**
	 * 查看
	 */
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(Long id, ModelMap model) {
		model.addAttribute("returns", returnsService.find(id));
		return "/admin/returns/view";
	}

	/**
	 * 列表
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Pageable pageable, ModelMap model) {
		model.addAttribute("page", returnsService.findPage(pageable));
		return "/admin/returns/list";
	}

	/**
	 * 删除
	 */
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public @ResponseBody
	Message delete(Long[] ids) {
		returnsService.delete(ids);
		return SUCCESS_MESSAGE;
	}

}