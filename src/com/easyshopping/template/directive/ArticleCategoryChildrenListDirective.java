/*
 * 

 * 
 */
package com.easyshopping.template.directive;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.easyshopping.entity.ArticleCategory;
import com.easyshopping.service.ArticleCategoryService;
import com.easyshopping.util.FreemarkerUtils;

import org.springframework.stereotype.Component;

import freemarker.core.Environment;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

/**
 * 模板指令 - 下级文章分类列表
 * 
 * 
 * @version 1.0
 */
@Component("articleCategoryChildrenListDirective")
public class ArticleCategoryChildrenListDirective extends BaseDirective {

	/** "文章分类ID"参数名称 */
	private static final String ARTICLE_CATEGORY_ID_PARAMETER_NAME = "articleCategoryId";

	/** 变量名称 */
	private static final String VARIABLE_NAME = "articleCategories";

	@Resource(name = "articleCategoryServiceImpl")
	private ArticleCategoryService articleCategoryService;

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Long articleCategoryId = FreemarkerUtils.getParameter(ARTICLE_CATEGORY_ID_PARAMETER_NAME, Long.class, params);

		ArticleCategory articleCategory = articleCategoryService.find(articleCategoryId);

		List<ArticleCategory> articleCategories;
		if (articleCategoryId != null && articleCategory == null) {
			articleCategories = new ArrayList<ArticleCategory>();
		} else {
			boolean useCache = useCache(env, params);
			String cacheRegion = getCacheRegion(env, params);
			Integer count = getCount(params);
			if (useCache) {
				articleCategories = articleCategoryService.findChildren(articleCategory, count, cacheRegion);
			} else {
				articleCategories = articleCategoryService.findChildren(articleCategory, count);
			}
		}
		setLocalVariable(VARIABLE_NAME, articleCategories, env, body);
	}

}