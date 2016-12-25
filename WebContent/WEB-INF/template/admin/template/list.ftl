<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("admin.template.list")} - EASY SHOPPING</title>
<meta name="author" content="EASY SHOPPING Team" />
<meta name="copyright" content="EASY SHOPPING" />
<link href="${base}/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/admin/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/list.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $listForm = $("#listForm");
	var $type = $("#type");
	var $typeSelect = $("#typeSelect");
	var $typeOption = $("#typeOption a");

	[@flash_message /]
	
	$typeSelect.mouseover(function() {
		var $this = $(this);
		var offset = $this.offset();
		var $menuWrap = $this.closest("div.menuWrap");
		var $popupMenu = $menuWrap.children("div.popupMenu");
		$popupMenu.css({left: offset.left, top: offset.top + $this.height() + 2}).show();
		$menuWrap.mouseleave(function() {
			$popupMenu.hide();
		});
	});
	
	$typeOption.click(function() {
		var $this = $(this);
		$type.val($this.attr("val"));
		$listForm.submit();
		return false;
	});

});
</script>
</head>
<body>
	<div class="path">
		<a href="${base}/admin/common/index.jhtml">${message("admin.path.index")}</a> &raquo; ${message("admin.template.list")}
	</div>
	<form id="listForm" action="list.jhtml" method="get">
		<input type="hidden" id="type" name="type" value="${type}" />
		<div class="bar">
			<div class="buttonWrap">
				<a href="javascript:;" id="refreshButton" class="iconButton">
					<span class="refreshIcon">&nbsp;</span>${message("admin.common.refresh")}
				</a>
				<div class="menuWrap">
					<a href="javascript:;" id="typeSelect" class="button">
						${message("Template.type")}<span class="arrow">&nbsp;</span>
					</a>
					<div class="popupMenu">
						<ul id="typeOption">
							<li>
								<a href="javascript:;"[#if !type??] class="current"[/#if] val="">${message("admin.template.allType")}</a>
							</li>
							[#assign currentType = type]
							[#list types as type]
								<li>
									<a href="javascript:;"[#if type == currentType] class="current"[/#if] val="${type}">${message("Template.Type." + type)}</a>
								</li>
							[/#list]
						</ul>
					</div>
				</div>
			</div>
		</div>
		<table id="listTable" class="list">
			<tr>
				<th>
					<span>${message("Template.name")}</span>
				</th>
				<th>
					<span>${message("Template.type")}</span>
				</th>
				<th>
					<span>${message("Template.templatePath")}</span>
				</th>
				<th>
					<span>${message("Template.description")}</span>
				</th>
				<th>
					<span>${message("admin.common.handle")}</span>
				</th>
			</tr>
			[#list templates as template]
				<tr>
					<td>
						${template.name}
					</td>
					<td>
						${message("Template.Type." + template.type)}
					</td>
					<td>
						${template.templatePath}
					</td>
					<td>
						[#if template.description??]
							<span title="${template.description}">${abbreviate(template.description, 50, "...")}</span>
						[/#if]
					</td>
					<td>
						<a href="edit.jhtml?id=${template.id}">[${message("admin.common.edit")}]</a>
					</td>
				</tr>
			[/#list]
		</table>
	</form>
</body>
</html>