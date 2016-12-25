/*
 * 

 * 
 */
package com.easyshopping.dao;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.easyshopping.Filter;
import com.easyshopping.Order;
import com.easyshopping.Page;
import com.easyshopping.Pageable;
import com.easyshopping.entity.Attribute;
import com.easyshopping.entity.Brand;
import com.easyshopping.entity.Goods;
import com.easyshopping.entity.Member;
import com.easyshopping.entity.Product;
import com.easyshopping.entity.Product.OrderType;
import com.easyshopping.entity.ProductCategory;
import com.easyshopping.entity.Promotion;
import com.easyshopping.entity.Tag;

/**
 * Dao - 商品
 * 
 * 
 * @version 1.0
 */
public interface ProductDao extends BaseDao<Product, Long> {

	/**
	 * 判断商品编号是否存在
	 * 
	 * @param sn
	 *            商品编号(忽略大小写)
	 * @return 商品编号是否存在
	 */
	boolean snExists(String sn);

	/**
	 * 根据商品编号查找商品
	 * 
	 * @param sn
	 *            商品编号(忽略大小写)
	 * @return 商品，若不存在则返回null
	 */
	Product findBySn(String sn);

	/**
	 * 通过ID、编号、全称查找商品
	 * 
	 * @param keyword
	 *            关键词
	 * @param isGift
	 *            是否为赠品
	 * @param count
	 *            数量
	 * @return 商品
	 */
	List<Product> search(String keyword, Boolean isGift, Integer count);

	/**
	 * 查找商品
	 * 
	 * @param productCategory
	 *            商品分类
	 * @param brand
	 *            品牌
	 * @param promotion
	 *            促销
	 * @param tags
	 *            标签
	 * @param attributeValue
	 *            属性值
	 * @param startPrice
	 *            最低价格
	 * @param endPrice
	 *            最高价格
	 * @param isMarketable
	 *            是否上架
	 * @param isList
	 *            是否列出
	 * @param isTop
	 *            是否置顶
	 * @param isGift
	 *            是否为赠品
	 * @param isOutOfStock
	 *            是否缺货
	 * @param isStockAlert
	 *            是否库存警告
	 * @param orderType
	 *            排序类型
	 * @param count
	 *            数量
	 * @param filters
	 *            筛选
	 * @param orders
	 *            排序
	 * @return 商品
	 */
	List<Product> findList(ProductCategory productCategory, Brand brand, Promotion promotion, List<Tag> tags, Map<Attribute, String> attributeValue, BigDecimal startPrice, BigDecimal endPrice, Boolean isMarketable, Boolean isList, Boolean isTop, Boolean isGift, Boolean isOutOfStock, Boolean isStockAlert, OrderType orderType, Integer count, List<Filter> filters, List<Order> orders);

	/**
	 * 查找已上架商品
	 * 
	 * @param productCategory
	 *            商品分类
	 * @param beginDate
	 *            起始日期
	 * @param endDate
	 *            结束日期
	 * @param first
	 *            起始记录
	 * @param count
	 *            数量
	 * @return 已上架商品
	 */
	List<Product> findList(ProductCategory productCategory, Date beginDate, Date endDate, Integer first, Integer count);

	/**
	 * 查找商品
	 * 
	 * @param goods
	 *            货品
	 * @param excludes
	 *            排除商品
	 * @return 商品
	 */
	List<Product> findList(Goods goods, Set<Product> excludes);

	/**
	 * 查找商品销售信息
	 * 
	 * @param beginDate
	 *            起始日期
	 * @param endDate
	 *            结束日期
	 * @param count
	 *            数量
	 * @return 商品销售信息
	 */
	List<Object[]> findSalesList(Date beginDate, Date endDate, Integer count);

	/**
	 * 查找商品分页
	 * 
	 * @param productCategory
	 *            商品分类
	 * @param brand
	 *            品牌
	 * @param promotion
	 *            促销
	 * @param tags
	 *            标签
	 * @param attributeValue
	 *            属性值
	 * @param startPrice
	 *            最低价格
	 * @param endPrice
	 *            最高价格
	 * @param isMarketable
	 *            是否上架
	 * @param isList
	 *            是否列出
	 * @param isTop
	 *            是否置顶
	 * @param isGift
	 *            是否为赠品
	 * @param isOutOfStock
	 *            是否缺货
	 * @param isStockAlert
	 *            是否库存警告
	 * @param orderType
	 *            排序类型
	 * @param pageable
	 *            分页信息
	 * @return 商品分页
	 */
	Page<Product> findPage(ProductCategory productCategory, Brand brand, Promotion promotion, List<Tag> tags, Map<Attribute, String> attributeValue, BigDecimal startPrice, BigDecimal endPrice, Boolean isMarketable, Boolean isList, Boolean isTop, Boolean isGift, Boolean isOutOfStock, Boolean isStockAlert, OrderType orderType, Pageable pageable);

	/**
	 * 查找收藏商品分页
	 * 
	 * @param member
	 *            会员
	 * @param pageable
	 *            分页信息
	 * @return 收藏商品分页
	 */
	Page<Product> findPage(Member member, Pageable pageable);

	/**
	 * 查询商品数量
	 * 
	 * @param favoriteMember
	 *            收藏会员
	 * @param isMarketable
	 *            是否上架
	 * @param isList
	 *            是否列出
	 * @param isTop
	 *            是否置顶
	 * @param isGift
	 *            是否为赠品
	 * @param isOutOfStock
	 *            是否缺货
	 * @param isStockAlert
	 *            是否库存警告
	 * @return 商品数量
	 */
	Long count(Member favoriteMember, Boolean isMarketable, Boolean isList, Boolean isTop, Boolean isGift, Boolean isOutOfStock, Boolean isStockAlert);

	/**
	 * 判断会员是否已购买该商品
	 * 
	 * @param member
	 *            会员
	 * @param product
	 *            商品
	 * @return 是否已购买该商品
	 */
	boolean isPurchased(Member member, Product product);

}