/*
 * 

 * 
 */
package com.easyshopping.service.impl;

import java.math.BigDecimal;
import java.util.List;

import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.easyshopping.Page;
import com.easyshopping.Pageable;
import com.easyshopping.dao.ArticleDao;
import com.easyshopping.dao.ProductDao;
import com.easyshopping.entity.Article;
import com.easyshopping.entity.Product;
import com.easyshopping.entity.Product.OrderType;
import com.easyshopping.service.SearchService;

import org.apache.commons.lang.StringUtils;
import org.apache.lucene.index.Term;
import org.apache.lucene.queryParser.ParseException;
import org.apache.lucene.queryParser.QueryParser;
import org.apache.lucene.search.BooleanClause.Occur;
import org.apache.lucene.search.BooleanQuery;
import org.apache.lucene.search.FuzzyQuery;
import org.apache.lucene.search.NumericRangeQuery;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.Sort;
import org.apache.lucene.search.SortField;
import org.apache.lucene.search.TermQuery;
import org.apache.lucene.util.Version;
import org.hibernate.search.jpa.FullTextEntityManager;
import org.hibernate.search.jpa.FullTextQuery;
import org.hibernate.search.jpa.Search;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.wltea.analyzer.lucene.IKAnalyzer;

/**
 * Service - 搜索
 * 
 * 
 * @version 1.0
 */
@Service("searchServiceImpl")
@Transactional
public class SearchServiceImpl implements SearchService {

	/** 模糊查询最小相似度 */
	private static final float FUZZY_QUERY_MINIMUM_SIMILARITY = 0.5F;

	@PersistenceContext
	protected EntityManager entityManager;
	@Resource(name = "articleDaoImpl")
	private ArticleDao articleDao;
	@Resource(name = "productDaoImpl")
	private ProductDao productDao;

	public void index() {
		index(Article.class);
		index(Product.class);
	}

	public void index(Class<?> type) {
		FullTextEntityManager fullTextEntityManager = Search.getFullTextEntityManager(entityManager);
		if (type == Article.class) {
			for (int i = 0; i < articleDao.count(); i += 20) {
				List<Article> articles = articleDao.findList(i, 20, null, null);
				for (Article article : articles) {
					fullTextEntityManager.index(article);
				}
				fullTextEntityManager.flushToIndexes();
				fullTextEntityManager.clear();
				articleDao.clear();
			}
		} else if (type == Product.class) {
			for (int i = 0; i < productDao.count(); i += 20) {
				List<Product> products = productDao.findList(i, 20, null, null);
				for (Product product : products) {
					fullTextEntityManager.index(product);
				}
				fullTextEntityManager.flushToIndexes();
				fullTextEntityManager.clear();
				productDao.clear();
			}
		}
	}

	public void index(Article article) {
		if (article != null) {
			FullTextEntityManager fullTextEntityManager = Search.getFullTextEntityManager(entityManager);
			fullTextEntityManager.index(article);
		}
	}

	public void index(Product product) {
		if (product != null) {
			FullTextEntityManager fullTextEntityManager = Search.getFullTextEntityManager(entityManager);
			fullTextEntityManager.index(product);
		}
	}

	public void purge() {
		purge(Article.class);
		purge(Product.class);
	}

	public void purge(Class<?> type) {
		FullTextEntityManager fullTextEntityManager = Search.getFullTextEntityManager(entityManager);
		if (type == Article.class) {
			fullTextEntityManager.purgeAll(Article.class);
		} else if (type == Product.class) {
			fullTextEntityManager.purgeAll(Product.class);
		}
	}

	public void purge(Article article) {
		if (article != null) {
			FullTextEntityManager fullTextEntityManager = Search.getFullTextEntityManager(entityManager);
			fullTextEntityManager.purge(Article.class, article.getId());
		}
	}

	public void purge(Product product) {
		if (product != null) {
			FullTextEntityManager fullTextEntityManager = Search.getFullTextEntityManager(entityManager);
			fullTextEntityManager.purge(Product.class, product.getId());
		}
	}

