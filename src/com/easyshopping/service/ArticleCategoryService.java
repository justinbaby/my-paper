/*
 * 

 * 
 */
package com.easyshopping.service;

import java.util.List;

import com.easyshopping.entity.ArticleCategory;

/**
 * Service - 文章分类
 * 
 * 
 * @version 1.0
 */
public interface ArticleCategoryService extends BaseService<ArticleCategory, Long> {

	/**
	 * 查找顶级文章分类
	 * 
	 * @return 顶级文章分类
	 */
	List<ArticleCategory> findRoots();

	/**
	 * 查找顶级文章分类
	 * 
	 * @param count
	 *            数量
	 * @return 顶级文章分类
	 */
	List<ArticleCategory> findRoots(Integer count);

	/**
	 * 查找顶级文章分类(缓存)
	 * 
	 * @param count
	 *            数量
	 * @param cacheRegion
	 *            缓存区域
	 * @return 顶级文章分类(缓存)
	 */
	List<ArticleCategory> findRoots(Integer count, String cacheRegion);

	/**
	 * 查找上级文章分类
	 * 
	 * @param articleCategory
	 *            文章分类
	 * @return 上级文章分类
	 */
	List<ArticleCategory> findParents(ArticleCategory articleCategory);

	/**
	 * 查找上级文章分类
	 * 
	 * @param articleCategory
	 *            文章分类
	 * @param count
	 *            数量
	 * @return 上级文章分类
	 */
	List<ArticleCategory> findParents(ArticleCategory articleCategory, Integer count);

	/**
	 * 查找上级文章分类(缓存)
	 * 
	 * @param articleCategory
	 *            文章分类
	 * @param count
	 *            数量
	 * @param cacheRegion
	 *            缓存区域
	 * @return 上级文章分类(缓存)
	 */
	List<ArticleCategory> findParents(ArticleCategory articleCategory, Integer count, String cacheRegion);

	/**
	 * 查找文章分类树
	 * 
	 * @return 文章分类树
	 */
	List<ArticleCategory> findTree();

	/**
	 * 查找下级文章分类
	 * 
	 * @param articleCategory
	 *            文章分类
	 * @return 下级文章分类
	 */
	List<ArticleCategory> findChildren(ArticleCategory articleCategory);

	/**
	 * 查找下级文章分类
	 * 
	 * @param articleCategory
	 *            文章分类
	 * @param count
	 *            数量
	 * @return 下级文章分类
	 */
	List<ArticleCategory> findChildren(ArticleCategory articleCategory, Integer count);

	/**
	 * 查找下级文章分类(缓存)
	 * 
	 * @param articleCategory
	 *            文章分类
	 * @param count
	 *            数量
	 * @param cacheRegion
	 *            缓存区域
	 * @return 下级文章分类(缓存)
	 */
	List<ArticleCategory> findChildren(ArticleCategory articleCategory, Integer count, String cacheRegion);

}