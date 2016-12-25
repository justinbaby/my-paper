<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("admin.log.view")} - EASY SHOPPING</title>
<meta name="author" content="EASY SHOPPING Team" />
<meta name="copyright" content="EASY SHOPPING" />
<link href="${base}/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/admin/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/input.js"></script>
</head>
<body>
	<div class="path">
		<a href="${base}/admin/common/index.jhtml">${message("admin.path.index")}</a> &raquo; ${message("admin.log.view")}
	</div>
	<table class="input">
		<tr>
			<th>
				${message("Log.operation")}:
			</th>
			<td>
				${log.operation}
			</td>
		</tr>
		<tr>
			<th>
				${message("Log.operator")}:
			</th>
			<td>
				${log.operator}
			</td>
		</tr>
		<tr>
			<th>
				${message("Log.content")}:
			</th>
			<td>
				${log.content!"-"}
			</td>
		</tr>
		<tr>
			<th>
				${message("Log.parameter")}:
			</th>
			<td>
				<textarea class="textarea" style="width: 98%; height: 300px;" readonly="readonly">${log.parameter?html}</textarea>
			</td>
		</tr>
		<tr>
			<th>
				${message("Log.ip")}:
			</th>
			<td>
				${log.ip}
			</td>
		</tr>
		<tr>
			<th>
				${message("admin.common.createDate")}
			</th>
			<td>
				${log.createDate?string("yyyy-MM-dd HH:mm:ss")}
			</td>
		</tr>
		<tr>
			<th>
				&nbsp;
			</th>
			<td>
				<input type="button" class="button" value="${message("admin.common.back")}" onclick="location.href='list.jhtml'" />
			</td>
		</tr>
	</table>
</body>
</html>