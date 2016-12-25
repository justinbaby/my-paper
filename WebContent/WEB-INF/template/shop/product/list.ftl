<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
[#if productCategory??]
	[@seo type = "productList"]
		<title>[#if productCategory.seoTitle??]${productCategory.seoTitle}[#elseif seo.title??][@seo.title?interpret /][/#if][#if systemShowPowered] - EASY SHOPPING[/#if]</title>
		<meta name="author" content="EASY SHOPPING Team" />
		<meta name="copyright" content="EASY SHOPPING" />
		[#if productCategory.seoKeywords??]
			<meta name="keywords" content="${productCategory.seoKeywords}" />
		[#elseif seo.keywords??]
			<meta name="keywords" content="[@seo.keywords?interpret /]" />
		[/#if]
		[#if productCategory.seoDescription??]
			<meta name="description" content="${productCategory.seoDescription}" />
		[#elseif seo.description??]
			<meta name="description" content="[@seo.description?interpret /]" />
		[/#if]
	[/@seo]
[#else]
	<title>${message("shop.product.title")}[#if systemShowPowered] - EASY SHOPPING[/#if]</title>
	<meta name="author" content="EASY SHOPPING Team" />
	<meta name="copyright" content="EASY SHOPPING" />
[/#if]
<link href="${base}/resources/shop/css/common.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/css/product.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/shop/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/jquery.lazyload.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/common.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $productForm = $("#productForm");
	var $brandId = $("#brandId");
	var $promotionId = $("#promotionId");
	var $orderType = $("#orderType");
	var $pageNumber = $("#pageNumber");
	var $pageSize = $("#pageSize");
	var $filter = $("#filter dl");
	var $lastFilter = $("#filter dl:eq(2)");
	var $hiddenFilter = $("#filter dl:gt(2)");
	var $moreOption = $("#filter dd.moreOption");
	var $moreFilter = $("#moreFilter a");
	var $tableType = $("#tableType");
	var $listType = $("#listType");
	var $orderSelect = $("#orderSelect");
	var $brand = $("#filter a.brand");
	var $attribute = $("#filter a.attribute");
	var $previousPage = $("#previousPage");
	var $nextPage = $("#nextPage");
	var $size = $("#layout a.size");
	var $tagIds = $("input[name='tagIds']");
	var $sort = $("#sort a");
	var $startPrice = $("#startPrice");
	var $endPrice = $("#endPrice");
	var $result = $("#result");
	var $productImage = $("#result img");
	
	[#if productCategory??]
		$filter.each(function() {
			var $this = $(this);
			var height = $this.height();
			if (height > 30) {
				$this.find("dt").height(height);
				if ($this.find("a.current").size() == 0) {
					$this.height(30);
					$this.find(".moreOption").show();
				}
			}
		});
		
		$moreOption.click(function() {
			var $this = $(this);
			if ($this.hasClass("close")) {
				$this.removeClass("close");
				$this.attr("title", "${message("shop.product.moreOption")}");
				$this.parent().height(30);
			} else {
				$this.addClass("close");
				$this.attr("title", "${message("shop.product.closeOption")}");
				$this.parent().height("auto");
			}
		});
		
		$moreFilter.click(function() {
			var $this = $(this);
			if ($this.hasClass("close")) {
				$this.removeClass("close");
				$this.text("${message("shop.product.moreFilter")}");
				$lastFilter.addClass("last");
				$hiddenFilter.hide();
			} else {
				$this.addClass("close");
				$this.text("${message("shop.product.closeFilter")}");
				$lastFilter.removeClass("last");
				$hiddenFilter.show();
			}
		});
		
		$brand.click(function() {
			var $this = $(this);
			if ($this.hasClass("current")) {
				$brandId.val("");
			} else {
				$brandId.val($this.attr("brandId"));
			}
			$pageNumber.val(1);
			$productForm.submit();
			return false;
		});
		
		$attribute.click(function() {
			var $this = $(this);
			if ($this.hasClass("current")) {
				$this.closest("dl").find("input").prop("disabled", true);
			} else {
				$this.closest("dl").find("input").prop("disabled", false).val($this.text());
			}
			$pageNumber.val(1);
			$productForm.submit();
			return false;
		});
	[/#if]
	
	var layoutType = getCookie("layoutType");
	if (layoutType == "listType") {
		$listType.addClass("currentList");
		$result.removeClass("table").addClass("list");
	} else {
		$tableType.addClass("currentTable");
		$result.removeClass("list").addClass("table");
	}
	
	$tableType.click(function() {
		var $this = $(this);
		if (!$this.hasClass("currentTable")) {
			$this.addClass("currentTable");
			$listType.removeClass("currentList");
			$result.removeClass("list").addClass("table");
			addCookie("layoutType", "tableType", {path: "${base}/"});
		}
	});
	
	$listType.click(function() {
		var $this = $(this);
		if (!$this.hasClass("currentList")) {
			$this.addClass("currentList");
			$tableType.removeClass("currentTable");
			$result.removeClass("table").addClass("list");
			addCookie("layoutType", "listType", {path: "${base}/"});
		}
	});
	
	$size.click(function() {
		var $this = $(this);
		$pageNumber.val(1);
		$pageSize.val($this.attr("pageSize"));
		$productForm.submit();
		return false;
	});
	
	$previousPage.click(function() {
		$pageNumber.val(${page.pageNumber - 1});
		$productForm.submit();
		return false;
	});
	
	$nextPage.click(function() {
		$pageNumber.val(${page.pageNumber + 1});
		$productForm.submit();
		return false;
	});
	
	$orderSelect.mouseover(function() {
		var $this = $(this);
		var offset = $this.offset();
		var $menuWrap = $this.closest("div.orderSelect");
		var $popupMenu = $menuWrap.children("div.popupMenu");
		$popupMenu.css({left: offset.left, top: offset.top + $this.height()}).show();
		$menuWrap.mouseleave(function() {
			$popupMenu.hide();
		});
	});
	
	$tagIds.click(function() {
		$pageNumber.val(1);
		$productForm.submit();
	});
	
	$sort.click(function() {
		var $this = $(this);
		if ($this.hasClass("current")) {
			$orderType.val("");
		} else {
			$orderType.val($this.attr("orderType"));
		}
		$pageNumber.val(1);
		$productForm.submit();
		return false;
	});
	
	$startPrice.add($endPrice).focus(function() {
		$(this).siblings("button").show();
	});
	
	$startPrice.add($endPrice).keypress(function(event) {
		var $this = $(this);
		var key = event.keyCode?event.keyCode:event.which;
		if (key == 13 || (key >= 48 && key <= 57) || (key == 46 && $this.val().indexOf(".") == -1)) {
			return true;
		} else {
			return false;
		}
	});
	
	$productForm.submit(function() {
		if ($brandId.val() == "") {
			$brandId.prop("disabled", true)
		}
		if ($promotionId.val() == "") {
			$promotionId.prop("disabled", true)
		}
		if ($orderType.val() == "" || $orderType.val() == "topDesc") {
			$orderType.prop("disabled", true)
		}
		if ($pageNumber.val() == "" || $pageNumber.val() == "1") {
			$pageNumber.prop("disabled", true)
		}
		if ($pageSize.val() == "" || $pageSize.val() == "20") {
			$pageSize.prop("disabled", true)
		}
		if ($startPrice.val() == "" || !/^\d+(\.\d+)?$/.test($startPrice.val())) {
			$startPrice.prop("disabled", true)
		}
		if ($endPrice.val() == "" || !/^\d+(\.\d+)?$/.test($endPrice.val())) {
			$endPrice.prop("disabled", true)
		}
	});
	
	$productImage.lazyload({
		threshold: 100,
		effect: "fadeIn"
	});
	
	$.pageSkip = function(pageNumber) {
		$pageNumber.val(pageNumber);
		$productForm.submit();
		return false;
	}
	
});
</script>
</head>
<body>
	[#include "/shop/include/header.ftl" /]
	<div class="container productList">
		<div class="span6">
			<div class="hotProductCategory">
				[@product_category_root_list]
					[#list productCategories as category]
						<dl[#if !category_has_next] class="last"[/#if]>
							<dt>
								<a href="${base}${category.path}">${category.name}</a>
							</dt>
							[@product_category_children_list productCategoryId = category.id count = 4]
								[#list productCategories as productCategory]
									<dd>
										<a href="${base}${productCategory.path}">${productCategory.name}</a>
									</dd>
								[/#list]
							[/@product_category_children_list]
						</dl>
					[/#list]
				[/@product_category_root_list]
			</div>
			<div class="hotProduct">
				<div class="title">${message("shop.product.hotProduct")}</div>
				<ul>
					[#if productCategory??]
						[@product_list productCategoryId = productCategory.id count = 10 orderBy="monthSales desc"]
							[#list products as product]
								<li[#if !product_has_next] class="last"[/#if]>
									<a href="${base}${product.path}" title="${product.name}">${abbreviate(product.name, 30)}</a>
									[#if product.scoreCount > 0]
										<div>
											<div>${message("Product.score")}: </div>
											<div class="score${(product.score * 2)?string("0")}"></div>
											<div>${product.score?string("0.0")}</div>
										</div>
									[/#if]
									<div>${message("Product.price")}: <strong>${currency(product.price, true, true)}</strong></div>
									<div>${message("Product.monthSales")}: <em>${product.monthSales}</em></div>
								</li>
							[/#list]
						[/@product_list]
					[#else]
						[@product_list count = 10 orderBy="monthSales desc"]
							[#list products as product]
								<li[#if !product_has_next] class="last"[/#if]>
									<a href="${base}${product.path}" title="${product.name}">${abbreviate(product.name, 30)}</a>
									[#if product.scoreCount > 0]
										<div>
											<div>${message("Product.score")}: </div>
											<div class="score${(product.score * 2)?string("0")}"></div>
											<div>${product.score?string("0.0")}</div>
										</div>
									[/#if]
									<div>${message("Product.price")}: <strong>${currency(product.price, true, true)}</strong></div>
									<div>${message("Product.monthSales")}: <em>${product.monthSales}</em></div>
								</li>
							[/#list]
						[/@product_list]
					[/#if]
				</ul>
			</div>
		</div>
		<div class="span18 last">
			<div class="path">
				<ul>
					<li>
						<a href="${base}/">${message("shop.path.home")}</a>
					</li>
					[#if productCategory??]
						[@product_category_parent_list productCategoryId = productCategory.id]
							[#list productCategories as productCategory]
								<li>
									<a href="${base}${productCategory.path}">${productCategory.name}</a>
								</li>
							[/#list]
						[/@product_category_parent_list]
						<li class="last">${productCategory.name}</li>
					[#else]
						<li class="last">${message("shop.product.title")}</li>
					[/#if]
				</ul>
			</div>
			<form id="productForm" action="${base}${(productCategory.path)!"/product/list.jhtml"}" method="get">
				<input type="hidden" id="brandId" name="brandId" value="${(brand.id)!}" />
				<input type="hidden" id="promotionId" name="promotionId" value="${(promotion.id)!}" />
				<input type="hidden" id="orderType" name="orderType" value="${orderType}" />
				<input type="hidden" id="pageNumber" name="pageNumber" value="${page.pageNumber}" />
				<input type="hidden" id="pageSize" name="pageSize" value="${page.pageSize}" />
				[#if productCategory?? && (productCategory.children?has_content || productCategory.brands?has_content || productCategory.attributes?has_content)]
					<div id="filter" class="filter">
						<div class="title">${message("shop.product.filter")}</div>
						<div class="content clearfix">
							[#assign rows = 0 /]
							[#if productCategory.children?has_content]
								[#assign rows = rows + 1 /]
								<dl[#if !productCategory.brands?has_content && !productCategory.attributes?has_content] class="last"[/#if]>
									<dt>${message("shop.product.productCategory")}:</dt>
									[#list productCategory.children as category]
										<dd>
											<a href="${base}${category.path}">${category.name}</a>
										</dd>
									[/#list]
									<dd class="moreOption" title="${message("shop.product.moreOption")}">&nbsp;</dd>
								</dl>
							[/#if]
							[#if productCategory.brands?has_content]
								[#assign rows = rows + 1 /]
								<dl[#if !productCategory.attributes?has_content] class="last"[/#if]>
									<dt>${message("shop.product.brand")}:</dt>
									[#list productCategory.brands as b]
										<dd>
											<a href="javascript:;"[#if b == brand] class="brand current" title="${message("shop.product.cancel")}"[#else] class="brand"[/#if] brandId="${b.id}">${b.name}</a>	
										</dd>
									[/#list]
									<dd class="moreOption" title="${message("shop.product.moreOption")}">&nbsp;</dd>
								</dl>
							[/#if]
							[#list productCategory.attributes as attribute]
								[#assign rows = rows + 1 /]
								<dl[#if rows == 3 || !attribute_has_next] class="last"[/#if][#if rows > 3 && !attributeValue?keys?seq_contains(attribute)] style="display: none;"[/#if]>
									<dt>
										<input type="hidden" name="attribute_${attribute.id}"[#if attributeValue?keys?seq_contains(attribute)] value="${attributeValue.get(attribute)}"[#else] disabled="disabled"[/#if] />
										<span title="${attribute.name}">${abbreviate(attribute.name, 12)}:</span>
									</dt>
									[#list attribute.options as option]
										<dd>
											<a href="javascript:;"[#if attributeValue.get(attribute) == option] class="attribute current" title="${message("shop.product.cancel")}"[#else] class="attribute"[/#if]>${option}</a>
										</dd>
									[/#list]
									<dd class="moreOption" title="${message("shop.product.moreOption")}">&nbsp;</dd>
								</dl>
							[/#list]
						</div>
						<div id="moreFilter" class="moreFilter">
							[#if rows > 3]
								<a href="javascript:;">${message("shop.product.moreFilter")}</a>
							[#else]
								&nbsp;
							[/#if]
						</div>
					</div>
				[/#if]
				<div class="bar">
					<div id="layout" class="layout">
						<label>${message("shop.product.layout")}:</label>
						<a href="javascript:;" id="tableType" class="tableType">
							<span>&nbsp;</span>
						</a>
						<a href="javascript:;" id="listType" class="listType">
							<span>&nbsp;</span>
						</a>
						<label>${message("shop.product.pageSize")}:</label>
						<a href="javascript:;" class="size[#if page.pageSize == 20] current[/#if]" pageSize="20">
							<span>20</span>
						</a>
						<a href="javascript:;" class="size[#if page.pageSize == 40] current[/#if]" pageSize="40">
							<span>40</span>
						</a>
						<a href="javascript:;" class="size[#if page.pageSize == 80] current[/#if]" pageSize="80">
							<span>80</span>
						</a>
						<span class="page">
							<label>${message("shop.product.totalCount", page.total)} ${page.pageNumber}/[#if page.totalPages > 0]${page.totalPages}[#else]1[/#if]</label>
							[#if page.totalPages > 0]
								[#if page.pageNumber != 1]
									<a href="javascript:;" id="previousPage" class="previousPage">
										<span>${message("shop.product.previousPage")}</span>
									</a>
								[/#if]
								[#if page.pageNumber != page.totalPages]
									<a href="javascript:;" id="nextPage" class="nextPage">
										<span>${message("shop.product.nextPage")}</span>
									</a>
								[/#if]
							[/#if]
						</span>
					</div>
					<div id="sort" class="sort">
						<div id="orderSelect" class="orderSelect">
							[#if orderType??]
								<span>${message("Product.OrderType." + orderType)}</span>
							[#else]
								<span>${message("Product.OrderType." + orderTypes[0])}</span>
							[/#if]
							<div class="popupMenu">
								<ul>
									[#list orderTypes as ot]
										<li>
											<a href="javascript:;"[#if ot == orderType] class="current" title="${message("shop.product.cancel")}"[/#if] orderType="${ot}">${message("Product.OrderType." + ot)}</a>
										</li>
									[/#list]
								</ul>
							</div>
						</div>
						<a href="javascript:;"[#if orderType == "priceAsc"] class="currentAsc current" title="${message("shop.product.cancel")}"[#else] class="asc"[/#if] orderType="priceAsc">${message("shop.product.priceAsc")}</a>
						<a href="javascript:;"[#if orderType == "salesDesc"] class="currentDesc current" title="${message("shop.product.cancel")}"[#else] class="desc"[/#if] orderType="salesDesc">${message("shop.product.salesDesc")}</a>
						<a href="javascript:;"[#if orderType == "scoreDesc"] class="currentDesc current" title="${message("shop.product.cancel")}"[#else] class="desc"[/#if] orderType="scoreDesc">${message("shop.product.scoreDesc")}</a>
						<input type="text" id="startPrice" name="startPrice" class="startPrice" value="${startPrice}" maxlength="16" title="${message("shop.product.startPrice")}" onpaste="return false" />-<input type="text" id="endPrice" name="endPrice" class="endPrice" value="${endPrice}" maxlength="16" title="${message("shop.product.endPrice")}" onpaste="return false" />
						<button type="submit">${message("shop.product.submit")}</button>
					</div>
					<div class="tag">
						<label>${message("shop.product.tag")}:</label>
						[#assign tagList = tags /]
						[@tag_list type = "product"]
							[#list tags as tag]
								<label>
									<input type="checkbox" name="tagIds" value="${tag.id}"[#if tagList?seq_contains(tag)] checked="checked"[/#if] />${tag.name}
								</label>
							[/#list]
						[/@tag_list]
					</div>
				</div>
				<div id="result" class="result table clearfix">
					[#if page.content?has_content]
						<ul>
							[#list page.content?chunk(4) as row]
								[#list row as product]
									<li[#if !row_has_next] class="last"[/#if]>
										<a href="${base}${product.path}">
											<img src="${base}/upload/image/blank.gif" width="170" height="170" data-original="[#if product.thumbnail??]${product.thumbnail}[#else]${setting.defaultThumbnailProductImage}[/#if]" />
											<span class="price">
												${currency(product.price, true)}
												[#if setting.isShowMarketPrice]
													<del>${currency(product.marketPrice, true)}</del>
												[/#if]
											</span>
											<span title="${product.name}">${abbreviate(product.name, 60)}</span>
										</a>
									</li>
								[/#list]
							[/#list]
						</ul>
					[#else]
						${message("shop.product.noListResult")}
					[/#if]
				</div>
				[@pagination pageNumber = page.pageNumber totalPages = page.totalPages pattern = "javascript: $.pageSkip({pageNumber});"]
					[#include "/shop/include/pagination.ftl"]
				[/@pagination]
			</form>
		</div>
	</div>
	[#include "/shop/include/footer.ftl" /]
</body>
</html>