<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("admin.payment.list")} - EASY SHOPPING</title>
<meta name="author" content="EASY SHOPPING Team" />
<meta name="copyright" content="EASY SHOPPING" />
<link href="${base}/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/admin/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/list.js"></script>
<script type="text/javascript">
$().ready(function() {

	[@flash_message /]

});
</script>
</head>
<body>
	<div class="path">
		<a href="${base}/admin/common/index.jhtml">${message("admin.path.index")}</a> &raquo; ${message("admin.payment.list")} <span>(${message("admin.page.total", page.total)})</span>
	</div>
	<form id="listForm" action="list.jhtml" method="get">
		<div class="bar">
			<div class="buttonWrap">
				<a href="javascript:;" id="deleteButton" class="iconButton disabled">
					<span class="deleteIcon">&nbsp;</span>${message("admin.common.delete")}
				</a>
				<a href="javascript:;" id="refreshButton" class="iconButton">
					<span class="refreshIcon">&nbsp;</span>${message("admin.common.refresh")}
				</a>
				<div class="menuWrap">
					<a href="javascript:;" id="pageSizeSelect" class="button">
						${message("admin.page.pageSize")}<span class="arrow">&nbsp;</span>
					</a>
					<div class="popupMenu">
						<ul id="pageSizeOption">
							<li>
								<a href="javascript:;"[#if page.pageSize == 10] class="current"[/#if] val="10">10</a>
							</li>
							<li>
								<a href="javascript:;"[#if page.pageSize == 20] class="current"[/#if] val="20">20</a>
							</li>
							<li>
								<a href="javascript:;"[#if page.pageSize == 50] class="current"[/#if] val="50">50</a>
							</li>
							<li>
								<a href="javascript:;"[#if page.pageSize == 100] class="current"[/#if] val="100">100</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="menuWrap">
				<div class="search">
					<span id="searchPropertySelect" class="arrow">&nbsp;</span>
					<input type="text" id="searchValue" name="searchValue" value="${page.searchValue}" maxlength="200" />
					<button type="submit">&nbsp;</button>
				</div>
				<div class="popupMenu">
					<ul id="searchPropertyOption">
						<li>
							<a href="javascript:;"[#if page.searchProperty == "sn"] class="current"[/#if] val="sn">${message("Payment.sn")}</a>
						</li>
						<li>
							<a href="javascript:;"[#if page.searchProperty == "payer"] class="current"[/#if] val="payer">${message("Payment.payer")}</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<table id="listTable" class="list">
			<tr>
				<th class="check">
					<input type="checkbox" id="selectAll" />
				</th>
				<th>
					<a href="javascript:;" class="sort" name="sn">${message("Payment.sn")}</a>
				</th>
				<th>
					<a href="javascript:;" class="sort" name="type">${message("Payment.type")}</a>
				</th>
				<th>
					<a href="javascript:;" class="sort" name="method">${message("Payment.method")}</a>
				</th>
				<th>
					<a href="javascript:;" class="sort" name="paymentMethod">${message("Payment.paymentMethod")}</a>
				</th>
				<th>
					<a href="javascript:;" class="sort" name="amount">${message("Payment.amount")}</a>
				</th>
				<th>
					<a href="javascript:;" class="sort" name="member">${message("Payment.member")}</a>
				</th>
				<th>
					<a href="javascript:;" class="sort" name="order">${message("Payment.order")}</a>
				</th>
				<th>
					<a href="javascript:;" class="sort" name="status">${message("Payment.status")}</a>
				</th>
				<th>
					<a href="javascript:;" class="sort" name="paymentDate">${message("Payment.paymentDate")}</a>
				</th>
				<th>
					<a href="javascript:;" class="sort" name="createDate">${message("admin.common.createDate")}</a>
				</th>
				<th>
					<span>${message("admin.common.handle")}</span>
				</th>
			</tr>
			[#list page.content as payment]
				<tr>
					<td>
						<input type="checkbox" name="ids" value="${payment.id}" />
					</td>
					<td>
						${payment.sn}
					</td>
					<td>
						${message("Payment.Type." + payment.type)}
					</td>
					<td>
						${message("Payment.Method." + payment.method)}
					</td>
					<td>
						${payment.paymentMethod}
					</td>
					<td>
						${currency(payment.amount, true)}
					</td>
					<td>
						${(payment.member.username)!"-"}
					</td>
					<td>
						${(payment.order.sn)!"-"}
					</td>
					<td>
						${message("Payment.Status." + payment.status)}
					</td>
					<td>
						[#if payment.paymentDate??]
							<span title="${payment.paymentDate?string("yyyy-MM-dd HH:mm:ss")}">${payment.paymentDate}</span>
						[#else]
							-
						[/#if]
					</td>
					<td>
						<span title="${payment.createDate?string("yyyy-MM-dd HH:mm:ss")}">${payment.createDate}</span>
					</td>
					<td>
						<a href="view.jhtml?id=${payment.id}">[${message("admin.common.view")}]</a>
					</td>
				</tr>
			[/#list]
		</table>
		[@pagination pageNumber = page.pageNumber totalPages = page.totalPages]
			[#include "/admin/include/pagination.ftl"]
		[/@pagination]
	</form>
</body>
</html>