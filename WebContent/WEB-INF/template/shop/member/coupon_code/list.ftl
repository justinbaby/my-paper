<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("shop.member.couponCode.list")}[#if systemShowPowered] - EASY SHOPPING[/#if]</title>
<meta name="author" content="EASY SHOPPING Team" />
<meta name="copyright" content="EASY SHOPPING" />
<link href="${base}/resources/shop/css/common.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/css/member.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/shop/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/common.js"></script>
<script type="text/javascript">
$().ready(function() {
	
	[@flash_message /]

});
</script>
</head>
<body>
	[#assign current = "couponCodeList" /]
	[#include "/shop/include/header.ftl" /]
	<div class="container member">
		[#include "/shop/member/include/navigation.ftl" /]
		<div class="span18 last">
			<div class="list">
				<div class="title">${message("shop.member.couponCode.list")}</div>
				<table class="list">
					<tr>
						<th>
							${message("shop.member.couponCode.name")}
						</th>
						<th>
							${message("CouponCode.code")}
						</th>
						<th>
							${message("CouponCode.isUsed")}
						</th>
						<th>
							${message("CouponCode.usedDate")}
						</th>
						<th>
							${message("shop.member.couponCode.expire")}
						</th>
					</tr>
					[#list page.content as couponCode]
						<tr[#if !couponCode_has_next] class="last"[/#if]>
							<td>
								${couponCode.coupon.name}
							</td>
							<td>
								${couponCode.code}
							</td>
							<td>
								${couponCode.isUsed?string(message("shop.member.true"), message("shop.member.false"))}
							</td>
							<td>
								[#if couponCode.usedDate??]
									<span title="${couponCode.usedDate?string("yyyy-MM-dd HH:mm:ss")}">${couponCode.usedDate}</span>
								[#else]
									-
								[/#if]
							</td>
							<td>
								[#if couponCode.coupon.endDate??]
									<span title="${couponCode.coupon.endDate?string("yyyy-MM-dd HH:mm:ss")}">${couponCode.coupon.endDate}</span>
								[#else]
									-
								[/#if]
							</td>
						</tr>
					[/#list]
				</table>
				[#if !page.content?has_content]
					<p>${message("shop.member.noResult")}</p>
				[/#if]
			</div>
			[@pagination pageNumber = page.pageNumber totalPages = page.totalPages pattern = "?pageNumber={pageNumber}"]
				[#include "/shop/include/pagination.ftl"]
			[/@pagination]
		</div>
	</div>
	[#include "/shop/include/footer.ftl" /]
</body>
</html>