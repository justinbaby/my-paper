<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("admin.specification.edit")} - EASY SHOPPING</title>
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
	var specificationValueIndex = ${specification.specificationValues?size};
	
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
						<input type="text" name="specificationValues[' + specificationValueIndex + '].name" class="text specificationValuesName" maxlength="200" \/>
					<\/td>
					<td>
						<span class="fieldSet">
							<input type="text" name="specificationValues[' + specificationValueIndex + '].image" class="text specificationValuesImage" maxlength="200" disabled="disabled" \/>
							<input type="button" class="button browserButton" value="${message("admin.browser.select")}" disabled="disabled" \/>
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
		<a href="${base}/admin/common/index.jhtml">${message("admin.path.index")}</a> &raquo; ${message("admin.specification.edit")}
	</div>
	<form id="inputForm" action="update.jhtml" method="post">
		<input type="hidden" name="id" value="${specification.id}" />
		<table id="specificationTable" class="input">
			<tr class="titleTr">
				<th>
					<span class="requiredField">*</span>${message("Specification.name")}:
				</th>
				<td colspan="4">
					<input type="text" name="name" class="text" value="${specification.name}" maxlength="200" />
				</td>
			</tr>
			<tr>
				<th>
					${message("Specification.type")}:
				</th>
				<td colspan="4">
					<select id="type" name="type">
						[#list types as type]
							<option value="${type}"[#if type == specification.type] selected="selected"[/#if]>${message("Specification.Type." + type)}</option>
						[/#list]
					</select>
				</td>
			</tr>
			<tr>
				<th>
					${message("Specification.memo")}:
				</th>
				<td colspan="4">
					<input type="text" name="memo" class="text" value="${specification.memo}" maxlength="200" />
				</td>
			</tr>
			<tr>
				<th>
					${message("admin.common.order")}:
				</th>
				<td colspan="4">
					<input type="text" name="order" class="text" value="${specification.order}" maxlength="9" />
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
			[#list specification.specificationValues as specificationValue]
				<tr class="specificationValueTr">
					<td>
						<input type="hidden" name="specificationValues[${specificationValue_index}].id" value="${specificationValue.id}" />
					</td>
					<td>
						<input type="text" name="specificationValues[${specificationValue_index}].name" class="text specificationValuesName" value="${specificationValue.name}" maxlength="200" />
					</td>
					<td>
						[#if specification.type == "text"]
							<span class="fieldSet">
								<input type="text" name="specificationValues[${specificationValue_index}].image" class="text specificationValuesImage" value="${specificationValue.image}" maxlength="200" disabled="disabled" />
								<input type="button" class="button browserButton" value="${message("admin.browser.select")}" disabled="disabled" />
							</span>
						[#else]
							<span class="fieldSet">
								<input type="text" name="specificationValues[${specificationValue_index}].image" class="text specificationValuesImage" value="${specificationValue.image}" maxlength="200" />
								<input type="button" class="button browserButton" value="${message("admin.browser.select")}" />
								<img src="${specificationValue.image}" style="width: 20px; height: 20px; padding: 1px; vertical-align: middle; border: 1px solid #b2d3f4;" />
							</span>
						[/#if]
					</td>
					<td>
						<input type="text" name="specificationValues[${specificationValue_index}].order" class="text specificationValuesOrder" value="${specificationValue.order}" maxlength="9" style="width: 30px;" />
					</td>
					<td>
						[#if specificationValue.products?has_content]
							<span title="${message("admin.specification.deleteExistProductNotAllowed", specificationValue.name)}">[${message("admin.common.delete")}]</span>
						[#else]
							<a href="javascript:;" class="deleteSpecificationValue">[${message("admin.common.delete")}]</a>
						[/#if]
					</td>
				</tr>
			[/#list]
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