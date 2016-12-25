<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("admin.role.edit")} - EASY SHOPPING</title>
<meta name="author" content="EASY SHOPPING Team" />
<meta name="copyright" content="EASY SHOPPING" />
<link href="${base}/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/admin/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/input.js"></script>
<style type="text/css">
.authorities label {
	min-width: 120px;
	_width: 120px;
	display: block;
	float: left;
	padding-right: 4px;
	_white-space: nowrap;
}
</style>
<script type="text/javascript">
$().ready(function() {

	var $inputForm = $("#inputForm");
	var $selectAll = $("#inputForm .selectAll");
	
	[@flash_message /]
	
	$selectAll.click(function() {
		var $this = $(this);
		var $thisCheckbox = $this.closest("tr").find(":checkbox");
		if ($thisCheckbox.filter(":checked").size() > 0) {
			$thisCheckbox.prop("checked", false);
		} else {
			$thisCheckbox.prop("checked", true);
		}
		return false;
	});
	
	// 表单验证
	$inputForm.validate({
		rules: {
			name: "required",
			authorities: "required"
		}
	});
	
});
</script>
</head>
<body>
	<div class="path">
		<a href="${base}/admin/common/index.jhtml">${message("admin.path.index")}</a> &raquo; ${message("admin.role.edit")}
	</div>
	<form id="inputForm" action="update.jhtml" method="post">
		<input type="hidden" name="id" value="${role.id}" />
		<table class="input">
			<tr>
				<th>
					<span class="requiredField">*</span>${message("Role.name")}:
				</th>
				<td>
					<input type="text" name="name" class="text" value="${role.name}" maxlength="200" />
				</td>
			</tr>
			<tr>
				<th>
					${message("Role.description")}:
				</th>
				<td>
					<input type="text" name="description" class="text" value="${role.description}" maxlength="200" />
				</td>
			</tr>
			<tr>
				<td colspan="2">
					&nbsp;
				</td>
			</tr>
			<tr class="authorities">
				<th>
					<a href="javascript:;" class="selectAll" title="${message("admin.role.selectAll")}">${message("admin.role.productGroup")}</a>
				</th>
				<td>
					<span class="fieldSet">
						<label>
							<input type="checkbox" name="authorities" value="admin:product"[#if role.authorities?seq_contains("admin:product")] checked="checked"[/#if] />${message("admin.role.product")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:productCategory"[#if role.authorities?seq_contains("admin:productCategory")] checked="checked"[/#if] />${message("admin.role.productCategory")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:parameterGroup"[#if role.authorities?seq_contains("admin:parameterGroup")] checked="checked"[/#if] />${message("admin.role.parameterGroup")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:attribute"[#if role.authorities?seq_contains("admin:attribute")] checked="checked"[/#if] />${message("admin.role.attribute")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:specification"[#if role.authorities?seq_contains("admin:specification")] checked="checked"[/#if] />${message("admin.role.specification")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:brand"[#if role.authorities?seq_contains("admin:brand")] checked="checked"[/#if] />${message("admin.role.brand")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:productNotify"[#if role.authorities?seq_contains("admin:productNotify")] checked="checked"[/#if] />${message("admin.role.productNotify")}
						</label>
					</span>
				</td>
			</tr>
			<tr class="authorities">
				<th>
					<a href="javascript:;" class="selectAll" title="${message("admin.role.selectAll")}">${message("admin.role.orderGroup")}</a>
				</th>
				<td>
					<span class="fieldSet">
						<label>
							<input type="checkbox" name="authorities" value="admin:order"[#if role.authorities?seq_contains("admin:order")] checked="checked"[/#if] />${message("admin.role.order")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:print"[#if role.authorities?seq_contains("admin:print")] checked="checked"[/#if] />${message("admin.role.print")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:payment"[#if role.authorities?seq_contains("admin:payment")] checked="checked"[/#if] />${message("admin.role.payment")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:refunds"[#if role.authorities?seq_contains("admin:refunds")] checked="checked"[/#if] />${message("admin.role.refunds")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:shipping"[#if role.authorities?seq_contains("admin:shipping")] checked="checked"[/#if] />${message("admin.role.shipping")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:returns"[#if role.authorities?seq_contains("admin:returns")] checked="checked"[/#if] />${message("admin.role.returns")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:deliveryCenter"[#if role.authorities?seq_contains("admin:deliveryCenter")] checked="checked"[/#if] />${message("admin.role.deliveryCenter")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:deliveryTemplate"[#if role.authorities?seq_contains("admin:deliveryTemplate")] checked="checked"[/#if] />${message("admin.role.deliveryTemplate")}
						</label>
					</span>
				</td>
			</tr>
			<tr class="authorities">
				<th>
					<a href="javascript:;" class="selectAll" title="${message("admin.role.selectAll")}">${message("admin.role.memberGroup")}</a>
				</th>
				<td>
					<span class="fieldSet">
						<label>
							<input type="checkbox" name="authorities" value="admin:member"[#if role.authorities?seq_contains("admin:member")] checked="checked"[/#if] />${message("admin.role.member")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:memberRank"[#if role.authorities?seq_contains("admin:memberRank")] checked="checked"[/#if] />${message("admin.role.memberRank")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:memberAttribute"[#if role.authorities?seq_contains("admin:memberAttribute")] checked="checked"[/#if] />${message("admin.role.memberAttribute")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:review"[#if role.authorities?seq_contains("admin:review")] checked="checked"[/#if] />${message("admin.role.review")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:consultation"[#if role.authorities?seq_contains("admin:consultation")] checked="checked"[/#if] />${message("admin.role.consultation")}
						</label>
					</span>
				</td>
			</tr>
			<tr class="authorities">
				<th>
					<a href="javascript:;" class="selectAll" title="${message("admin.role.selectAll")}">${message("admin.role.contentGroup")}</a>
				</th>
				<td>
					<span class="fieldSet">
						<label>
							<input type="checkbox" name="authorities" value="admin:navigation"[#if role.authorities?seq_contains("admin:navigation")] checked="checked"[/#if] />${message("admin.role.navigation")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:article"[#if role.authorities?seq_contains("admin:article")] checked="checked"[/#if] />${message("admin.role.article")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:articleCategory"[#if role.authorities?seq_contains("admin:articleCategory")] checked="checked"[/#if] />${message("admin.role.articleCategory")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:tag"[#if role.authorities?seq_contains("admin:tag")] checked="checked"[/#if] />${message("admin.role.tag")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:friendLink"[#if role.authorities?seq_contains("admin:friendLink")] checked="checked"[/#if] />${message("admin.role.friendLink")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:adPosition"[#if role.authorities?seq_contains("admin:adPosition")] checked="checked"[/#if] />${message("admin.role.adPosition")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:ad"[#if role.authorities?seq_contains("admin:ad")] checked="checked"[/#if] />${message("admin.role.ad")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:template"[#if role.authorities?seq_contains("admin:template")] checked="checked"[/#if] />${message("admin.role.template")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:cache"[#if role.authorities?seq_contains("admin:cache")] checked="checked"[/#if] />${message("admin.role.cache")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:static"[#if role.authorities?seq_contains("admin:static")] checked="checked"[/#if] />${message("admin.role.static")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:index"[#if role.authorities?seq_contains("admin:index")] checked="checked"[/#if] />${message("admin.role.index")}
						</label>
					</span>
				</td>
			</tr>
			<tr class="authorities">
				<th>
					<a href="javascript:;" class="selectAll" title="${message("admin.role.selectAll")}">${message("admin.role.marketingGroup")}</a>
				</th>
				<td>
					<span class="fieldSet">
						<label>
							<input type="checkbox" name="authorities" value="admin:promotion"[#if role.authorities?seq_contains("admin:promotion")] checked="checked"[/#if] />${message("admin.role.promotion")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:coupon"[#if role.authorities?seq_contains("admin:coupon")] checked="checked"[/#if] />${message("admin.role.coupon")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:seo"[#if role.authorities?seq_contains("admin:seo")] checked="checked"[/#if] />${message("admin.role.seo")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:sitemap"[#if role.authorities?seq_contains("admin:sitemap")] checked="checked"[/#if] />${message("admin.role.sitemap")}
						</label>
					</span>
				</td>
			</tr>
			<tr class="authorities">
				<th>
					<a href="javascript:;" class="selectAll" title="${message("admin.role.selectAll")}">${message("admin.role.statisticsGroup")}</a>
				</th>
				<td>
					<span class="fieldSet">
						<label>
							<input type="checkbox" name="authorities" value="admin:statistics"[#if role.authorities?seq_contains("admin:statistics")] checked="checked"[/#if] />${message("admin.role.statistics")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:sales"[#if role.authorities?seq_contains("admin:sales")] checked="checked"[/#if] />${message("admin.role.sales")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:salesRanking"[#if role.authorities?seq_contains("admin:salesRanking")] checked="checked"[/#if] />${message("admin.role.salesRanking")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:purchaseRanking"[#if role.authorities?seq_contains("admin:purchaseRanking")] checked="checked"[/#if] />${message("admin.role.purchaseRanking")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:deposit"[#if role.authorities?seq_contains("admin:deposit")] checked="checked"[/#if] />${message("admin.role.deposit")}
						</label>
					</span>
				</td>
			</tr>
			<tr class="authorities">
				<th>
					<a href="javascript:;" class="selectAll" title="${message("admin.role.selectAll")}">${message("admin.role.systemGroup")}</a>
				</th>
				<td>
					<span class="fieldSet">
						<label>
							<input type="checkbox" name="authorities" value="admin:setting"[#if role.authorities?seq_contains("admin:setting")] checked="checked"[/#if] />${message("admin.role.setting")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:area"[#if role.authorities?seq_contains("admin:area")] checked="checked"[/#if] />${message("admin.role.area")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:paymentMethod"[#if role.authorities?seq_contains("admin:paymentMethod")] checked="checked"[/#if] />${message("admin.role.paymentMethod")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:shippingMethod"[#if role.authorities?seq_contains("admin:shippingMethod")] checked="checked"[/#if] />${message("admin.role.shippingMethod")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:deliveryCorp"[#if role.authorities?seq_contains("admin:deliveryCorp")] checked="checked"[/#if] />${message("admin.role.deliveryCorp")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:paymentPlugin"[#if role.authorities?seq_contains("admin:paymentPlugin")] checked="checked"[/#if] />${message("admin.role.paymentPlugin")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:storagePlugin"[#if role.authorities?seq_contains("admin:storagePlugin")] checked="checked"[/#if] />${message("admin.role.storagePlugin")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:admin"[#if role.authorities?seq_contains("admin:admin")] checked="checked"[/#if] />${message("admin.role.admin")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:role"[#if role.authorities?seq_contains("admin:role")] checked="checked"[/#if] />${message("admin.role.role")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:message"[#if role.authorities?seq_contains("admin:message")] checked="checked"[/#if] />${message("admin.role.message")}
						</label>
						<label>
							<input type="checkbox" name="authorities" value="admin:log"[#if role.authorities?seq_contains("admin:log")] checked="checked"[/#if] />${message("admin.role.log")}
						</label>
					</span>
				</td>
			</tr>
			[#if role.isSystem]
				<tr>
					<th>
						&nbsp;
					</th>
					<td>
						<span class="tips">${message("admin.role.editSystemNotAllowed")}</span>
					</td>
				</tr>
			[/#if]
			<tr>
				<th>
					&nbsp;
				</th>
				<td>
					<input type="submit" class="button" value="${message("admin.common.submit")}"[#if role.isSystem] disabled="disabled"[/#if] />
					<input type="button" class="button" value="${message("admin.common.back")}" onclick="location.href='list.jhtml'" />
				</td>
			</tr>
		</table>
	</form>
</body>
</html>