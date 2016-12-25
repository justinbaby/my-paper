<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("shop.member.profile.edit")}[#if systemShowPowered] - EASY SHOPPING[/#if]</title>
<meta name="author" content="EASY SHOPPING Team" />
<meta name="copyright" content="EASY SHOPPING" />
<link href="${base}/resources/shop/css/common.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/css/member.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/shop/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/jquery.lSelect.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/shop/datePicker/WdatePicker.js"></script>
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
			email: {
				required: true,
				email: true
				[#if !setting.isDuplicateEmail]
					,remote: {
						url: "check_email.jhtml",
						cache: false
					}
				[/#if]
			}
			[#list memberAttributes as memberAttribute]
				[#if memberAttribute.isRequired]
					,memberAttribute_${memberAttribute.id}: {
						required: true
					}
				[/#if]
			[/#list]
		}
		[#if !setting.isDuplicateEmail]
			,messages: {
				email: {
					remote: "${message("shop.validate.exist")}"
				}
			}
		[/#if]
	});

});
</script>
</head>
<body>
	[#assign current = "profileEdit" /]
	[#include "/shop/include/header.ftl" /]
	<div class="container member">
		[#include "/shop/member/include/navigation.ftl" /]
		<div class="span18 last">
			<div class="input">
				<div class="title">${message("shop.member.profile.edit")}</div>
				<form id="inputForm" action="update.jhtml" method="post">
					<table class="input">
						<tr>
							<th>
								<span class="requiredField">*</span>${message("Member.email")}:
							</th>
							<td>
								<input type="text" name="email" class="text" value="${member.email}" maxlength="200" />
							</td>
						</tr>
						[#list memberAttributes as memberAttribute]
							<tr>
								<th>
									[#if memberAttribute.isRequired]<span class="requiredField">*</span>[/#if]${memberAttribute.name}:
								</th>
								<td>
									[#if memberAttribute.type == "name"]
										<input type="text" name="memberAttribute_${memberAttribute.id}" class="text" value="${member.name}" maxlength="200" />
									[#elseif memberAttribute.type == "gender"]
										<span class="fieldSet">
											[#list genders as gender]
												<label>
													<input type="radio" name="memberAttribute_${memberAttribute.id}" value="${gender}"[#if gender == member.gender] checked="checked"[/#if] />${message("Member.Gender." + gender)}
												</label>
											[/#list]
										</span>
									[#elseif memberAttribute.type == "birth"]
										<input type="text" name="memberAttribute_${memberAttribute.id}" class="text" value="${member.birth}" onfocus="WdatePicker();" />
									[#elseif memberAttribute.type == "area"]
										<span class="fieldSet">
											<input type="hidden" id="areaId" name="memberAttribute_${memberAttribute.id}" value="${(member.area.id)!}" treePath="${(member.area.treePath)!}" />
										</span>
									[#elseif memberAttribute.type == "address"]
										<input type="text" name="memberAttribute_${memberAttribute.id}" class="text" value="${member.address}" maxlength="200" />
									[#elseif memberAttribute.type == "zipCode"]
										<input type="text" name="memberAttribute_${memberAttribute.id}" class="text" value="${member.zipCode}" maxlength="200" />
									[#elseif memberAttribute.type == "phone"]
										<input type="text" name="memberAttribute_${memberAttribute.id}" class="text" value="${member.phone}" maxlength="200" />
									[#elseif memberAttribute.type == "mobile"]
										<input type="text" name="memberAttribute_${memberAttribute.id}" class="text" value="${member.mobile}" maxlength="200" />
									[#elseif memberAttribute.type == "text"]
										<input type="text" name="memberAttribute_${memberAttribute.id}" class="text" value="${member.getAttributeValue(memberAttribute)}" maxlength="200" />
									[#elseif memberAttribute.type == "select"]
										<select name="memberAttribute_${memberAttribute.id}">
											<option value="">${message("shop.common.choose")}</option>
											[#list memberAttribute.options as option]
												<option value="${option}"[#if option == member.getAttributeValue(memberAttribute)] selected="selected"[/#if]>
													${option}
												</option>
											[/#list]
										</select>
									[#elseif memberAttribute.type == "checkbox"]
										<span class="fieldSet">
											[#list memberAttribute.options as option]
												<label>
													<input type="checkbox" name="memberAttribute_${memberAttribute.id}" value="${option}"[#if (member.getAttributeValue(memberAttribute)?seq_contains(option))!] checked="checked"[/#if] />${option}
												</label>
											[/#list]
										</span>
									[/#if]
								</td>
							</tr>
						[/#list]
						<tr>
							<th>
								&nbsp;
							</th>
							<td>
								<input type="submit" class="button" value="${message("shop.member.submit")}" />
								<input type="button" class="button" value="${message("shop.member.back")}" onclick="location.href='../index.jhtml'" />
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