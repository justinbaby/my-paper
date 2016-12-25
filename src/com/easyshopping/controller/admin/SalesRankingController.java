/*
 * 

 * 
 */
package com.easyshopping.controller.admin;

import java.util.Calendar;
import java.util.Date;

import javax.annotation.Resource;

import com.easyshopping.service.ProductService;

import org.apache.commons.lang.time.DateUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Controller - 销售排行
 * 
 * 
 * @version 1.0
 */
@Controller("adminSalesRankingController")
@RequestMapping("/admin/sales_ranking")
public class SalesRankingController extends BaseController {

	/** 默认数量 */
	private static final int DEFAULT_COUNT = 20;

	@Resource(name = "productServiceImpl")
	private ProductService productService;

	/**
	 * 列表
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Date beginDate, Date endDate, Integer count, Model model) {
		if (beginDate != null) {
			Calendar calendar = DateUtils.toCalendar(beginDate);
			calendar.set(Calendar.HOUR_OF_DAY, calendar.getActualMinimum(Calendar.HOUR_OF_DAY));
			calendar.set(Calendar.MINUTE, calendar.getActualMinimum(Calendar.MINUTE));
			calendar.set(Calendar.SECOND, calendar.getActualMinimum(Calendar.SECOND));
			beginDate = calendar.getTime();
		}
		if (endDate != null) {
			Calendar calendar = DateUtils.toCalendar(endDate);
			calendar.set(Calendar.HOUR_OF_DAY, calendar.getActualMaximum(Calendar.HOUR_OF_DAY));
			calendar.set(Calendar.MINUTE, calendar.getActualMaximum(Calendar.MINUTE));
			calendar.set(Calendar.SECOND, calendar.getActualMaximum(Calendar.SECOND));
			endDate = calendar.getTime();
		}
		if (count == null || count <= 0) {
			count = DEFAULT_COUNT;
		}
		model.addAttribute("beginDate", beginDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("count", count);
		model.addAttribute("data", productService.findSalesList(beginDate, endDate, count));
		return "/admin/sales_ranking/list";
	}

}