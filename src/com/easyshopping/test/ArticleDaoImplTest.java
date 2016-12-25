/*
 * 

 * 
 */
package com.easyshopping.test;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.is;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import com.easyshopping.dao.ArticleCategoryDao;
import com.easyshopping.dao.ArticleDao;
import com.easyshopping.dao.TagDao;
import com.easyshopping.entity.Article;
import com.easyshopping.entity.ArticleCategory;
import com.easyshopping.entity.Tag;
import com.easyshopping.entity.Tag.Type;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

/**
 * Test - 文章
 * 
 * 
 * @version 1.0
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath*:/applicationContext.xml", "classpath*:/applicationContext-mvc.xml" })
@Transactional
public class ArticleDaoImplTest {

	@Resource(name = "articleCategoryDaoImpl")
	private ArticleCategoryDao articleCategoryDao;
	@Resource(name = "tagDaoImpl")
	private TagDao tagDao;
	@Resource(name = "articleDaoImpl")
	private ArticleDao articleDao;

	/** logger. */
	private static final Logger logger = LoggerFactory.getLogger(ArticleDaoImplTest.class);

	/** articleCategoryIds. */
	private static Long[] articleCategoryIds = new Long[100];

	/** articleIds. */
	private static Long[] articleIds = new Long[100];

	/** tagIds. */
	private static Long[] tagIds = new Long[20];

	/**
	 * 准备测试数据
	 */
	@Before
	public void prepareTestData() throws Exception {
		for (int i = 0; i < articleCategoryIds.length; i++) {
			String name = "test" + i;
			ArticleCategory articleCategory = new ArticleCategory();
			if (i < 20) {
				articleCategory.setName(name);
				articleCategory.setOrder(i);
				articleCategoryDao.persist(articleCategory);
			} else {
				articleCategory.setName(name);
				articleCategory.setOrder(i);
				articleCategory.setParent(articleCategoryDao.find(articleCategoryIds[0]));
				articleCategoryDao.persist(articleCategory);
			}
			articleCategoryIds[i] = articleCategory.getId();
		}
		articleCategoryDao.flush();
		articleCategoryDao.clear();

		for (int i = 0; i < tagIds.length; i++) {
			String name = "test" + i;
			Tag tag = new Tag();
			tag.setName(name);
			tag.setOrder(i);
			tag.setType(Type.article);
			tagDao.persist(tag);
			tagIds[i] = tag.getId();
		}
		tagDao.flush();
		tagDao.clear();

		for (int i = 0; i < articleIds.length; i++) {
			String name = "test" + i;
			Article article = new Article();
			article.setTitle(name);
			article.setContent(name);
			article.setIsPublication(true);
			article.setIsTop(false);
			article.setHits(0L);
			if (i < 20) {
				article.setArticleCategory(articleCategoryDao.find(articleCategoryIds[0]));
			} else {
				article.setArticleCategory(articleCategoryDao.find(articleCategoryIds[1]));
			}

			if (i < 20) {
				Set<Tag> tags = new HashSet<Tag>();
				if (i < 10) {
					tags.add(tagDao.find(tagIds[0]));
					tags.add(tagDao.find(tagIds[1]));
				}
				tags.add(tagDao.find(tagIds[2]));
				article.setTags(tags);
			}

			articleDao.persist(article);
			articleIds[i] = article.getId();
		}
		articleDao.flush();
		articleDao.clear();
		logger.info("prepare test data");
	}

	/**
	 * 测试FindList
	 */
	@Test
	public void testFindList() {
		List<Tag> tags = new ArrayList<Tag>();
		tags.add(tagDao.find(tagIds[0]));
		tags.add(tagDao.find(tagIds[2]));
		assertThat(articleDao.findList(null, tags, null, null, null).size(), is(80));
	}

}