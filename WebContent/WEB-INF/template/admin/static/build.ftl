<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("admin.static.build")} - EASY SHOPPING</title>
<meta name="author" content="EASY SHOPPING Team" />
<meta name="copyright" content="EASY SHOPPING" />
<link href="${base}/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/admin/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/jquery.tools.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/input.js"></script>
<script type="text/javascript" src="${base}/resources/admin/datePicker/WdatePicker.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $inputForm = $("#inputForm");
	var $buildType = $("#buildType");
	var $articleCategoryTr = $("#articleCategoryTr");
	var $articleCategoryId = $("#articleCategoryId");
	var $productCategoryTr = $("#productCategoryTr");
	var $productCategoryId = $("#productCategoryId");
	var $beginDateTr = $("#beginDateTr");
	var $beginDate = $("#beginDate");
	var $endDateTr = $("#endDateTr");
	var $endDate = $("#endDate");
	var $count = $("#count");
	var $statusTr = $("#statusTr");
	var $status = $("#status");
	var $submit = $(":submit");
	
	var first;
	var buildCount;
	var buildTime;
	var buildType;
	var articleCategoryId;
	var productCategoryId;
	var beginDate;
	var endDate;
	var count;

	$buildType.change(function() {
		var $this = $(this);
		if ($this.val() == "article") {
			$articleCategoryTr.show();
			$productCategoryTr.hide();
			$beginDateTr.show();
			$endDateTr.show();
		} else if ($this.val() == "product") {
			$articleCategoryTr.hide();
			$productCategoryTr.show();
			$beginDateTr.show();
			$endDateTr.show();
		} else {
			$articleCategoryTr.hide();
			$productCategoryTr.hide();
			$beginDateTr.hide();
			$endDateTr.hide();
		}
	});
	
	// 表单验证
	$inputForm.validate({
		rules: {
			count: {
				required: true,
				integer: true,
				min: 1
			}
		},
		submitHandler: function(form) {
			first = 0;
			buildCount = 0;
			buildTime = 0;
			buildType = $buildType.val();
			articleCategoryId = $articleCategoryId.val();
			productCategoryId = $productCategoryId.val();
			beginDate = $beginDate.val();
			endDate = $endDate.val();
			count = parseInt($count.val());
			$buildType.prop("disabled", true);
			$articleCategoryId.prop("disabled", true);
			$productCategoryId.prop("disabled", true);
			$beginDate.prop("disabled", true);
			$endDate.prop("disabled", true);
			$count.prop("disabled", true);
			$submit.prop("disabled", true);
			$statusTr.show();
			build();
		}
	});
	
	function build() {
		$.ajax({
			url: "build.jhtml",
			type: "POST",
			data: {buildType: buildType, articleCategoryId: articleCategoryId, productCategoryId: productCategoryId, beginDate: beginDate, endDate: endDate, first: first, count: count},
			dataType: "json",
			cache: false,
			success: function(data) {
				buildCount += data.buildCount;
				buildTime += data.buildTime;
				if (!data.isCompleted) {
					if (buildType == "article" || buildType == "product") {
						first = data.first;
						$status.text("${message("admin.static.building")} [" + first + " - " + (first + count) + "]");
					} else {
						$status.text("${message("admin.static.building")}");
					}
					build();
				} else {
					$buildType.prop("disabled", false);
					$articleCategoryId.prop("disabled", false);
					$productCategoryId.prop("disabled", false);
					$beginDate.prop("disabled", false);
					$endDate.prop("disabled", false);
					$count.prop("disabled", false);
					$submit.prop("disabled", false);
					$statusTr.hide();
					$status.empty();
					var time;
					if (buildTime < 60000) {
						time = (buildTime / 1000).toFixed(2) + "${message("admin.static.second")}";
					} else {
						time = (buildTime / 60000).toFixed(2) + "${message("admin.static.minute")}";
					}
					$.message("success", "${message("admin.static.success")} [${message("admin.static.buildCount")}: " + buildCount + " ${message("admin.static.buildTime")}: " + time + "]");
				}
			}
		});
	}

});
</script>
</head>
<body>
	<div class="path">
		<a href="${base}/admin/common/index.jhtml">${message("admin.path.index")}</a> &raquo; ${message("admin.static.build")}
	</div>
	<form id="inputForm" action="build.jhtml" method="post">
		<table class="input">
			<tr>
				<th>
					${message("admin.static.buildType")}:
				</th>
				<td>
					<select id="buildType" name="buildType">
						[#list buildTypes as buildType]
							<option value="${buildType}">${message("admin.static." + buildType)}</option>
						[/#list]
					</select>
				</td>
			</tr>
			<tr id="articleCategoryTr" class="hidden">
				<th>
					${message("Article.articleCategory")}:
				</th>
				<td>
					<select id="articleCategoryId" name="articleCategoryId">
						<option value="">${message("admin.static.emptyOption")}</option>
						[#list articleCategoryTree as articleCategory]
							<option value="${articleCategory.id}">
								[#if articleCategory.grade != 0]
									[#list 1..articleCategory.grade as i]
										&nbsp;&nbsp;
									[/#list]
								[/#if]
								${articleCategory.name}
							</option>
						[/#list]
					</select>
				</td>
			</tr>
			<tr id="productCategoryTr" class="hidden">
				<th>
					${message("Product.productCategory")}:
				</th>
				<td>
					<select id="productCategoryId" name="productCategoryId">
						<option value="">${message("admin.static.emptyOption")}</option>
						[#list productCategoryTree as productCategory]
							<option value="${productCategory.id}">
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
			<tr id="beginDateTr" class="hidden">
				<th>
					${message("admin.static.beginDate")}:
				</th>
				<td>
					<input type="text" id="beginDate" name="beginDate" class="text Wdate" value="${defaultBeginDate?string("yyyy-MM-dd")}" title="${message("admin.static.beginDateTitle")}" onfocus="WdatePicker({maxDate: '#F{$dp.$D(\'endDate\')}'});" />
				</td>
			</tr>
			<tr id="endDateTr" class="hidden">
				<th>
					${message("admin.static.endDate")}:
				</th>
				<td>
					<input type="text" id="endDate" name="endDate" class="text Wdate" value="${defaultEndDate?string("yyyy-MM-dd")}" title="${message("admin.static.endDateTitle")}" onfocus="WdatePicker({minDate: '#F{$dp.$D(\'beginDate\')}'});" />
				</td>
			</tr>
			<tr>
				<th>
					<span class="requiredField">*</span>${message("admin.static.count")}:
				</th>
				<td>
					<input type="text" id="count" name="count" class="text" value="50" maxlength="9" />
				</td>
			</tr>
			<tr id="statusTr" class="hidden">
				<th>
					&nbsp;
				</th>
				<td>
					<span class="loadingBar">&nbsp;</span>
					<div id="status"></div>
				</td>
			</tr>
			<tr>
				<th>
					&nbsp;
				</th>
				<td>
					<input type="submit" class="button" value="${message("admin.common.submit")}" />
					<input type="button" class="button" value="${message("admin.common.back")}" onclick="location.href='../common/index.jhtml'" />
				</td>
			</tr>
		</table>
	</form>
</body>
</html>