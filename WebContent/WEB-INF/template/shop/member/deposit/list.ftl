<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("shop.member.deposit.list")}[#if systemShowPowered] - EASY SHOPPING[/#if]</title>
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
	[#assign current = "depositList" /]
	[#include "/shop/include/header.ftl" /]
	<div class="container member">
		[#include "/shop/member/include/navigation.ftl" /]
		<div class="span18 last">
			<div class="list">
				<div class="title">${message("shop.member.deposit.list")}</div>
				<table class="list">
					<tr>
						<th>
							${message("Deposit.type")}
						</th>
						<th>
							${message("Deposit.credit")}
						</th>
						<th>
							${message("Deposit.debit")}
						</th>
						<th>
							${message("Deposit.balance")}
						</th>
						<th>
							${message("shop.common.createDate")}
						</th>
					</tr>
					[#list page.content as deposit]
						<tr[#if !deposit_has_next] class="last"[/#if]>
							<td>
								${message("Deposit.Type." + deposit.type)}
							</td>
							<td>
								${currency(deposit.credit)}
							</td>
							<td>
								${currency(deposit.debit)}
							</td>
							<td>
								${currency(deposit.balance)}
							</td>
							<td>
								<span title="${deposit.createDate?string("yyyy-MM-dd HH:mm:ss")}">${deposit.createDate}</span>
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