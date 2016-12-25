<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("admin.message.send")} - EASY SHOPPING</title>
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
	var $isDraft = $("#isDraft");
	var $send = $("#send");
	var $save = $("#save");
	
	// 立即发送
	$send.click(function() {
		$isDraft.val("false");
		$inputForm.submit();
	});
	
	// 保存为草稿
	$save.click(function() {
		$isDraft.val("true");
		$inputForm.submit();
	});
	
	// 表单验证
	$inputForm.validate({
		rules: {
			username: {
				required: true,
				remote: {
					url: "check_username.jhtml",
					cache: false
				}
			},
			title: {
				required: true
			},
			content: {
				required: true,
				maxlength: 1000
			}
		},
		messages: {
			username: {
				remote: "${message("admin.message.memberNotExsit")}"
			}
		}
	});
});
</script>
</head>
<body>
	<div class="path">
		<a href="${base}/admin/common/index.jhtml">${message("admin.path.index")}</a> &raquo; ${message("admin.message.send")}
	</div>
	<form id="inputForm" action="send.jhtml" method="post">
		<input type="hidden" name="draftMessageId" value="${(draftMessage.id)!}" />
		<input type="hidden" id="isDraft" name="isDraft" value="false" />
		<table class="input">
			<tr>
				<th>
					<span class="requiredField">*</span>${message("Message.receiver")}:
				</th>
				<td>
					<input type="text" name="username" class="text" maxlength="${setting.usernameMaxLength}" value="${(draftMessage.receiver.username)!}"/>
				</td>
			</tr>
			<tr>
				<th>
					<span class="requiredField">*</span>${message("Message.title")}:
				</th>
				<td>
					<input type="text" name="title" class="text" maxlength="200" value="${(draftMessage.title)!}" />
				</td>
			</tr>
			<tr>
				<th>
					<span class="requiredField">*</span>${message("Message.content")}:
				</th>
				<td>
					<textarea name="content" class="text">${(draftMessage.content?html)!}</textarea>
				</td>
			</tr>
			<tr>
				<th>
					&nbsp;
				</th>
				<td>
					<input type="button" id="send" class="button" value="${message("admin.message.submit")}" />
					[#if !draftMessage??]
						<input type="button" id="save" class="button" value="${message("admin.message.saveDraft")}" />
					[/#if]
				</td>
			</tr>
		</table>
	</form>
</body>
</html>