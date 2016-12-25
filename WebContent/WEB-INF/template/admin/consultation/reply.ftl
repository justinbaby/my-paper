<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("admin.consultation.reply")} - EASY SHOPPING</title>
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

	[@flash_message /]
	
	// 表单验证
	$inputForm.validate({
		rules: {
			content: {
				required: true,
				maxlength: 200
			}
		}
	});
	
});
</script>
</head>
<body>
	<div class="path">
		<a href="${base}/admin/common/index.jhtml">${message("admin.path.index")}</a> &raquo; ${message("admin.consultation.reply")}
	</div>
	<form id="inputForm" action="reply.jhtml" method="post">
		<input type="hidden" name="id" value="${consultation.id}" />
		<table class="input">
			<tr>
				<th>
					${message("Consultation.product")}:
				</th>
				<td colspan="2">
					<a href="${base}${consultation.product.path}" target="_blank">${consultation.product.name}</a>
				</td>
			</tr>
			<tr>
				<th>
					${message("Consultation.member")}:
				</th>
				<td colspan="2">
					[#if consultation.member??]
						<a href="../member/view.jhtml?id=${consultation.member.id}">${consultation.member.username}</a>
					[#else]
						${message("admin.consultation.anonymous")}
					[/#if]
				</td>
			</tr>
			<tr>
				<th>
					${message("Consultation.content")}:
				</th>
				<td colspan="2">
					${consultation.content}
				</td>
			</tr>
			[#if consultation.replyConsultations?has_content]
				<tr class="title">
					<td colspan="3">
						&nbsp;
					</td>
				</tr>
				[#list consultation.replyConsultations as replyConsultation]
					<tr>
						<th>
							&nbsp;
						</th>
						<td>
							${replyConsultation.content}
						</td>
						<td width="80">
							<span title="${consultation.createDate?string("yyyy-MM-dd HH:mm:ss")}">${consultation.createDate}</span>
						</td>
					</tr>
				[/#list]
			[/#if]
			<tr>
				<th>
					${message("Consultation.content")}:
				</th>
				<td colspan="2">
					<textarea name="content" class="text"></textarea>
				</td>
			</tr>
			<tr>
				<th>
					&nbsp;
				</th>
				<td colspan="2">
					<input type="submit" class="button" value="${message("admin.common.submit")}" />
					<input type="button" class="button" value="${message("admin.common.back")}" onclick="location.href='list.jhtml'" />
				</td>
			</tr>
		</table>
	</form>
</body>
</html>