/*
 * 

 * 
 */
package com.easyshopping.template.directive;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.easyshopping.Filter;
import com.easyshopping.Order;
import com.easyshopping.entity.Navigation;
import com.easyshopping.service.NavigationService;

import org.springframework.stereotype.Component;

import freemarker.core.Environment;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

/**
 * 模板指令 - 导航列表
 * 
 * 
 * @version 1.0
 */
@Component("navigationListDirective")
public class NavigationListDirective extends BaseDirective {

	/** 变量名称 */
	private static final String VARIABLE_NAME = "navigations";

	@Resource(name = "navigationServiceImpl")
	private NavigationService navigationService;

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		List<Navigation> navigations;
		boolean useCache = useCache(env, params);
		String cacheRegion = getCacheRegion(env, params);
		Integer count = getCount(params);
		List<Filter> filters = getFilters(params, Navigation.class);
		List<Order> orders = getOrders(params);
		if (useCache) {
			navigations = navigationService.findList(count, filters, orders, cacheRegion);
		} else {
			navigations = navigationService.findList(count, filters, orders);
		}
		setLocalVariable(VARIABLE_NAME, navigations, env, body);
	}

}