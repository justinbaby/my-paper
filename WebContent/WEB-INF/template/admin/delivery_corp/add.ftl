<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("admin.deliveryCorp.add")} - EASY SHOPPING</title>
<meta name="author" content="EASY SHOPPING Team" />
<meta name="copyright" content="EASY SHOPPING" />
<link href="${base}/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/admin/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/jquery.tools.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/jquery.autocomplete.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/input.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $inputForm = $("#inputForm");
	var $name = $("#name");
	var $url = $("#url");
	var $code = $("#code");
	
	[@flash_message /]
	
	// 物流公司选择
	$.ajax({
		url: "${base}/resources/admin/xml/delivery_corp.xml",
		type: "GET",
		dataType: "xml",
		success: function(xml) {
			var data = $.map($(xml).find("deliveryCorp"), function(item) {
				var $item = $(item);
				return {
					name: $item.attr("name"),
					url: $item.attr("url"),
					code: $item.attr("code")
				}
			});
			
			$name.autocomplete(data, {
				max: 20,
				width: 188,
				scrollHeight: 300,
				matchContains: true,
				formatItem: function(item, i, max) {
					return item.name;
				},
				formatMatch: function(item, i, max) {
					return item.name;
				},
				formatResult: function(item) {
					return item.name;
				}
			}).result(function(event, item, formatted) {
				$url.val(item.url);
				$code.val(item.code);
			});
		}
	});
	
	// 表单验证
	$inputForm.validate({
		rules: {
			name: "required",
			order: "digits"
		}
	});
	
});
</script>
</head>
<body>
	<div class="path">
		<a href="${base}/admin/common/index.jhtml">${message("admin.path.index")}</a> &raquo; ${message("admin.deliveryCorp.add")}
	</div>
	<form id="inputForm" action="save.jhtml" method="post">
		<table class="input">
			<tr>
				<th>
					<span class="requiredField">*</span>${message("DeliveryCorp.name")}:
				</th>
				<td>
					<input type="text" id="name" name="name" class="text" maxlength="200" />
				</td>
			</tr>
			<tr>
				<th>
					${message("DeliveryCorp.url")}:
				</th>
				<td>
					<input type="text" id="url" name="url" class="text" maxlength="200" />
				</td>
			</tr>
			<tr>
				<th>
					${message("DeliveryCorp.code")}:
				</th>
				<td>
					<input type="text" id="code" name="code" class="text" maxlength="200" title="${message("admin.deliveryCorp.codeTitle")}" />
				</td>
			</tr>
			<tr>
				<th>
					${message("admin.common.order")}:
				</th>
				<td>
					<input type="text" name="order" class="text" maxlength="9" />
				</td>
			</tr>
			<tr>
				<th>
					&nbsp;
				</th>
				<td>
					<input type="submit" class="button" value="${message("admin.common.submit")}" />
					<input type="button" class="button" value="${message("admin.common.back")}" onclick="location.href='list.jhtml'" />
				</td>
			</tr>
		</table>
	</form>
</body>
</html>