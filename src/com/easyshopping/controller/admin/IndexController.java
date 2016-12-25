/*
 * 

 * 
 */
package com.easyshopping.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.easyshopping.entity.Article;
import com.easyshopping.entity.Product;
import com.easyshopping.service.ArticleService;
import com.easyshopping.service.ProductService;
import com.easyshopping.service.SearchService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Controller - 索引
 * 
 * 
 * @version 1.0
 */
@Controller("adminIndexController")
@RequestMapping("/admin/index")
public class IndexController extends BaseController {

	@Resource(name = "articleServiceImpl")
	private ArticleService articleService;
	@Resource(name = "productServiceImpl")
	private ProductService productService;
	@Resource(name = "searchServiceImpl")
	private SearchService searchService;

	/**
	 * 生成类型
	 */
	public enum BuildType {
		/**
		 * 文章
		 */
		article,
		/**
		 * 商品
		 */
		product
	}

	/**
	 * 生成索引
	 */
	@RequestMapping(value = "/build", method = RequestMethod.GET)
	public String build(ModelMap model) {
		model.addAttribute("buildTypes", BuildType.values());
		return "/admin/index/build";
	}

	/**
	 * 生成索引
	 */
	@RequestMapping(value = "/build", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> build(BuildType buildType, Boolean isPurge, Integer first, Integer count) {
		long startTime = System.currentTimeMillis();
		if (first == null || first < 0) {
			first = 0;
		}
		if (count == null || count <= 0) {
			count = 50;
		}
		int buildCount = 0;
		boolean isCompleted = true;
		if (buildType == BuildType.article) {
			if (first == 0 && isPurge != null && isPurge) {
				searchService.purge(Article.class);
			}
			List<Article> articles = articleService.findList(null, null, null, first, count);
			for (Article article : articles) {
				searchService.index(article);
				buildCount++;
			}
			first += articles.size();
			if (articles.size() == count) {
				isCompleted = false;
			}
		} else if (buildType == BuildType.product) {
			if (first == 0 && isPurge != null && isPurge) {
				searchService.purge(Product.class);
			}
			List<Product> products = productService.findList(null, null, null, first, count);
			for (Product product : products) {
				searchService.index(product);
				buildCount++;
			}
			first += products.size();
			if (products.size() == count) {
				isCompleted = false;
			}
		}
		long endTime = System.currentTimeMillis();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("first", first);
		map.put("buildCount", buildCount);
		map.put("buildTime", endTime - startTime);
		map.put("isCompleted", isCompleted);
		return map;
	}

}