<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("admin.cache.clear")} - EASY SHOPPING</title>
<meta name="author" content="EASY SHOPPING Team" />
<meta name="copyright" content="EASY SHOPPING" />
<link href="${base}/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/admin/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/input.js"></script>
<script type="text/javascript">
$().ready(function() {
	
	[@flash_message /]
	
});
</script>
</head>
<body>
	<div class="path">
		<a href="${base}/admin/common/index.jhtml">${message("admin.path.index")}</a> &raquo; ${message("admin.cache.clear")}
	</div>
	<form id="inputForm" action="clear.jhtml" method="post">
		<table class="input">
			<tr>
				<th>
					${message("admin.cache.cacheSize")}:
				</th>
				<td>
					${cacheSize}
				</td>
			</tr>
			<tr>
				<th>
					${message("admin.cache.freeMemory")}:
				</th>
				<td>
					[#if maxMemory?? && totalMemory?? && freeMemory??]
						${(maxMemory - totalMemory + freeMemory)?string("0.##")}MB
					[#else]
						-
					[/#if]
				</td>
			</tr>
			<tr>
				<th>
					${message("admin.cache.diskStorePath")}:
				</th>
				<td>
					${diskStorePath}
				</td>
			</tr>
			<tr>
				<th>
					&nbsp;
				</th>
				<td>
					<input type="submit" class="button" value="${message("admin.common.submit")}" />
					<input type="button" class="button" value="${message("admin.common.back")}" onclick="location.href='../common/index.jhtml'" />
				</td>
			</tr>
		</table>
	</form>
</body>
</html>