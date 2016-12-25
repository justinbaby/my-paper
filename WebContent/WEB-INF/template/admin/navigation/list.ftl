<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("admin.navigation.list")} - EASY SHOPPING</title>
<meta name="author" content="EASY SHOPPING Team" />
<meta name="copyright" content="EASY SHOPPING" />
<link href="${base}/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/admin/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/list.js"></script>
<script type="text/javascript">
$().ready(function() {

	[@flash_message /]

});
</script>
</head>
<body>
	<div class="path">
		<a href="${base}/admin/common/index.jhtml">${message("admin.path.index")}</a> &raquo; ${message("admin.navigation.list")}
	</div>
	<form id="listForm" action="list.jhtml" method="get">
		<div class="bar">
			<a href="add.jhtml" class="iconButton">
				<span class="addIcon">&nbsp;</span>${message("admin.common.add")}
			</a>
			<div class="buttonWrap">
				<a href="javascript:;" id="deleteButton" class="iconButton disabled">
					<span class="deleteIcon">&nbsp;</span>${message("admin.common.delete")}
				</a>
				<a href="javascript:;" id="refreshButton" class="iconButton">
					<span class="refreshIcon">&nbsp;</span>${message("admin.common.refresh")}
				</a>
			</div>
		</div>
		<table id="listTable" class="list">
			<tr>
				<th class="check">
					<input type="checkbox" id="selectAll" />
				</th>
				<th>
					<span>${message("Navigation.name")}</span>
				</th>
				<th>
					<span>${message("Navigation.position")}</span>
				</th>
				<th>
					<span>${message("Navigation.isBlankTarget")}</span>
				</th>
				<th>
					<span>${message("admin.common.order")}</span>
				</th>
				<th>
					<span>${message("admin.common.handle")}</span>
				</th>
			</tr>
			[#list topNavigations as navigation]
				<tr>
					<td>
						<input type="checkbox" name="ids" value="${navigation.id}" />
					</td>
					<td>
						${navigation.name}
					</td>
					<td>
						${message("Navigation.Position." + navigation.position)}
					</td>
					<td>
						${message(navigation.isBlankTarget?string('admin.common.true', 'admin.common.false'))}
					</td>
					<td>
						${navigation.order}
					</td>
					<td>
						<a href="edit.jhtml?id=${navigation.id}">[${message("admin.common.edit")}]</a>
					</td>
				</tr>
			[/#list]
			[#if topNavigations?has_content]
				<tr>
					<td colspan="7">&nbsp;</td>
				</tr>
			[/#if]
			[#list middleNavigations as navigation]
				<tr>
					<td>
						<input type="checkbox" name="ids" value="${navigation.id}" />
					</td>
					<td>
						${navigation.name}
					</td>
					<td>
						${message("Navigation.Position." + navigation.position)}
					</td>
					<td>
						${message(navigation.isBlankTarget?string('admin.common.true', 'admin.common.false'))}
					</td>
					<td>
						${navigation.order}
					</td>
					<td>
						<a href="edit.jhtml?id=${navigation.id}">[${message("admin.common.edit")}]</a>
					</td>
				</tr>
			[/#list]
			[#if middleNavigations?has_content]
				<tr>
					<td colspan="7">&nbsp;</td>
				</tr>
			[/#if]
			[#list bottomNavigations as navigation]
				<tr>
					<td>
						<input type="checkbox" name="ids" value="${navigation.id}" />
					</td>
					<td>
						${navigation.name}
					</td>
					<td>
						${message("Navigation.Position." + navigation.position)}
					</td>
					<td>
						${message(navigation.isBlankTarget?string('admin.common.true', 'admin.common.false'))}
					</td>
					<td>
						${navigation.order}
					</td>
					<td>
						<a href="edit.jhtml?id=${navigation.id}">[${message("admin.common.edit")}]</a>
					</td>
				</tr>
			[/#list]
		</table>
	</form>
</body>
</html>