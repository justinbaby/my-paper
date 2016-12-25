<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("shop.member.message.view")}[#if systemShowPowered] - EASY SHOPPING[/#if]</title>
<meta name="author" content="EASY SHOPPING Team" />
<meta name="copyright" content="EASY SHOPPING" />
<link href="${base}/resources/shop/css/common.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/css/member.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/shop/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/common.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $inputForm = $("#inputForm");
	
	[@flash_message /]
	
	// 表单验证
	$inputForm.validate({
		rules: {
			content: {
				required: true,
				maxlength: 1000
			}
		}
	});

});
</script>
</head>
<body>
	[#assign current = "messageList" /]
	[#include "/shop/include/header.ftl" /]
	<div class="container member">
		[#include "/shop/member/include/navigation.ftl" /]
		<div class="span18 last">
			<div class="message">
				<div class="title">${message("shop.member.message.view")}</div>
				<dl>
					<dt>
						<strong>${memberMessage.title}</strong>
						[#if memberMessage.sender == member]
							<span>${message("Message.receiver")}: [#if memberMessage.receiver??]${memberMessage.receiver.username}[#else]${message("shop.member.message.admin")}[/#if]</span>
						[#else]
							<span>${message("Message.sender")}: [#if memberMessage.sender??]${memberMessage.sender.username}[#else]${message("shop.member.message.admin")}[/#if]</span>
						[/#if]
					</dt>
					<dd>
						<div class="[#if memberMessage.sender == member]right[#else]left[/#if]">
							<p>${memberMessage.content}</p>
							<span>[#if memberMessage.sender??][${memberMessage.sender.username}][#else][${message("shop.member.message.admin")}][/#if] ${memberMessage.createDate?string("yyyy-MM-dd HH:mm:ss")}</span>
							<div class="arrow"></div>
						</div>
					</dd>
					[#list memberMessage.replyMessages as replyMessage]
						<dd>
							<div class="[#if replyMessage.sender == member]right[#else]left[/#if]">
								<p>${replyMessage.content}</p>
								<span>[#if replyMessage.sender??][${replyMessage.sender.username}][#else][${message("shop.member.message.admin")}][/#if] ${replyMessage.createDate?string("yyyy-MM-dd HH:mm:ss")}</span>
								<div class="arrow"></div>
							</div>
						</dd>
					[/#list]
				</dl>
			</div>
			<div class="input">
				<div class="title">${message("shop.member.message.reply")}</div>
				<form id="inputForm" action="reply.jhtml" method="post">
					<input type="hidden" name="id" value="${memberMessage.id}" />
					<table class="input">
						<tr>
							<th>
								<span class="requiredField">*</span>${message("Message.content")}:
							</th>
							<td>
								<textarea name="content" class="text"></textarea>
							</td>
						</tr>
						<tr>
							<th>
								&nbsp;
							</th>
							<td>
								<input type="submit" class="button" value="${message("shop.member.message.send")}" />
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