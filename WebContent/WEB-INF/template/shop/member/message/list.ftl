<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("shop.member.message.list")}[#if systemShowPowered] - EASY SHOPPING[/#if]</title>
<meta name="author" content="EASY SHOPPING Team" />
<meta name="copyright" content="EASY SHOPPING" />
<link href="${base}/resources/shop/css/common.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/css/member.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/shop/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/common.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $listTable = $("#listTable");
	var $delete = $("#listTable a.delete");
	var $pageTotal = $("#pageTotal");
	
	[@flash_message /]

	// 删除
	$delete.click(function() {
		if (confirm("${message("shop.dialog.deleteConfirm")}")) {
			var $tr = $(this).closest("tr");
			var id = $tr.find("input[name='id']").val();
			$.ajax({
				url: "delete.jhtml",
				type: "POST",
				data: {id: id},
				dataType: "json",
				cache: false,
				success: function(message) {
					$.message(message);
					if (message.type == "success") {
						var $siblings = $tr.siblings();
						if ($siblings.size() <= 1) {
							$listTable.after('<p>${message("shop.member.noResult")}<\/p>');
						} else {
							$siblings.last().addClass("last");
						}
						$pageTotal.text(parseInt($pageTotal.text()) - 1);
						$tr.remove();
					}
				}
			});
		}
		return false;
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
			<div class="list">
				<div class="title">${message("shop.member.message.list")} <span>(${message("shop.member.message.total", '<span id="pageTotal">' + page.total + '</span>')})</span></div>
				<table id="listTable" class="list">
					<tr>
						<th>
							${message("Message.title")}
						</th>
						<th>
							${message("shop.member.message.opposite")}
						</th>
						<th>
							${message("shop.member.message.new")}
						</th>
						<th>
							${message("shop.common.createDate")}
						</th>
						<th>
							${message("shop.member.handle")}
						</th>
					</tr>
					[#list page.content as memberMessage]
						<tr[#if !memberMessage_has_next] class="last"[/#if]>
							<td>
								<input type="hidden" name="id" value="${memberMessage.id}" />
								<span title="${memberMessage.title}">${abbreviate(memberMessage.title, 30)}</span>
							</td>
							<td>
								[#if memberMessage.receiver == member]
									[#if memberMessage.sender??]${memberMessage.sender.username}[#else]${message("shop.member.message.admin")}[/#if]
								[#else]
									[#if memberMessage.receiver??]${memberMessage.receiver.username}[#else]${message("shop.member.message.admin")}[/#if]
								[/#if]
							</td>
							<td>
								[#if memberMessage.receiver == member]
									[#if memberMessage.receiverRead]-[#else]${message("shop.member.message.new")}[/#if]
								[#else]
									[#if memberMessage.senderRead]-[#else]${message("shop.member.message.new")}[/#if]
								[/#if]
							</td>
							<td>
								<span title="${memberMessage.createDate?string("yyyy-MM-dd HH:mm:ss")}">${memberMessage.createDate}</span>
							</td>
							<td>
								<a href="view.jhtml?id=${memberMessage.id}">[${message("shop.member.handle.view")}]</a>
								<a href="javascript:;" class="delete">[${message("shop.member.handle.delete")}]</a>
							</td>
						</tr>
					[/#list]
				</table>
				[#if !page.content?has_content]
					<p>${message("shop.member.noResult")}</p>
				[/#if]
			</div>
			[@pagination pageNumber = page.pageNumber totalPages = page.totalPages pattern = "?pageNumber={pageNumber}"]
				[#include "/shop/include/pagination.ftl"]
			[/@pagination]
		</div>
	</div>
	[#include "/shop/include/footer.ftl" /]
</body>
</html>