	@SuppressWarnings("unchecked")
	@Transactional(readOnly = true)
	public Page<Article> search(String keyword, Pageable pageable) {
		if (StringUtils.isEmpty(keyword)) {
			return new Page<Article>();
		}
		if (pageable == null) {
			pageable = new Pageable();
		}
		try {
			String text = QueryParser.escape(keyword);
			QueryParser titleParser = new QueryParser(Version.LUCENE_35, "title", new IKAnalyzer());
			titleParser.setDefaultOperator(QueryParser.AND_OPERATOR);
			Query titleQuery = titleParser.parse(text);
			FuzzyQuery titleFuzzyQuery = new FuzzyQuery(new Term("title", text), FUZZY_QUERY_MINIMUM_SIMILARITY);
			Query contentQuery = new TermQuery(new Term("content", text));
			Query isPublicationQuery = new TermQuery(new Term("isPublication", "true"));
			BooleanQuery textQuery = new BooleanQuery();
			BooleanQuery query = new BooleanQuery();
			textQuery.add(titleQuery, Occur.SHOULD);
			textQuery.add(titleFuzzyQuery, Occur.SHOULD);
			textQuery.add(contentQuery, Occur.SHOULD);
			query.add(isPublicationQuery, Occur.MUST);
			query.add(textQuery, Occur.MUST);
			FullTextEntityManager fullTextEntityManager = Search.getFullTextEntityManager(entityManager);
			FullTextQuery fullTextQuery = fullTextEntityManager.createFullTextQuery(query, Article.class);
			fullTextQuery.setSort(new Sort(new SortField[] { new SortField("isTop", SortField.STRING, true), new SortField(null, SortField.SCORE), new SortField("createDate", SortField.LONG, true) }));
			fullTextQuery.setFirstResult((pageable.getPageNumber() - 1) * pageable.getPageSize());
			fullTextQuery.setMaxResults(pageable.getPageSize());
			return new Page<Article>(fullTextQuery.getResultList(), fullTextQuery.getResultSize(), pageable);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return new Page<Article>();
	}

	@SuppressWarnings("unchecked")
	@Transactional(readOnly = true)
	public Page<Product> search(String keyword, BigDecimal startPrice, BigDecimal endPrice, OrderType orderType, Pageable pageable) {
		if (StringUtils.isEmpty(keyword)) {
			return new Page<Product>();
		}
		if (pageable == null) {
			pageable = new Pageable();
		}
		try {
			String text = QueryParser.escape(keyword);
			TermQuery snQuery = new TermQuery(new Term("sn", text));
			Query keywordQuery = new QueryParser(Version.LUCENE_35, "keyword", new IKAnalyzer()).parse(text);
			QueryParser nameParser = new QueryParser(Version.LUCENE_35, "name", new IKAnalyzer());
			nameParser.setDefaultOperator(QueryParser.AND_OPERATOR);
			Query nameQuery = nameParser.parse(text);
			FuzzyQuery nameFuzzyQuery = new FuzzyQuery(new Term("name", text), FUZZY_QUERY_MINIMUM_SIMILARITY);
			TermQuery introductionQuery = new TermQuery(new Term("introduction", text));
			TermQuery isMarketableQuery = new TermQuery(new Term("isMarketable", "true"));
			TermQuery isListQuery = new TermQuery(new Term("isList", "true"));
			TermQuery isGiftQuery = new TermQuery(new Term("isGift", "false"));
			BooleanQuery textQuery = new BooleanQuery();
			BooleanQuery query = new BooleanQuery();
			textQuery.add(snQuery, Occur.SHOULD);
			textQuery.add(keywordQuery, Occur.SHOULD);
			textQuery.add(nameQuery, Occur.SHOULD);
			textQuery.add(nameFuzzyQuery, Occur.SHOULD);
			textQuery.add(introductionQuery, Occur.SHOULD);
			query.add(isMarketableQuery, Occur.MUST);
			query.add(isListQuery, Occur.MUST);
			query.add(isGiftQuery, Occur.MUST);
			query.add(textQuery, Occur.MUST);
			if (startPrice != null && endPrice != null && startPrice.compareTo(endPrice) > 0) {
				BigDecimal temp = startPrice;
				startPrice = endPrice;
				endPrice = temp;
			}
			if (startPrice != null && startPrice.compareTo(new BigDecimal(0)) >= 0 && endPrice != null && endPrice.compareTo(new BigDecimal(0)) >= 0) {
				NumericRangeQuery<Double> numericRangeQuery = NumericRangeQuery.newDoubleRange("price", startPrice.doubleValue(), endPrice.doubleValue(), true, true);
				query.add(numericRangeQuery, Occur.MUST);
			} else if (startPrice != null && startPrice.compareTo(new BigDecimal(0)) >= 0) {
				NumericRangeQuery<Double> numericRangeQuery = NumericRangeQuery.newDoubleRange("price", startPrice.doubleValue(), null, true, false);
				query.add(numericRangeQuery, Occur.MUST);
			} else if (endPrice != null && endPrice.compareTo(new BigDecimal(0)) >= 0) {
				NumericRangeQuery<Double> numericRangeQuery = NumericRangeQuery.newDoubleRange("price", null, endPrice.doubleValue(), false, true);
				query.add(numericRangeQuery, Occur.MUST);
			}
			FullTextEntityManager fullTextEntityManager = Search.getFullTextEntityManager(entityManager);
			FullTextQuery fullTextQuery = fullTextEntityManager.createFullTextQuery(query, Product.class);
			SortField[] sortFields = null;
			if (orderType == OrderType.priceAsc) {
				sortFields = new SortField[] { new SortField("price", SortField.DOUBLE, false), new SortField("createDate", SortField.LONG, true) };
			} else if (orderType == OrderType.priceDesc) {
				sortFields = new SortField[] { new SortField("price", SortField.DOUBLE, true), new SortField("createDate", SortField.LONG, true) };
			} else if (orderType == OrderType.salesDesc) {
				sortFields = new SortField[] { new SortField("sales", SortField.INT, true), new SortField("createDate", SortField.LONG, true) };
			} else if (orderType == OrderType.scoreDesc) {
				sortFields = new SortField[] { new SortField("score", SortField.INT, true), new SortField("createDate", SortField.LONG, true) };
			} else if (orderType == OrderType.dateDesc) {
				sortFields = new SortField[] { new SortField("createDate", SortField.LONG, true) };
			} else {
				sortFields = new SortField[] { new SortField("isTop", SortField.STRING, true), new SortField(null, SortField.SCORE), new SortField("modifyDate", SortField.LONG, true) };
			}
			fullTextQuery.setSort(new Sort(sortFields));
			fullTextQuery.setFirstResult((pageable.getPageNumber() - 1) * pageable.getPageSize());
			fullTextQuery.setMaxResults(pageable.getPageSize());
			return new Page<Product>(fullTextQuery.getResultList(), fullTextQuery.getResultSize(), pageable);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new Page<Product>();
	}

}