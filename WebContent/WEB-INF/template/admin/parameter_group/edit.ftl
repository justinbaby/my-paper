<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("admin.parameterGroup.edit")} - EASY SHOPPING</title>
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
	var $parameterTable = $("#parameterTable");
	var $addParameter = $("#addParameter");
	var $deleteParameter = $("a.deleteParameter");
	var parameterIndex = ${parameterGroup.parameters?size};
	
	[@flash_message /]
	
	// 增加参数
	$addParameter.live("click", function() {
		var $this = $(this);
		[@compress single_line = true]
			var trHtml = 
			'<tr class="parameterTr">
				<td>
					&nbsp;
				<\/td>
				<td>
					<input type="text" name="parameters[' + parameterIndex + '].name" class="text parametersName" maxlength="200" \/>
				<\/td>
				<td>
					<input type="text" name="parameters[' + parameterIndex + '].order" class="text parametersOrder" maxlength="9" style="width: 30px;" \/>
				<\/td>
				<td>
					<a href="javascript:;" class="deleteParameter">[${message("admin.common.delete")}]<\/a>
				<\/td>
			<\/tr>';
		[/@compress]
		$parameterTable.append(trHtml);
		parameterIndex ++;
	});
	
	// 删除参数
	$deleteParameter.live("click", function() {
		var $this = $(this);
		if ($parameterTable.find("tr.parameterTr").size() <= 1) {
			$.message("warn", "${message("admin.parameterGroup.deleteAllParameterNotAllowed")}");
		} else {
			$this.closest("tr").remove();
		}
	});
	
	$.validator.addClassRules({
		parametersName: {
			required: true
		},
		parametersOrder: {
			digits: true
		}
	});
	
	// 表单验证
	$inputForm.validate({
		rules: {
			productCategoryId: "required",
			name: "required",
			order: "digits"
		}
	});

});
</script>
</head>
<body>
	<div class="path">
		<a href="${base}/admin/common/index.jhtml">${message("admin.path.index")}</a> &raquo; ${message("admin.parameterGroup.edit")}
	</div>
	<form id="inputForm" action="update.jhtml" method="post">
		<input type="hidden" name="id" value="${parameterGroup.id}" />
		<table id="parameterTable" class="input">
			<tr>
				<th>
					${message("ParameterGroup.productCategory")}:
				</th>
				<td colspan="3">
					<select name="productCategoryId" >
						[#list productCategoryTree as productCategory]
							<option value="${productCategory.id}"[#if productCategory == parameterGroup.productCategory] selected="selected"[/#if]>
								[#if productCategory.grade != 0]
									[#list 1..productCategory.grade as i]
										&nbsp;&nbsp;
									[/#list]
								[/#if]
								${productCategory.name}
							</option>
						[/#list]
					</select>
				</td>
			</tr>
			<tr>
				<th>
					<span class="requiredField">*</span>${message("ParameterGroup.name")}:
				</th>
				<td colspan="3">
					<input type="text" name="name" class="text" value="${parameterGroup.name}" maxlength="200" />
				</td>
			</tr>
			<tr>
				<th>
					${message("admin.common.order")}:
				</th>
				<td colspan="3">
					<input type="text" name="order" class="text" value="${parameterGroup.order}" maxlength="9" />
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<td colspan="3">
					<a href="javascript:;" id="addParameter" class="button">${message("admin.parameterGroup.addParameter")}</a>
				</td>
			</tr>
			<tr class="title">
				<td>
					&nbsp;
				</td>
				<td>
					${message("Parameter.name")}
				</td>
				<td>
					${message("admin.common.order")}
				</td>
				<td>
					${message("admin.common.delete")}
				</td>
			</tr>
			[#list parameterGroup.parameters as parameter]
				<tr class="parameterTr">
					<td>
						<input type="hidden" name="parameters[${parameter_index}].id" class="text parametersName" value="${parameter.id}" />
					</td>
					<td>
						<input type="text" name="parameters[${parameter_index}].name" class="text parametersName" value="${parameter.name}" maxlength="200" />
					</td>
					<td>
						<input type="text" name="parameters[${parameter_index}].order" class="text parametersOrder" value="${parameter.order}" maxlength="9" style="width: 30px;" />
					</td>
					<td>
						<a href="javascript:;" class="deleteParameter">[${message("admin.common.delete")}]</a>
					</td>
				</tr>
			[/#list]
		</table>
		<table class="input">
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