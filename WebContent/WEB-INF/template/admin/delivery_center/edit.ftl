<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("admin.deliveryCenter.edit")} - EASY SHOPPING</title>
<meta name="author" content="EASY SHOPPING Team" />
<meta name="copyright" content="EASY SHOPPING" />
<link href="${base}/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/admin/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/jquery.lSelect.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/input.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $inputForm = $("#inputForm");
	var $areaId = $("#areaId");
	
	[@flash_message /]
	
	// 地区选择
	$areaId.lSelect({
		url: "${base}/admin/common/area.jhtml"
	});
	
	// 表单验证
	$inputForm.validate({
		rules: {
			name: "required",
			contact: "required",
			areaId: "required",
			address: "required"
		}
	});

});
</script>
</head>
<body>
	<div class="path">
		<a href="${base}/admin/common/index.jhtml">${message("admin.path.index")}</a> &raquo; ${message("admin.deliveryCenter.edit")}
	</div>
	<form id="inputForm" action="update.jhtml" method="post">
		<input type="hidden" name="id" value="${deliveryCenter.id}" />
		<table class="input">
			<tr>
				<th>
					<span class="requiredField">*</span>${message("DeliveryCenter.name")}:
				</th>
				<td>
					<input type="text" name="name" class="text" value="${deliveryCenter.name}" maxlength="200" />
				</td>
			</tr>
			<tr>
				<th>
					<span class="requiredField">*</span>${message("DeliveryCenter.contact")}:
				</th>
				<td>
					<input type="text" name="contact" class="text" value="${deliveryCenter.contact}" maxlength="200" />
				</td>
			</tr>
			<tr>
				<th>
					<span class="requiredField">*</span>${message("DeliveryCenter.area")}:
				</th>
				<td>
					<span class="fieldSet">
						<input type="hidden" id="areaId" name="areaId" value="${(deliveryCenter.area.id)!}" treePath="${(deliveryCenter.area.treePath)!}" />
					</span>
				</td>
			</tr>
			<tr>
				<th>
					<span class="requiredField">*</span>${message("DeliveryCenter.address")}:
				</th>
				<td >
					<input type="text" name="address" class="text" value="${deliveryCenter.address}" maxlength="200" />
				</td>
			</tr>
			<tr>
				<th>
					${message("DeliveryCenter.zipCode")}:
				</th>
				<td >
					<input type="text" name="zipCode" class="text" value="${deliveryCenter.zipCode}" maxlength="200" />
				</td>
			</tr>
			<tr>
				<th>
					${message("DeliveryCenter.phone")}:
				</th>
				<td>
					<input type="text" name="phone" class="text" value="${deliveryCenter.phone}" maxlength="200" />
				</td>
			</tr>
			<tr>
				<th>
					${message("DeliveryCenter.mobile")}:
				</th>
				<td>
					<input type="text" name="mobile" class="text" value="${deliveryCenter.mobile}" maxlength="200" />
				</td>
			</tr>
			<tr>
				<th>
					${message("DeliveryCenter.isDefault")}:
				</th>
				<td>
					<input type="checkbox" name="isDefault"[#if deliveryCenter.isDefault] checked="checked"[/#if] />
					<input type="hidden" name="_isDefault" value="false" />
				</td>
			</tr>
			<tr>
				<th>
					${message("DeliveryCenter.memo")}
				</th>
				<td>
					<input type="text" name="memo" class="text" value="${deliveryCenter.memo}" maxlength="200" />
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