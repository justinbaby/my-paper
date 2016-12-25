<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("admin.promotion.edit")} - EASY SHOPPING</title>
<meta name="author" content="EASY SHOPPING Team" />
<meta name="copyright" content="EASY SHOPPING" />
<link href="${base}/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/admin/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/jquery.tools.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/jquery.autocomplete.js"></script>
<script type="text/javascript" src="${base}/resources/admin/editor/kindeditor.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/input.js"></script>
<script type="text/javascript" src="${base}/resources/admin/datePicker/WdatePicker.js"></script>
<style type="text/css">
.memberRank label, .productCategory label, .brand label, .coupon label {
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
	var $productTable = $("#productTable");
	var $productSelect = $("#productSelect");
	var $deleteProduct = $("a.deleteProduct");
	var $productTitle = $("#productTitle");
	var $giftTable = $("#giftTable");
	var $giftSelect = $("#giftSelect");
	var $deleteGift = $("a.deleteGift");
	var $giftTitle = $("#giftTitle");
	var productIds = [#if promotion.products?has_content][[#list promotion.products as product]${product.id}[#if product_has_next], [/#if][/#list]][#else]new Array()[/#if];
	var giftIds = [#if promotion.giftItems?has_content][[#list promotion.giftItems as giftItem]${giftItem.gift.id}[#if giftItem_has_next], [/#if][/#list]][#else]new Array()[/#if];
	var giftItemIndex = ${promotion.giftItems?size};
	
	[@flash_message /]
	
	// 商品选择
	$productSelect.autocomplete("product_select.jhtml", {
		dataType: "json",
		max: 20,
		width: 600,
		scrollHeight: 300,
		parse: function(data) {
			return $.map(data, function(item) {
				return {
					data: item,
					value: item.fullName
				}
			});
		},
		formatItem: function(item) {
			if ($.inArray(item.id, productIds) < 0) {
				return '<span title="' + item.fullName + '">' + item.fullName.substring(0, 50) + '<\/span>';
			} else {
				return false;
			}
		}
	}).result(function(event, item) {
		[@compress single_line = true]
			var trHtml = 
			'<tr class="productTr">
				<th>
					<input type="hidden" name="productIds" value="' + item.id + '" \/>
					&nbsp;
				<\/th>
				<td>
					<span title="' + item.fullName + '">' + item.fullName.substring(0, 50) + '<\/span>
				<\/td>
				<td>
					<a href="${base}' + item.path + '" target="_blank">[${message("admin.common.view")}]<\/a>
					<a href="javascript:;" class="deleteProduct">[${message("admin.common.delete")}]<\/a>
				<\/td>
			<\/tr>';
		[/@compress]
		$productTitle.show();
		$productTable.append(trHtml);
		productIds.push(item.id);
	});
	
	// 删除商品
	$deleteProduct.live("click", function() {
		var $this = $(this);
		$.dialog({
			type: "warn",
			content: "${message("admin.dialog.deleteConfirm")}",
			onOk: function() {
				var id = parseInt($this.closest("tr").find("input:hidden").val());
				productIds = $.grep(productIds, function(n, i) {
					return n != id;
				});
				$this.closest("tr").remove();
				if ($productTable.find("tr.productTr").size() <= 0) {
					$productTitle.hide();
				}
			}
		});
	});
	
	// 赠品选择
	$giftSelect.autocomplete("gift_select.jhtml", {
		dataType: "json",
		max: 20,
		width: 600,
		scrollHeight: 300,
		parse: function(data) {
			return $.map(data, function(item) {
				return {
					data: item,
					value: item.fullName
				}
			});
		},
		formatItem: function(item) {
			if ($.inArray(item.id, giftIds) < 0) {
				return '<span title="' + item.fullName + '">' + item.fullName.substring(0, 50) + '<\/span>';
			} else {
				return false;
			}
		}
	}).result(function(event, item) {
		[@compress single_line = true]
			var trHtml = 
			'<tr class="giftTr">
				<th>
					<input type="hidden" name="giftItems[' + giftItemIndex + '].gift.id" class="giftId" value="' + item.id + '" \/>&nbsp;
				<\/th>
				<td>
					<span title="' + item.fullName + '">' + item.fullName.substring(0, 50) + '<\/span>
				<\/td>
				<td>
					<input type="text" name="giftItems[' + giftItemIndex + '].quantity" class="text giftItemQuantity" value="1" maxlength="9" style="width: 30px;" \/>
				<\/td>
				<td>
					<a href="${base}' + item.path + '" target="_blank">[${message("admin.common.view")}]<\/a>
					<a href="javascript:;" class="deleteGift">[${message("admin.common.delete")}]<\/a>
				<\/td>
			<\/tr>';
		[/@compress]
		$giftTitle.show();
		$giftTable.append(trHtml);
		giftIds.push(item.id);
		giftItemIndex ++;
	});
	
	// 删除赠品
	$deleteGift.live("click", function() {
		var $this = $(this);
		$.dialog({
			type: "warn",
			content: "${message("admin.dialog.deleteConfirm")}",
			onOk: function() {
				var id = parseInt($this.closest("tr").find("input.giftId").val());
				giftIds = $.grep(giftIds, function(n, i) {
					return n != id;
				});
				$this.closest("tr").remove();
				if ($giftTable.find("tr.giftTr").size() <= 0) {
					$giftTitle.hide();
				}
			}
		});
	});
	
	$.validator.addMethod("compare", 
		function(value, element, param) {
			var parameterValue = $(param).val();
			if ($.trim(parameterValue) == "" || $.trim(value) == "") {
				return true;
			}
			try {
				return parseFloat(parameterValue) <= parseFloat(value);
			} catch(e) {
				return false;
			}
		},
		"${message("admin.promotion.compare")}"
	);
	
	$.validator.addClassRules({
		giftItemQuantity: {
			required: true,
			integer: true,
			min: 1
		}
	});
	
	// 表单验证
	$inputForm.validate({
		rules: {
			name: "required",
			title: "required",
			minimumQuantity: "digits",
			maximumQuantity: {
				digits: true,
				compare: "#minimumQuantity"
			},
			minimumPrice: {
				min: 0,
				decimal: {
					integer: 12,
					fraction: ${setting.priceScale}
				}
			},
			maximumPrice: {
				min: 0,
				decimal: {
					integer: 12,
					fraction: ${setting.priceScale}
				},
				compare: "#minimumPrice"
			},
			priceExpression: {
				remote: {
					url: "check_price_expression.jhtml",
					cache: false
				}
			},
			pointExpression: {
				remote: {
					url: "check_point_expression.jhtml",
					cache: false
				}
			},
			order: "digits"
		}
	});
	
});
</script>
</head>
<body>
	<div class="path">
		<a href="${base}/admin/common/index.jhtml">${message("admin.path.index")}</a> &raquo; ${message("admin.promotion.edit")}
	</div>
	<form id="inputForm" action="update.jhtml" method="post">
		<input type="hidden" name="id" value="${promotion.id}" />
		<ul id="tab" class="tab">
			<li>
				<input type="button" value="${message("admin.promotion.base")}" />
			</li>
			<li>
				<input type="button" value="${message("Promotion.introduction")}" />
			</li>
		</ul>
		<div class="tabContent">
			<table class="input">
				<tr>
					<th>
						<span class="requiredField">*</span>${message("Promotion.name")}:
					</th>
					<td colspan="2">
						<input type="text" name="name" class="text" value="${promotion.name}" maxlength="200" />
					</td>
				</tr>
				<tr>
					<th>
						<span class="requiredField">*</span>${message("Promotion.title")}:
					</th>
					<td colspan="2">
						<input type="text" name="title" class="text" value="${promotion.title}" maxlength="200" />
					</td>
				</tr>
				<tr>
					<th>
						${message("Promotion.beginDate")}:
					</th>
					<td colspan="2">
						<input type="text" id="beginDate" name="beginDate" class="text Wdate" value="[#if promotion.beginDate??]${promotion.beginDate?string("yyyy-MM-dd HH:mm:ss")}[/#if]" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm:ss', maxDate: '#F{$dp.$D(\'endDate\')}'});" />
					</td>
				</tr>
				<tr>
					<th>
						${message("Promotion.endDate")}:
					</th>
					<td colspan="2">
						<input type="text" id="endDate" name="endDate" class="text Wdate" value="[#if promotion.endDate??]${promotion.endDate?string("yyyy-MM-dd HH:mm:ss")}[/#if]" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm:ss', minDate: '#F{$dp.$D(\'beginDate\')}'});" />
					</td>
				</tr>
				<tr>
					<th>
						${message("Promotion.minimumQuantity")}:
					</th>
					<td colspan="2">
						<input type="text" id="minimumQuantity" name="minimumQuantity" class="text" value="${promotion.minimumQuantity}" maxlength="9" />
					</td>
				</tr>
				<tr>
					<th>
						${message("Promotion.maximumQuantity")}:
					</th>
					<td colspan="2">
						<input type="text" name="maximumQuantity" class="text" value="${promotion.maximumQuantity}" maxlength="9" />
					</td>
				</tr>
				<tr>
					<th>
						${message("Promotion.minimumPrice")}:
					</th>
					<td colspan="2">
						<input type="text" id="minimumPrice" name="minimumPrice" class="text" value="${promotion.minimumPrice}" maxlength="16" />
					</td>
				</tr>
				<tr>
					<th>
						${message("Promotion.maximumPrice")}:
					</th>
					<td colspan="2">
						<input type="text" name="maximumPrice" class="text" value="${promotion.maximumPrice}" maxlength="16" />
					</td>
				</tr>
				<tr>
					<th>
						${message("Promotion.priceExpression")}:
					</th>
					<td colspan="2">
						<input type="text" name="priceExpression" class="text" value="${promotion.priceExpression}" maxlength="255" title="${message("admin.promotion.priceExpressionTitle")}" />
					</td>
				</tr>
				<tr>
					<th>
						${message("Promotion.pointExpression")}:
					</th>
					<td colspan="2">
						<input type="text" name="pointExpression" class="text" value="${promotion.pointExpression}" maxlength="255" title="${message("admin.promotion.pointExpressionTitle")}" />
					</td>
				</tr>
				<tr>
					<th>
						${message("admin.common.order")}:
					</th>
					<td>
						<input type="text" name="order" class="text" value="${promotion.order}" maxlength="9" />
					</td>
				</tr>
				<tr class="memberRank">
					<th>
						${message("Promotion.memberRanks")}
					</th>
					<td colspan="2">
						[#list memberRanks as memberRank]
							<label>
								<input type="checkbox" name="memberRankIds" value="${memberRank.id}"[#if promotion.memberRanks?seq_contains(memberRank)] checked="checked"[/#if] />${memberRank.name}
							</label>
						[/#list]
					</td>
				</tr>
				<tr class="productCategory">
					<th>
						${message("Promotion.productCategories")}
					</th>
					<td colspan="2">
						[#list productCategories as productCategory]
							<label>
								<input type="checkbox" name="productCategoryIds" value="${productCategory.id}"[#if promotion.productCategories?seq_contains(productCategory)] checked="checked"[/#if] />${productCategory.name}
							</label>
						[/#list]
					</td>
				</tr>
				<tr class="brand">
					<th>
						${message("Promotion.brands")}
					</th>
					<td colspan="2">
						[#list brands as brand]
							<label>
								<input type="checkbox" name="brandIds" value="${brand.id}"[#if promotion.brands?seq_contains(brand)] checked="checked"[/#if] />${brand.name}
							</label>
						[/#list]
					</td>
				</tr>
				<tr class="coupon">
					<th>
						${message("Promotion.coupons")}
					</th>
					<td colspan="2">
						[#list coupons as coupon]
							<label>
								<input type="checkbox" name="couponIds" value="${coupon.id}"[#if promotion.coupons?seq_contains(coupon)] checked="checked"[/#if] />${coupon.name}
							</label>
						[/#list]
					</td>
				</tr>
				<tr>
					<th>
						${message("admin.common.setting")}:
					</th>
					<td colspan="2">
						<label>
							<input type="checkbox" name="isFreeShipping" value="true"[#if promotion.isFreeShipping] checked="checked"[/#if] />${message("Promotion.isFreeShipping")}
							<input type="hidden" name="_isFreeShipping" value="false" />
						</label>
						<label>
							<input type="checkbox" name="isCouponAllowed" value="true"[#if promotion.isCouponAllowed] checked="checked"[/#if] />${message("Promotion.isCouponAllowed")}
							<input type="hidden" name="_isCouponAllowed" value="false" />
						</label>
					</td>
				</tr>
			</table>
			<table id="productTable" class="input">
				<tr>
					<th>
						${message("Promotion.products")}:
					</th>
					<td colspan="2">
						<input type="text" id="productSelect" name="productSelect" class="text" maxlength="200" title="${message("admin.promotion.productSelectTitle")}" />
					</td>
				</tr>
				<tr id="productTitle" class="title[#if !promotion.products?has_content] hidden[/#if]">
					<th>
						&nbsp;
					</th>
					<td width="712">
						${message("Product.name")}
					</td>
					<td>
						${message("admin.common.handle")}
					</td>
				</tr>
				[#list promotion.products as product]
					<tr class="productTr">
						<th>
							<input type="hidden" name="productIds" value="${product.id}" />
							&nbsp;
						</th>
						<td>
							<span title="${product.fullName}">${abbreviate(product.fullName, 50)}</span>
						</td>
						<td>
							<a href="${base}${product.path}" target="_blank">[${message("admin.common.view")}]</a>
							<a href="javascript:;" class="deleteProduct">[${message("admin.common.delete")}]</a>
						</td>
					</tr>
				[/#list]
			</table>
			<table id="giftTable" class="input">
				<tr>
					<th>
						${message("Promotion.giftItems")}:
					</th>
					<td colspan="3">
						<input type="text" id="giftSelect" name="giftSelect" class="text" maxlength="200" title="${message("admin.promotion.giftSelectTitle")}" />
					</td>
				</tr>
				<tr id="giftTitle" class="title[#if !promotion.giftItems?has_content] hidden[/#if]">
					<th>
						&nbsp;
					</th>
					<td width="500">
						${message("Product.name")}
					</td>
					<td width="200">
						${message("GiftItem.quantity")}
					</td>
					<td>
						${message("admin.common.handle")}
					</td>
				</tr>
				[#list promotion.giftItems as giftItem]
					<tr class="giftTr">
						<th>
							<input type="hidden" name="giftItems[${giftItem_index}].id" value="${giftItem.id}" />
							<input type="hidden" name="giftItems[${giftItem_index}].gift.id" value="${giftItem.gift.id}" class="giftId" />&nbsp;
						</th>
						<td>
							<span title="${giftItem.gift.fullName}">${abbreviate(giftItem.gift.fullName, 50)}</span>
						</td>
						<td>
							<input type="text" name="giftItems[${giftItem_index}].quantity" class="text giftItemQuantity" value="${giftItem.quantity}" maxlength="9" style="width: 30px;" />
						</td>
						<td>
							<a href="${base}${giftItem.gift.path}" target="_blank">[${message("admin.common.view")}]</a>
							<a href="javascript:;" class="deleteGift">[${message("admin.common.delete")}]</a>
						</td>
					</tr>
				[/#list]
			</table>
		</div>
		<div class="tabContent">
			<table class="input">
				<tr>
					<td>
						<textarea id="editor" name="introduction" class="editor" style="width: 100%;">${promotion.introduction?html}</textarea>
					</td>
				</tr>
			</table>
		</div>
		<table class="input">
			<tr>
				<th>
					&nbsp;
				</th>
				<td>
					<input type="submit" class="button" value="${message("admin.common.submit")}" />
					<input type="button" class="button" value="${message("admin.common.back")}" onclick="location.href='list.jhtml'" />
				</td>
			</tr>
		</table>
	</form>
</body>
</html>