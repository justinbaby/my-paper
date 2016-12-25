<script type="text/javascript">
$().ready(function() {

	var $headerLogin = $("#headerLogin");
	var $headerRegister = $("#headerRegister");
	var $headerUsername = $("#headerUsername");
	var $headerLogout = $("#headerLogout");
	var $productSearchForm = $("#productSearchForm");
	var $keyword = $("#productSearchForm input");
	var defaultKeyword = "${message("shop.header.keyword")}";
	
	var username = getCookie("username");
	if (username != null) {
		$headerUsername.text("${message("shop.header.welcome")}, " + username).show();
		$headerLogout.show();
	} else {
		$headerLogin.show();
		$headerRegister.show();
	}
	
	$keyword.focus(function() {
		if ($keyword.val() == defaultKeyword) {
			$keyword.val("");
		}
	});
	
	$keyword.blur(function() {
		if ($keyword.val() == "") {
			$keyword.val(defaultKeyword);
		}
	});
	
	$productSearchForm.submit(function() {
		if ($.trim($keyword.val()) == "" || $keyword.val() == defaultKeyword) {
			return false;
		}
	});

});
</script>
<div class="fullspan header topFixedDiv">
		<div class="topNav clearfix">
			<ul>
				<li id="headerLogin" class="headerLogin">
					<a href="${base}/login.jhtml">${message("shop.header.login")}</a>|
				</li>
				<li id="headerRegister" class="headerRegister">
					<a href="${base}/register.jhtml">${message("shop.header.register")}</a>|
				</li>
				<li id="headerUsername" class="headerUsername"></li>
				<li id="headerLogout" class="headerLogout">
					<a href="${base}/logout.jhtml">[${message("shop.header.logout")}]</a>|
				</li>
				[@navigation_list position = "top"]
					[#list navigations as navigation]
						<li>
							<a href="${navigation.url}"[#if navigation.isBlankTarget] target="_blank"[/#if]>${navigation.name}</a>
							[#if navigation_has_next]|[/#if]
						</li>
					[/#list]
				[/@navigation_list]
			</ul>
		</div>
</div>
<div class = "qrCodeDiv"><img src="${base}/upload/qrCode.jpg" /></div>
<div class="fullspan header topNav">&nbsp;</div>
<div class="container header">
	<div class="span30">
		[@ad_position id = 1 /]
	</div>
	
	<div class="span6">
		<div class="logo">
			<a href="${base}/">
				<img src="${base}/${setting.logo}" alt="${setting.siteName}" />
			</a>
		</div>
	</div>
	<div class="span24">
		<div class="tagWrap">
			<div class="hotSearch">
				[#if setting.hotSearches?has_content]
					<strong>${message("shop.header.hotSearch")}</strong>:
					[#list setting.hotSearches as hotSearch]
						<a href="${base}/product/search.jhtml?keyword=${hotSearch?url}">${hotSearch}</a>
					[/#list]
				[/#if]
			</div>
		</div>
	</div>
	<div class="search last">	
		<div class="searchBox">
			<form id="productSearchForm" action="${base}/product/search.jhtml" method="get">
				<input name="keyword" class="keyword" value="${productKeyword!message("shop.header.keyword")}" maxlength="30" />
				<button type="submit">${message("shop.header.search")}</button>
			</form>
		</div>
		<div class="cart">
				<a href="${base}/cart/list.jhtml">${message("shop.header.cart")}</a>
		</div>
		[#if setting.phone??]
		[/#if]
		<div class="phone">
			${message("shop.header.phone")}:
			<a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=1198803573&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:1198803573:51" alt="点击这里给我发消息" title="点击这里给我发消息"/></a>
		</div>
		
	</div>
	
</div>
<div class="fullspan header" >
		<ul class="mainNav">
			[@navigation_list position = "middle"]
				[#list navigations as navigation]
					<li[#if navigation.url = url] class="current"[/#if]>
						<a href="${navigation.url}"[#if navigation.isBlankTarget] target="_blank"[/#if]>${navigation.name}</a>
						[#if navigation_has_next]|[/#if]
					</li>
				[/#list]
			[/@navigation_list]
		</ul>
</div>