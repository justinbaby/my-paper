<?xml version="1.0" encoding="UTF-8"?>
<sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">

	[#list staticPaths as staticPath]
		<sitemap>
			<loc>${setting.siteUrl}${staticPath}</loc>
		</sitemap>
	[/#list]

</sitemapindex>