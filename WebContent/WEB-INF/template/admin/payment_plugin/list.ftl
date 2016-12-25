<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("admin.paymentPlugin.list")} - EASY SHOPPING</title>
<meta name="author" content="EASY SHOPPING Team" />
<meta name="copyright" content="EASY SHOPPING" />
<link href="${base}/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/admin/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/list.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $listTable = $("#listTable");
	var $install = $("#listTable a.install");
	var $uninstall = $("#listTable a.uninstall");
	
	[@flash_message /]

	// 安装
	$install.click(function() {
		var $this = $(this);
		$.dialog({
			type: "warn",
			content: "${message("admin.paymentPlugin.installConfirm")}",
			onOk: function() {
				$.ajax({
					url: $this.attr("href"),
					type: "POST",
					dataType: "json",
					cache: false,
					success: function(message) {
						if (message.type == "success") {
							location.reload(true);
						} else {
							$.message(message);
						}
					}
				});
			}
		});
		return false;
	});
	
	// 卸载
	$uninstall.click(function() {
		var $this = $(this);
		$.dialog({
			type: "warn",
			content: "${message("admin.paymentPlugin.uninstallConfirm")}",
			onOk: function() {
				$.ajax({
					url: $this.attr("href"),
					type: "POST",
					dataType: "json",
					cache: false,
					success: function(message) {
						if (message.type == "success") {
							location.reload(true);
						} else {
							$.message(message);
						}
					}
				});
			}
		});
		return false;
	});

});
</script>
</head>
<body>
	<div class="path">
		<a href="${base}/admin/common/index.jhtml">${message("admin.path.index")}</a> &raquo; ${message("admin.paymentPlugin.list")} <span>(${message("admin.page.total", paymentPlugins?size)})</span>
	</div>
	<form id="listForm" action="list.jhtml" method="get">
		<div class="bar">
			<div class="buttonWrap">
				<a href="javascript:;" id="refreshButton" class="iconButton">
					<span class="refreshIcon">&nbsp;</span>${message("admin.common.refresh")}
				</a>
			</div>
		</div>
		<table id="listTable" class="list">
			<tr>
				<th>
					<span>${message("PaymentPlugin.name")}</span>
				</th>
				<th>
					<span>${message("PaymentPlugin.version")}</span>
				</th>
				<th>
					<span>${message("PaymentPlugin.author")}</span>
				</th>
				<th>
					<span>${message("PaymentPlugin.isEnabled")}</span>
				</th>
				<th>
					<span>${message("admin.common.handle")}</span>
				</th>
			</tr>
			[#list paymentPlugins as paymentPlugin]
				<tr>
					<td>
						[#if paymentPlugin.siteUrl??]
							<a href="${paymentPlugin.siteUrl}" target="_blank">${paymentPlugin.name}</a>
						[#else]
							${paymentPlugin.name}
						[/#if]
					</td>
					<td>
						${paymentPlugin.version!'-'}
					</td>
					<td>
						${paymentPlugin.author!'-'}
					</td>
					<td>
						<span class="${paymentPlugin.isEnabled?string("true", "false")}Icon">&nbsp;</span>
					</td>
					<td>
						[#if paymentPlugin.isInstalled]
							[#if paymentPlugin.settingUrl??]
								<a href="${paymentPlugin.settingUrl}">[${message("admin.paymentPlugin.setting")}]</a>
							[/#if]
							[#if paymentPlugin.uninstallUrl??]
								<a href="${paymentPlugin.uninstallUrl}" class="uninstall">[${message("admin.paymentPlugin.uninstall")}]</a>
							[/#if]
						[#else]
							[#if paymentPlugin.installUrl??]
								<a href="${paymentPlugin.installUrl}" class="install">[${message("admin.paymentPlugin.install")}]</a>
							[/#if]
						[/#if]
					</td>
				</tr>
			[/#list]
		</table>
	</form>
</body>
</html>