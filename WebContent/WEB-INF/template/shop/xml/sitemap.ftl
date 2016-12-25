<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">

	[#if index == 0]
		<url>
			<loc>${setting.siteUrl}/</loc>
			<changefreq>hourly</changefreq>
			<priority>1</priority>
		</url>
	[/#if]

	[#list articles as article]
		<url>
			<loc>${setting.siteUrl}${article.path}</loc>
			<lastmod>${article.modifyDate?string("yyyy-MM-dd")}</lastmod>
			<changefreq>weekly</changefreq>
			<priority>0.6</priority>
		</url>
	[/#list]
	
	[#list products as product]
		<url>
			<loc>${setting.siteUrl}${product.path}</loc>
			<lastmod>${product.modifyDate?string("yyyy-MM-dd")}</lastmod>
			<changefreq>weekly</changefreq>
			<priority>0.6</priority>
		</url>
	[/#list]
	
	[#list brands as brand]
		<url>
			<loc>${setting.siteUrl}${brand.path}</loc>
			<lastmod>${brand.modifyDate?string("yyyy-MM-dd")}</lastmod>
			<changefreq>weekly</changefreq>
			<priority>0.5</priority>
		</url>
	[/#list]
	
	[#list promotions as promotion]
		<url>
			<loc>${setting.siteUrl}${promotion.path}</loc>
			<lastmod>${promotion.modifyDate?string("yyyy-MM-dd")}</lastmod>
			<changefreq>weekly</changefreq>
			<priority>0.5</priority>
		</url>
	[/#list]

</urlset>