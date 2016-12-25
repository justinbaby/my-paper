<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("admin.payment.view")} - EASY SHOPPING</title>
<meta name="author" content="EASY SHOPPING Team" />
<meta name="copyright" content="EASY SHOPPING" />
<link href="${base}/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/admin/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/input.js"></script>
<script type="text/javascript">
$().ready(function() {
	
	[@flash_message /]
	
});
</script>
</head>
<body>
	<div class="path">
		<a href="${base}/admin/common/index.jhtml">${message("admin.path.index")}</a> &raquo; ${message("admin.payment.view")}
	</div>
	<table class="input">
		<tr>
			<th>
				${message("Payment.sn")}:
			</th>
			<td>
				${payment.sn}
			</td>
			<th>
				${message("admin.common.createDate")}:
			</th>
			<td>
				${payment.createDate?string("yyyy-MM-dd HH:mm:ss")}
			</td>
		</tr>
		<tr>
			<th>
				${message("Payment.status")}:
			</th>
			<td>
				${message("Payment.Status." + payment.status)}
			</td>
			<th>
				${message("Payment.paymentDate")}:
			</th>
			<td>
				${(payment.paymentDate?string("yyyy-MM-dd HH:mm:ss"))!"-"}
			</td>
		</tr>
		<tr>
			<th>
				${message("Payment.type")}:
			</th>
			<td>
				${message("Payment.Type." + payment.type)}
			</td>
			<th>
				${message("Payment.method")}:
			</th>
			<td>
				${message("Payment.Method." + payment.method)}
			</td>
		</tr>
		<tr>
			<th>
				${message("Payment.paymentMethod")}:
			</th>
			<td>
				${payment.paymentMethod}
			</td>
			<th>
				${message("Payment.operator")}:
			</th>
			<td>
				${(payment.operator)!message("admin.payment.member")}
			</td>
		</tr>
		<tr>
			<th>
				${message("Payment.bank")}:
			</th>
			<td>
				${(payment.bank)!"-"}
			</td>
			<th>
				${message("Payment.account")}:
			</th>
			<td>
				${(payment.account)!"-"}
			</td>
		</tr>
		<tr>
			<th>
				${message("Payment.payer")}:
			</th>
			<td>
				${(payment.payer)!"-"}
			</td>
			<th>
				${message("Payment.amount")}:
			</th>
			<td>
				${currency(payment.amount, true)}
				[#if payment.fee > 0]
					(${message("admin.payment.withPoundage")}: ${currency(payment.fee, true)})
				[/#if]
			</td>
		</tr>
		<tr>
			<th>
				${message("Payment.member")}:
			</th>
			<td>
				${(payment.member.username)!"-"}
			</td>
			<th>
				${message("Payment.order")}:
			</th>
			<td>
				${(payment.order.sn)!"-"}
			</td>
		</tr>
		<tr>
			<th>
				${message("Payment.memo")}:
			</th>
			<td colspan="3">
				${payment.memo}
			</td>
		</tr>
		<tr>
			<th>
				&nbsp;
			</th>
			<td colspan="3">
				<input type="button" class="button" value="${message("admin.common.back")}" onclick="location.href='list.jhtml'" />
			</td>
		</tr>
	</table>
</body>
</html>