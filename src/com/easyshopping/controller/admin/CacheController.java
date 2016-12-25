/*
 * 

 * 
 */
package com.easyshopping.controller.admin;

import javax.annotation.Resource;

import com.easyshopping.service.CacheService;
import com.easyshopping.service.SearchService;
import com.easyshopping.service.StaticService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * Controller - 缓存
 * 
 * 
 * @version 1.0
 */
@Controller("adminCacheController")
@RequestMapping("/admin/cache")
public class CacheController extends BaseController {

	@Resource(name = "cacheServiceImpl")
	private CacheService cacheService;
	@Resource(name = "staticServiceImpl")
	private StaticService staticService;
	@Resource(name = "searchServiceImpl")
	private SearchService searchService;

	/**
	 * 缓存查看
	 */
	@RequestMapping(value = "/clear", method = RequestMethod.GET)
	public String clear(ModelMap model) {
		Long totalMemory = null;
		Long maxMemory = null;
		Long freeMemory = null;
		try {
			totalMemory = Runtime.getRuntime().totalMemory() / 1024 / 1024;
			maxMemory = Runtime.getRuntime().maxMemory() / 1024 / 1024;
			freeMemory = Runtime.getRuntime().freeMemory() / 1024 / 1024;
		} catch (Exception e) {
		}
		model.addAttribute("totalMemory", totalMemory);
		model.addAttribute("maxMemory", maxMemory);
		model.addAttribute("freeMemory", freeMemory);
		model.addAttribute("cacheSize", cacheService.getCacheSize());
		model.addAttribute("diskStorePath", cacheService.getDiskStorePath());
		return "/admin/cache/clear";
	}

	/**
	 * 清除缓存
	 */
	@RequestMapping(value = "/clear", method = RequestMethod.POST)
	public String clear(RedirectAttributes redirectAttributes) {
		cacheService.clear();
		staticService.buildAll();
		searchService.purge();
		searchService.index();
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:clear.jhtml";
	}

}