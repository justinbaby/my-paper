<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("shop.member.receiver.list")}[#if systemShowPowered] - EASY SHOPPING[/#if]</title>
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
	[#assign current = "receiverList" /]
	[#include "/shop/include/header.ftl" /]
	<div class="container member">
		[#include "/shop/member/include/navigation.ftl" /]
		<div class="span18 last">
			<div class="list">
				<div class="title">${message("shop.member.receiver.list")}</div>
				<div class="bar">
					<a href="add.jhtml" class="button">${message("shop.member.receiver.add")}</a>
				</div>
				<table id="listTable" class="list">
					<tr>
						<th>
							${message("Receiver.consignee")}
						</th>
						<th>
							${message("Receiver.address")}
						</th>
						<th>
							${message("Receiver.isDefault")}
						</th>
						<th>
							${message("shop.member.handle")}
						</th>
					</tr>
					[#list page.content as receiver]
						<tr[#if !receiver_has_next] class="last"[/#if]>
							<td>
								<input type="hidden" name="id" value="${receiver.id}" />
								${receiver.consignee}
							</td>
							<td>
								<span title="${receiver.areaName}${receiver.address}">${receiver.areaName}${abbreviate(receiver.address, 30, "...")}</span>
							</td>
							<td>
								${receiver.isDefault?string(message("shop.member.true"), message("shop.member.false"))}
							</td>
							<td>
								<a href="edit.jhtml?id=${receiver.id}">[${message("shop.member.handle.edit")}]</a>
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