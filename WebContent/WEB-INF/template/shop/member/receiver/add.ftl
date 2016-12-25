<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("shop.member.receiver.add")}[#if systemShowPowered] - EASY SHOPPING[/#if]</title>
<meta name="author" content="EASY SHOPPING Team" />
<meta name="copyright" content="EASY SHOPPING" />
<link href="${base}/resources/shop/css/common.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/css/member.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/shop/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/jquery.lSelect.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/common.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $inputForm = $("#inputForm");
	var $areaId = $("#areaId");
	
	[@flash_message /]
	
	// 地区选择
	$areaId.lSelect({
		url: "${base}/common/area.jhtml"
	});
	
	// 表单验证
	$inputForm.validate({
		rules: {
			consignee: "required",
			areaId: "required",
			address: "required",
			zipCode: "required",
			phone: "required"
		}
	});

});
</script>
</head>
<body>
	[#assign current = "receiverList" /]
	[#include "/shop/include/header.ftl" /]
	<div class="container member">
		[#include "/shop/member/include/navigation.ftl" /]
		<div class="span18 last">
			<div class="input">
				<div class="title">${message("shop.member.receiver.add")}</div>
				<form id="inputForm" action="save.jhtml" method="post">
					<table class="input">
						<tr>
							<th>
								${message("Receiver.consignee")}: 
							</th>
							<td>
								<input type="text" name="consignee" class="text" maxlength="200" />
							</td>
						</tr>
						<tr>
							<th>
								${message("Receiver.area")}: 
							</th>
							<td>
								<span class="fieldSet">
									<input type="hidden" id="areaId" name="areaId" />
								</span>
							</td>
						</tr>
						<tr>
							<th>
								${message("Receiver.address")}: 
							</th>
							<td>
								<input type="text" name="address" class="text" maxlength="200" />
							</td>
						</tr>
						<tr>
							<th>
								${message("Receiver.zipCode")}: 
							</th>
							<td>
								<input type="text" name="zipCode" class="text" maxlength="200" />
							</td>
						</tr>
						<tr>
							<th>
								${message("Receiver.phone")}: 
							</th>
							<td>
								<input type="text" name="phone" class="text" maxlength="200" />
							</td>
						</tr>
						<tr>
							<th>
								${message("Receiver.isDefault")}:
							</th>
							<td>
								<input type="checkbox" name="isDefault" value="true" />
								<input type="hidden" name="_isDefault" value="false" />
							</td>
						</tr>
						<tr>
							<th>
								&nbsp;
							</th>
							<td>
								<input type="submit" class="button" value="${message("shop.member.submit")}" />
								<input type="button" class="button" value="${message("shop.member.back")}" onclick="location.href='list.jhtml'" />
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
	[#include "/shop/include/footer.ftl" /]
</body>
</html>