<div class="container footer">
	<div class="span30 footer_img">
		[@ad_position id = 2 /]
	</div>
	<div class="span30">
		<ul class="bottomNav">
			[@navigation_list position = "bottom"]
				[#list navigations as navigation]
					<li>
						<a href="${navigation.url}"[#if navigation.isBlankTarget] target="_blank"[/#if]>${navigation.name}</a>
						[#if navigation_has_next]|[/#if]
					</li>
				[/#list]
			[/@navigation_list]
		</ul>
	</div>
	<div class="span30">
		<div class="copyright">${message("shop.footer.copyright", setting.siteName)}
			<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1000523962'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s11.cnzz.com/z_stat.php%3Fid%3D1000523962%26show%3Dpic1' type='text/javascript'%3E%3C/script%3E"));</script>
		</div>
	</div>
	[#include "/shop/include/statistics.ftl" /]
</div>