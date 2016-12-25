<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("admin.specification.add")} - EASY SHOPPING</title>
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
	var $specificationTable = $("#specificationTable");
	var $type = $("#type");
	var $addSpecificationValueButton = $("#addSpecificationValueButton");
	var $deleteSpecificationValue = $("a.deleteSpecificationValue");
	var specificationValueIndex = 1;
	
	[@flash_message /]
	
	// 修改规格类型
	$type.change(function() {
		if ($(this).val() == "text") {
			$("input.specificationValuesImage").val("").prop("disabled", true);
			$("input.browserButton").prop("disabled", true);
		} else {
			$("input.specificationValuesImage").prop("disabled", false);
			$("input.browserButton").prop("disabled", false);
		}
	});
	
	$("input.browserButton").browser();
	
	// 增加规格值
	$addSpecificationValueButton.click(function() {
		if ($type.val() == "text") {
			[@compress single_line = true]
				var trHtml = 
				'<tr class="specificationValueTr">
					<td>
						&nbsp;
					<\/td>
					<td>
						<input type="text" name="specificationValues[' + specificationValueIndex + '].name" maxlength="200" class="text specificationValuesName" \/>
					<\/td>
					<td>
						<span class="fieldSet">
							<input type="text" name="specificationValues[' + specificationValueIndex + '].image" maxlength="200" class="text specificationValuesImage" disabled="disabled" \/>
							<input type="button" class="button browserButton" value="${message("admin.browser.select")}" disabled="disabled" \/>
						<\/span>
					<\/td>
					<td>
						<input type="text" name="specificationValues[' + specificationValueIndex + '].order" maxlength="9" class="text specificationValuesOrder" style="width: 30px;" \/>
					<\/td>
					<td>
						<a href="javascript:;" class="deleteSpecificationValue">[${message("admin.common.delete")}]<\/a>
					<\/td>
				<\/tr>';
			[/@compress]
		} else {
			[@compress single_line = true]
				var trHtml = 
				'<tr class="specificationValueTr">
					<td>
						&nbsp;
					<\/td>
					<td>
						<input type="text" name="specificationValues[' + specificationValueIndex + '].name" class="text specificationValuesName" maxlength="200" \/>
					<\/td>
					<td>
						<span class="fieldSet">
							<input type="text" name="specificationValues[' + specificationValueIndex + '].image" class="text specificationValuesImage" maxlength="200" \/>
							<input type="button" class="button browserButton" value="${message("admin.browser.select")}" \/>
						<\/span>
					<\/td>
					<td>
						<input type="text" name="specificationValues[' + specificationValueIndex + '].order" class="text specificationValuesOrder" maxlength="9" style="width: 30px;" \/>
					<\/td>
					<td>
						<a href="javascript:;" class="deleteSpecificationValue">[${message("admin.common.delete")}]<\/a>
					<\/td>
				<\/tr>';
			[/@compress]
		}
		$specificationTable.append(trHtml).find("input.browserButton:last").browser();
		specificationValueIndex ++;
	});
	
	// 删除规格值
	$deleteSpecificationValue.live("click", function() {
		var $this = $(this);
		if ($specificationTable.find("tr.specificationValueTr").size() <= 1) {
			$.message("warn", "${message("admin.specification.deleteAllSpecificationValueNotAllowed")}");
		} else {
			$this.closest("tr").remove();
		}
	});
	
	$.validator.addClassRules({
		specificationValuesName: {
			required: true
		},
		specificationValuesImage: {
			required: true
		},
		specificationValuesOrder: {
			digits: true
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
		<a href="${base}/admin/common/index.jhtml">${message("admin.path.index")}</a> &raquo; ${message("admin.specification.add")}
	</div>
	<form id="inputForm" action="save.jhtml" method="post">
		<table id="specificationTable" class="input">
			<tr class="titleTr">
				<th>
					<span class="requiredField">*</span>${message("Specification.name")}:
				</th>
				<td colspan="4">
					<input type="text" name="name" class="text" maxlength="200" />
				</td>
			</tr>
			<tr>
				<th>
					${message("Specification.type")}:
				</th>
				<td colspan="4">
					<select id="type" name="type">
						[#list types as type]
							<option value="${type}">${message("Specification.Type." + type)}</option>
						[/#list]
					</select>
				</td>
			</tr>
			<tr>
				<th>
					${message("Specification.memo")}:
				</th>
				<td colspan="4">
					<input type="text" name="memo" class="text" maxlength="200" />
				</td>
			</tr>
			<tr>
				<th>
					${message("admin.common.order")}:
				</th>
				<td colspan="4">
					<input type="text" name="order" class="text" maxlength="9" />
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<td colspan="4">
					<a href="javascript:;" id="addSpecificationValueButton" class="button">${message("admin.specification.addSpecificationValue")}</a>
				</td>
			</tr>
			<tr class="title">
				<td>
					&nbsp;
				</td>
				<td>
					${message("admin.specification.specificationValueName")}
				</td>
				<td>
					${message("admin.specification.specificationValueImage")}
				</td>
				<td>
					${message("admin.specification.specificationValueOrder")}
				</td>
				<td>
					${message("admin.common.delete")}
				</td>
			</tr>
			<tr class="specificationValueTr">
				<td>
					&nbsp;
				</td>
				<td>
					<input type="text" name="specificationValues[0].name" class="text specificationValuesName" maxlength="200" />
				</td>
				<td>
					<span class="fieldSet">
						<input type="text" name="specificationValues[0].image" class="text specificationValuesImage" maxlength="200" disabled="disabled" />
						<input type="button" class="button browserButton" value="${message("admin.browser.select")}" disabled="disabled" />
					</span>
				</td>
				<td>
					<input type="text" name="specificationValues[0].order" class="text specificationValuesOrder" maxlength="9" style="width: 30px;" />
				</td>
				<td>
					<a href="javascript:;" class="deleteSpecificationValue">[${message("admin.common.delete")}]</a>
				</td>
			</tr>
		</table>
		<table class="input">
			<tr>
				<th>
					&nbsp;
				</th>
				<td colspan="4">
					<input type="submit" class="button" value="${message("admin.common.submit")}" />
					<input type="button" class="button" value="${message("admin.common.back")}" onclick="location.href='list.jhtml'" />
				</td>
			</tr>
		</table>
	</form>
</body>
</html>