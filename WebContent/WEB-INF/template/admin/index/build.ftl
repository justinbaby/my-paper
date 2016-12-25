<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("admin.index.build")} - EASY SHOPPING</title>
<meta name="author" content="EASY SHOPPING Team" />
<meta name="copyright" content="EASY SHOPPING" />
<link href="${base}/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/admin/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/jquery.tools.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/input.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $inputForm = $("#inputForm");
	var $buildType = $("#buildType");
	var $count = $("#count");
	var $isPurge = $("#isPurge");
	var $statusTr = $("#statusTr");
	var $status = $("#status");
	var $submit = $(":submit");
	
	var first;
	var buildCount;
	var buildTime;
	var buildType;
	var count;
	var isPurge;
	
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
			count = parseInt($count.val());
			isPurge = $isPurge.prop("checked");
			$buildType.prop("disabled", true);
			$count.prop("disabled", true);
			$isPurge.prop("disabled", true);
			$submit.prop("disabled", true);
			$statusTr.show();
			build();
		}
	});
	
	function build() {
		$.ajax({
			url: "build.jhtml",
			type: "POST",
			data: {buildType: buildType, isPurge: isPurge, first: first, count: count},
			dataType: "json",
			cache: false,
			success: function(data) {
				buildCount += data.buildCount;
				buildTime += data.buildTime;
				if (!data.isCompleted) {
					first = data.first;
					$status.text("${message("admin.index.building")} [" + first + " - " + (first + count) + "]");
					build();
				} else {
					$buildType.prop("disabled", false);
					$count.prop("disabled", false);
					$isPurge.prop("disabled", false);
					$submit.prop("disabled", false);
					$statusTr.hide();
					$status.empty();
					var time;
					if (buildTime < 60000) {
						time = (buildTime / 1000).toFixed(2) + "${message("admin.index.second")}";
					} else {
						time = (buildTime / 60000).toFixed(2) + "${message("admin.index.minute")}";
					}
					$.message("success", "${message("admin.index.success")} [${message("admin.index.buildCount")}: " + buildCount + " ${message("admin.index.buildTime")}: " + time + "]");
				}
			}
		});
	}

});
</script>
</head>
<body>
	<div class="path">
		<a href="${base}/admin/common/index.jhtml">${message("admin.path.index")}</a> &raquo; ${message("admin.index.build")}
	</div>
	<form id="inputForm" action="build.jhtml" method="post">
		<table class="input">
			<tr>
				<th>
					${message("admin.index.buildType")}:
				</th>
				<td>
					<select id="buildType" name="buildType">
						[#list buildTypes as buildType]
							<option value="${buildType}">${message("admin.index." + buildType)}</option>
						[/#list]
					</select>
				</td>
			</tr>
			<tr>
				<th>
					<span class="requiredField">*</span>${message("admin.index.count")}:
				</th>
				<td>
					<input type="text" id="count" name="count" class="text" value="50" maxlength="9" />
				</td>
			</tr>
			<tr>
				<th>
					${message("admin.index.isPurge")}:
				</th>
				<td>
					<input type="checkbox" id="isPurge" name="isPurge" value="true" />
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