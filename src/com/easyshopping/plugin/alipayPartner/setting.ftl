<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("admin.plugin.alipayPartner.setting")} - EASY SHOPPING</title>
<meta name="author" content="EASY SHOPPING Team" />
<meta name="copyright" content="EASY SHOPPING" />
<link href="${base}/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/admin/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/input.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $inputForm = $("#inputForm");
	var $browserButton = $("#browserButton");
	
	[@flash_message /]
	
	$browserButton.browser();
	
	// 表单验证
	$inputForm.validate({
		errorClass: "fieldError",
		ignoreTitle: true,
		rules: {
			paymentName: "required",
			partner: "required",
			key: "required",
			fee: {
				required: true,
				min: 0,
				decimal: {
					integer: 12,
					fraction: ${setting.priceScale}
				}
			},
			order: "digits"
		}
	});
	
});
</script>
</head>
<body>
	<div class="path">
		<a href="${base}/admin/common/index.jhtml">${message("admin.path.index")}</a> &raquo; ${message("admin.plugin.alipayPartner.setting")}
	</div>
	<form id="inputForm" action="update.jhtml" method="post">
		<table class="input">
			<tr>
				<th>
					<span class="requiredField">*</span>${message("PaymentPlugin.paymentName")}:
				</th>
				<td>
					<input type="text" name="paymentName" class="text" value="${pluginConfig.attributes['paymentName']}" maxlength="200" />
				</td>
			</tr>
			<tr>
				<th>
					<span class="requiredField">*</span>${message("admin.plugin.alipayPartner.partner")}:
				</th>
				<td>
					<input type="text" name="partner" class="text" value="${pluginConfig.attributes['partner']}" maxlength="200" />
				</td>
			</tr>
			<tr>
				<th>
					<span class="requiredField">*</span>${message("admin.plugin.alipayPartner.key")}:
				</th>
				<td>
					<input type="text" name="key" class="text" value="${pluginConfig.attributes.get("key")}" maxlength="200" />
				</td>
			</tr>
			<tr>
				<th>
					${message("PaymentPlugin.feeType")}:
				</th>
				<td>
					<select name="feeType">
						[#list feeTypes as feeType]
							<option value="${feeType}"[#if feeType == pluginConfig.attributes['feeType']] selected="selected"[/#if]>${message("PaymentPlugin.FeeType." + feeType)}</option>
						[/#list]
					</select>
				</td>
			</tr>
			<tr>
				<th>
					<span class="requiredField">*</span>${message("PaymentPlugin.fee")}:
				</th>
				<td>
					<input type="text" name="fee" class="text" value="${pluginConfig.attributes['fee']}" maxlength="16" />
				</td>
			</tr>
			<tr>
				<th>
					${message("PaymentPlugin.logo")}:
				</th>
				<td>
					<input type="text" name="logo" class="text" value="${pluginConfig.attributes['logo']}" maxlength="200" />
					<input type="button" id="browserButton" class="button" value="${message("admin.browser.select")}" />
					[#if pluginConfig.attributes['logo']??]
						<a href="${pluginConfig.attributes['logo']}" target="_blank">${message("admin.common.view")}</a>
					[/#if]
				</td>
			</tr>
			<tr>
				<th>
					${message("PaymentPlugin.description")}:
				</th>
				<td>
					<textarea name="description" class="text">${pluginConfig.attributes['description']?html}</textarea>
				</td>
			</tr>
			<tr>
				<th>
					${message("admin.common.order")}:
				</th>
				<td>
					<input type="text" name="order" class="text" value="${pluginConfig.order}" maxlength="9" />
				</td>
			</tr>
			<tr>
				<th>
					${message("PaymentPlugin.isEnabled")}:
				</th>
				<td>
					<label>
						<input type="checkbox" name="isEnabled" value="true"[#if pluginConfig.isEnabled] checked[/#if] />
					</label>
				</td>
			</tr>
			<tr>
				<th>
					&nbsp;
				</th>
				<td>
					<input type="submit" class="button" value="${message("admin.common.submit")}" />
					<input type="button" class="button" value="${message("admin.common.back")}" onclick="location.href='../list.jhtml'" />
				</td>
			</tr>
		</table>
	</form>
</body>
</html>