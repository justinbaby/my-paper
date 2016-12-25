<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${product.name} ${message("shop.review.title")}[#if systemShowPowered] - EASY SHOPPING[/#if]</title>
<meta name="author" content="EASY SHOPPING Team" />
<meta name="copyright" content="EASY SHOPPING" />
<link href="${base}/resources/shop/css/common.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/css/product.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/css/review.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/shop/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/jquery.rating.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/common.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $reviewForm = $("#reviewForm");
	var $score = $("input.score");
	var $tips = $("#tips");
	var $content = $("#content");
	var $captcha = $("#captcha");
	var $captchaImage = $("#captchaImage");
	var $submit = $(":submit");
	
	// 评分
	$score.rating({
		callback: function(value, link) {
			$tips.text(message("${message("shop.review.tips")}", value));
		}
	});
	
	// 更换验证码
	$captchaImage.click(function() {
		$captchaImage.attr("src", "${base}/common/captcha.jhtml?captchaId=${captchaId}&timestamp=" + (new Date()).valueOf());
	});
	
	// 表单验证
	$reviewForm.validate({
		rules: {
			content: {
				required: true,
				maxlength: 200
			},
			captcha: "required"
		},
		submitHandler: function(form) {
			$.ajax({
				url: $reviewForm.attr("action"),
				type: "POST",
				data: $reviewForm.serialize(),
				dataType: "json",
				cache: false,
				beforeSend: function() {
					$submit.prop("disabled", true);
				},
				success: function(message) {
					$.message(message);
					if (message.type == "success") {
						setTimeout(function() {
							$submit.prop("disabled", false);
							location.href = "../content/${product.id}.jhtml";
						}, 3000);
					} else {
						$submit.prop("disabled", false);
						[#if setting.captchaTypes?? && setting.captchaTypes?seq_contains("review")]
							$captcha.val("");
							$captchaImage.attr("src", "${base}/common/captcha.jhtml?captchaId=${captchaId}&timestamp=" + (new Date()).valueOf());
						[/#if]
					}
				}
			});
		}
	});

});
</script>
</head>
<body>
	[#include "/shop/include/header.ftl" /]
	<div class="container review">
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
					[@product_list count = 6 orderBy="monthSales desc"]
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
				</ul>
			</div>
		</div>
		<div class="span18 last">
			<div class="path">
				<ul>
					<li>
						<a href="${base}/">${message("shop.path.home")}</a>
					</li>
					<li>
						<a href="${base}${product.path}">${abbreviate(product.name, 30)}</a>
					</li>
					<li>${message("shop.review.title")}</li>
				</ul>
			</div>
			<table class="info">
				<tr>
					<th rowspan="3">
						<img src="[#if product.thumbnail??]${product.thumbnail}[#else]${setting.defaultThumbnailProductImage}[/#if]" alt="${product.name}" />
					</th>
					<td>
						<a href="${base}${product.path}">${abbreviate(product.name, 60, "...")}</a>
					</td>
				</tr>
				<tr>
					<td>
						${message("Product.price")}: <strong>${currency(product.price, true, true)}</strong>
					</td>
				</tr>
				<tr>
					<td>
						[#if product.scoreCount > 0]
							<div>${message("Product.score")}: </div>
							<div class="score${(product.score * 2)?string("0")}"></div>
							<div>${product.score?string("0.0")}</div>
						[#else]
							[#if setting.isShowMarketPrice]
								${message("Product.marketPrice")}:
								<del>${currency(product.marketPrice, true, true)}</del>
							[/#if]
						[/#if]
					</td>
				</tr>
			</table>
			<form id="reviewForm" action="${base}/review/save.jhtml" method="post">
				<input type="hidden" name="id" value="${product.id}" />
				[#if setting.captchaTypes?? && setting.captchaTypes?seq_contains("review")]
					<input type="hidden" name="captchaId" value="${captchaId}" />
				[/#if]
				<div class="add">
					<table>
						<tr>
							<th>
								${message("Review.score")}:
							</th>
							<td>
								<input type="radio" name="score" class="score" value="1" title="${message("shop.review.score1")}" />
								<input type="radio" name="score" class="score" value="2" title="${message("shop.review.score2")}" />
								<input type="radio" name="score" class="score" value="3" title="${message("shop.review.score3")}" />
								<input type="radio" name="score" class="score" value="4" title="${message("shop.review.score4")}" />
								<input type="radio" name="score" class="score" value="5" title="${message("shop.review.score5")}" checked="checked" />
								<strong id="tips" class="tips">${message("shop.review.tips", 5)}</strong>
							</td>
						</tr>
						<tr>
							<th>
								${message("Review.content")}:
							</th>
							<td>
								<textarea id="content" name="content" class="text"></textarea>
							</td>
						</tr>
						[#if setting.captchaTypes?? && setting.captchaTypes?seq_contains("review")]
							<tr>
								<th>
									${message("shop.captcha.name")}:
								</th>
								<td>
									<span class="fieldSet">
										<input type="text" id="captcha" name="captcha" class="text captcha" maxlength="4" autocomplete="off" /><img id="captchaImage" class="captchaImage" src="${base}/common/captcha.jhtml?captchaId=${captchaId}" title="${message("shop.captcha.imageTitle")}" />
									</span>
								</td>
							</tr>
						[/#if]
						<tr>
							<th>
								&nbsp;
							</th>
							<td>
								<input type="submit" class="button" value="${message("shop.review.submit")}" />
							</td>
						</tr>
					</table>
				</div>
			</form>
		</div>
	</div>
	[#include "/shop/include/footer.ftl" /]
</body>
</html>