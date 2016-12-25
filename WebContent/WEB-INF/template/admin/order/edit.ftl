<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("admin.order.edit")} - EASY SHOPPING</title>
<meta name="author" content="EASY SHOPPING Team" />
<meta name="copyright" content="EASY SHOPPING" />
<link href="${base}/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/admin/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/jquery.tools.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/jquery.lSelect.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/input.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $inputForm = $("#inputForm");
	var $input = $("#inputForm :input:not(#productSn)");
	var $amount = $("#amount");
	var $weight = $("#weight");
	var $quantity = $("#quantity");
	var $isInvoice = $("#isInvoice");
	var $invoiceTitle = $("#invoiceTitle");
	var $tax = $("#tax");
	var $areaId = $("#areaId");
	var $orderItemTable = $("#orderItemTable");
	var $deleteOrderItem = $("#orderItemTable a.deleteOrderItem");
	var $productSn = $("#productSn");
	var $addOrderItem = $("#addOrderItem");
	var isLocked = false;
	var timeouts = {};
	var orderItemIndex = ${order.orderItems?size};
	
	[@flash_message /]
	
	// 初始值
	$input.each(function() {
		var $this = $(this);
		$this.data("value", $this.val());
	});
	
	// 地区选择
	$areaId.lSelect({
		url: "${base}/admin/common/area.jhtml"
	});
	
	// 检查锁定
	function checkLock() {
		if (!isLocked) {
			$.ajax({
				url: "check_lock.jhtml",
				type: "POST",
				data: {id: ${order.id}},
				dataType: "json",
				cache: false,
				success: function(message) {
					if (message.type != "success") {
						$.message(message);
						$inputForm.find(":input:not(#backButton), #orderItemTable a.deleteOrderItem").prop("disabled", true);
						isLocked = true;
					}
				}
			});
		}
	}
	
	// 检查锁定
	checkLock();
	setInterval(function() {
		checkLock();
	}, 10000);
	
	// 开据发票
	$isInvoice.click(function() {
		if ($(this).prop("checked")) {
			$invoiceTitle.prop("disabled", false);
			$tax.prop("disabled", false);
		} else {
			$invoiceTitle.prop("disabled", true);
			$tax.prop("disabled", true);
		}
	});
	
	// 计算
	$input.bind("input propertychange change", function(event) {
		if (event.type != "propertychange" || event.originalEvent.propertyName == "value") {
			calculate($(this));
		}
	});
	
	// 计算
	function calculate($input) {
		var name = $input.attr("name");
		clearTimeout(timeouts[name]);
		timeouts[name] = setTimeout(function() {
			if ($inputForm.valid()) {
				$.ajax({
					url: "calculate.jhtml",
					type: "POST",
					data: $inputForm.serialize(),
					dataType: "json",
					cache: false,
					success: function(data) {
						if (data.message.type == "success") {
							$input.data("value", $input.val());
							$amount.text(currency(data.amount, true));
							$weight.text(data.weight);
							$quantity.text(data.quantity);
							if ($input.hasClass("orderItemPrice") || $input.hasClass("orderItemQuantity")) {
								var $tr = $input.closest("tr");
								$tr.find("span.subtotal").text(currency(data.orderItems[$tr.find("input.orderItemSn").val()].subtotal, true));
							}
						} else {
							$.message(data.message);
							$input.val($input.data("value"));
						}
					}
				});
			}
		}, 500);
	}
	
	// 添加订单项
	$addOrderItem.click(function() {
		var productSn = $.trim($productSn.val());
		if (productSn == "") {
			$.message("warn", "${message("admin.order.productSnRequired")}");
			return false;
		}
		var repeat = false;
		$("#inputForm input.orderItemSn").each(function() {
			if ($(this).val() == productSn) {
				repeat = true;
				return false;
			}
		});
		if (repeat) {
			$.message("warn", "${message("admin.order.productSnExist")}");
			return false;
		}
		
		$.ajax({
			url: "order_item_add.jhtml",
			type: "POST",
			data: {productSn: $productSn.val()},
			dataType: "json",
			success: function(data) {
				if (data.message.type == "success") {
					[@compress single_line = true]
						var $tr = $(
						'<tr class="orderItemTr">
							<td>
								<input type="hidden" name="orderItems[' + orderItemIndex + '].sn" class="orderItemSn" value="' + data.sn + '" \/>
								<input type="hidden" name="orderItems[' + orderItemIndex + '].weight" value="' + (data.weight != null ? data.weight : '') + '" \/>
								' + data.sn + '
							<\/td>
							<td width="400">
								<span title="' + data.fullName + '">' + data.fullName.substring(0, 50) + '<\/span>
								' + (data.isGift ? '<span class="red">[${message("admin.order.gift")}]<\/span>' : '') + '
							<\/td>
							<td>
								' + (data.isGift ? '<input type="hidden" name="orderItems[' + orderItemIndex + '].price" value="0" \/>-' : '<input type="text" name="orderItems[' + orderItemIndex + '].price" class="text orderItemPrice" value="' + data.price + '" maxlength="16" style="width: 60px;" \/>') + '
							<\/td>
							<td>
								<input type="text" name="orderItems[' + orderItemIndex + '].quantity" class="text orderItemQuantity" value="1" maxlength="4" style="width: 30px;" \/>
							<\/td>
							<td>
								' + (data.isGift ? '-' : '<span class="subtotal">' + currency(data.price, true) + '<\/span>') + '
							<\/td>
							<td>
								<a href="javascript:;" class="deleteOrderItem">[${message("admin.common.delete")}]<\/a>
							<\/td>
						<\/tr>');
					[/@compress]
					$tr.appendTo($orderItemTable).find(":text").each(function() {
						var $this = $(this);
						$this.data("value", $this.val());
					}).bind("input propertychange change", function(event) {
						if (event.type != "propertychange" || event.originalEvent.propertyName == "value") {
							calculate($(this));
						}
					});
					orderItemIndex ++;
				} else {
					$.message(data.message);
				}
			}
		});
	});
	
	// 删除订单项
	$deleteOrderItem.live("click", function() {
		var $this = $(this);
		if ($orderItemTable.find("tr.orderItemTr").size() <= 1) {
			$.message("warn", "${message("admin.common.deleteAllNotAllowed")}");
		} else {
			$this.closest("tr").find(":text").each(function() {
				var name = $(this).attr("name");
				clearTimeout(timeouts[name]);
			});
			$this.closest("tr").remove();
		}
	});
	
	$.validator.addClassRules({
		orderItemPrice: {
			required: true,
			min: 0,
			decimal: {
				integer: 12,
				fraction: ${setting.priceScale}
			}
		},
		orderItemQuantity: {
			required: true,
			integer: true,
			min: 1
		}
	});
	
	// 表单验证
	$inputForm.validate({
		rules: {
			offsetAmount: {
				required: true,
				number: true,
				decimal: {
					integer: 12,
					fraction: ${setting.priceScale}
				}
			},
			point: {
				required: true,
				digits: true
			},
			freight: {
				required: true,
				min: 0,
				decimal: {
					integer: 12,
					fraction: ${setting.priceScale}
				}
			},
			paymentMethodId: "required",
			shippingMethodId: "required",
			invoiceTitle: "required",
			tax: {
				required: true,
				min: 0,
				decimal: {
					integer: 12,
					fraction: ${setting.priceScale}
				}
			},
			consignee: "required",
			areaId: "required",
			address: "required",
			zipCode: "required",
			phone: "required"
		}
	});

});
</script>
</head>
<body>
	<div class="path">
		<a href="${base}/admin/common/index.jhtml">${message("admin.path.index")}</a> &raquo; ${message("admin.order.edit")}
	</div>
	<ul id="tab" class="tab">
		<li>
			<input type="button" value="${message("admin.order.orderInfo")}" />
		</li>
		<li>
			<input type="button" value="${message("admin.order.productInfo")}" />
		</li>
	</ul>
	<form id="inputForm" action="update.jhtml" method="post">
		<input type="hidden" name="id" value="${order.id}" />
		<table class="input tabContent">
			<tr>
				<th>
					${message("Order.sn")}:
				</th>
				<td width="360">
					${order.sn}
				</td>
				<th>
					${message("admin.common.createDate")}:
				</th>
				<td>
					${order.createDate?string("yyyy-MM-dd HH:mm:ss")}
				</td>
			</tr>
			<tr>
				<th>
					${message("Order.orderStatus")}:
				</th>
				<td>
					${message("Order.OrderStatus." + order.orderStatus)}
					[#if order.expire??]
						<span title="${message("Order.expire")}: ${order.expire?string("yyyy-MM-dd HH:mm:ss")}">(${message("Order.expire")}: ${order.expire})</span>
					[/#if]
				</td>
				<th>
					${message("Order.paymentStatus")}:
				</th>
				<td>
					${message("Order.PaymentStatus." + order.paymentStatus)}
				</td>
			</tr>
			<tr>
				<th>
					${message("Order.shippingStatus")}:
				</th>
				<td>
					${message("Order.ShippingStatus." + order.shippingStatus)}
				</td>
				<th>
					${message("Member.username")}:
				</th>
				<td>
					<a href="../member/view.jhtml?id=${order.member.id}">${order.member.username}</a>
				</td>
			</tr>
			<tr>
				<th>
					${message("Order.amount")}:
				</th>
				<td>
					<span id="amount">${currency(order.amount, true)}</span>
				</td>
				<th>
					${message("Order.amountPaid")}:
				</th>
				<td>
					${currency(order.amountPaid, true)}
				</td>
			</tr>
			<tr>
				<th>
					${message("Order.weight")}:
				</th>
				<td>
					<span id="weight">${order.weight}</span>
				</td>
				<th>
					${message("Order.quantity")}:
				</th>
				<td>
					<span id="quantity">${order.quantity}</span>
				</td>
			</tr>
			<tr>
				<th>
					${message("Order.promotion")}:
				</th>
				<td>
					${(order.promotion)!"-"}
				</td>
				<th>
					${message("admin.order.coupon")}:
				</th>
				<td>
					${(order.couponCode.coupon.name)!"-"}
				</td>
			</tr>
			<tr>
				<th>
					${message("Order.promotionDiscount")}:
				</th>
				<td>
					${currency(order.promotionDiscount, true)}
				</td>
				<th>
					${message("Order.couponDiscount")}:
				</th>
				<td>
					${currency(order.couponDiscount, true)}
				</td>
			</tr>
			<tr>
				<th>
					${message("Order.offsetAmount")}:
				</th>
				<td>
					<input type="text" name="offsetAmount" class="text" value="${order.offsetAmount}" maxlength="16" />
				</td>
				<th>
					${message("Order.point")}:
				</th>
				<td>
					<input type="text" name="point" class="text" value="${order.point}" maxlength="9" />
				</td>
			</tr>
			<tr>
				<th>
					${message("Order.freight")}:
				</th>
				<td>
					<input type="text" name="freight" class="text" value="${order.freight}" maxlength="16" />
				</td>
				<th>
					${message("Order.fee")}:
				</th>
				<td>
					${currency(order.fee, true)}
				</td>
			</tr>
			<tr>
				<th>
					${message("Order.paymentMethod")}:
				</th>
				<td>
					<select name="paymentMethodId">
						<option value="">${message("admin.common.choose")}</option>
						[#list paymentMethods as paymentMethod]
							<option value="${paymentMethod.id}"[#if paymentMethod == order.paymentMethod] selected="selected"[/#if]>${paymentMethod.name}</option>
						[/#list]
					</select>
				</td>
				<th>
					${message("Order.shippingMethod")}:
				</th>
				<td>
					<select name="shippingMethodId">
						<option value="">${message("admin.common.choose")}</option>
						[#list shippingMethods as shippingMethod]
							<option value="${shippingMethod.id}"[#if shippingMethod == order.shippingMethod] selected="selected"[/#if]>${shippingMethod.name}</option>
						[/#list]
					</select>
				</td>
			</tr>
			<tr>
				<th>
					${message("Order.invoiceTitle")}:
				</th>
				<td>
					<span class="fieldSet">
						<input type="text" id="invoiceTitle" name="invoiceTitle" class="text" value="${order.invoiceTitle}" maxlength="200"[#if !order.isInvoice] disabled="disabled"[/#if] />
						<label>
							<input type="checkbox" id="isInvoice" name="isInvoice" value="true"[#if order.isInvoice] checked="checked"[/#if] />${message("Order.isInvoice")}
							<input type="hidden" name="_isInvoice" value="false" />
						</label>
					</span>
				</td>
				<th>
					${message("Order.tax")}:
				</th>
				<td>
					<input type="text" id="tax" name="tax" class="text" value="${order.tax}" maxlength="16"[#if !order.isInvoice] disabled="disabled"[/#if] />
				</td>
			</tr>
			<tr>
				<th>
					${message("Order.consignee")}:
				</th>
				<td>
					<input type="text" name="consignee" class="text" value="${order.consignee}" maxlength="200" />
				</td>
				<th>
					${message("Order.area")}:
				</th>
				<td>
					<span class="fieldSet">
						<input type="hidden" id="areaId" name="areaId" value="${(order.area.id)!}" treePath="${(order.area.treePath)!}" />
					</span>
				</td>
			</tr>
			<tr>
				<th>
					${message("Order.address")}:
				</th>
				<td>
					<input type="text" name="address" class="text" value="${order.address}" maxlength="200" />
				</td>
				<th>
					${message("Order.zipCode")}:
				</th>
				<td>
					<input type="text" name="zipCode" class="text" value="${order.zipCode}" maxlength="200" />
				</td>
			</tr>
			<tr>
				<th>
					${message("Order.phone")}:
				</th>
				<td>
					<input type="text" name="phone" class="text" value="${order.phone}" maxlength="200" />
				</td>
				<th>
					${message("Order.memo")}:
				</th>
				<td>
					<input type="text" name="memo" class="text" value="${order.memo}" maxlength="200" />
				</td>
			</tr>
		</table>
		<table id="orderItemTable" class="input tabContent">
			<tr>
				<td colspan="6">
					${message("admin.order.productSn")}: <input type="text" id="productSn" name="productSn" class="text" maxlength="200" />
					<input type="button" id="addOrderItem" class="button" value="${message("admin.order.addProduct")}" />
				</td>
			</tr>
			<tr class="title">
				<th>
					${message("Product.sn")}
				</th>
				<th>
					${message("Product.name")}
				</th>
				<th>
					${message("admin.order.productPrice")}
				</th>
				<th>
					${message("admin.order.productQuantity")}
				</th>
				<th>
					${message("admin.order.subTotal")}
				</th>
				<th>
					${message("admin.common.handle")}
				</th>
			</tr>
			[#list order.orderItems as orderItem]
				<tr class="orderItemTr">
					<td>
						<input type="hidden" name="orderItems[${orderItem_index}].id" value="${orderItem.id}" />
						<input type="hidden" name="orderItems[${orderItem_index}].sn" class="orderItemSn" value="${orderItem.sn}" />
						<input type="hidden" name="orderItems[${orderItem_index}].weight" value="${orderItem.weight}" />
						${orderItem.sn}
					</td>
					<td width="400">
						<span title="${orderItem.fullName}">${abbreviate(orderItem.fullName, 50)}</span>
						[#if orderItem.isGift]
							<span class="red">[${message("admin.order.gift")}]</span>
						[/#if]
					</td>
					<td>
						[#if !orderItem.isGift]
							<input type="text" name="orderItems[${orderItem_index}].price" class="text orderItemPrice" value="${orderItem.price}" maxlength="16" style="width: 60px;" />
						[#else]
							<input type="hidden" name="orderItems[${orderItem_index}].price" value="0" />
							-
						[/#if]
					</td>
					<td>
						<input type="text" name="orderItems[${orderItem_index}].quantity" class="text orderItemQuantity" value="${orderItem.quantity}" maxlength="4" style="width: 30px;" />
					</td>
					<td>
						[#if !orderItem.isGift]
							<span class="subtotal">${currency(orderItem.subtotal, true)}</span>
						[#else]
							-
						[/#if]
					</td>
					<td>
						<a href="javascript:;" class="deleteOrderItem">[${message("admin.common.delete")}]</a>
					</td>
				</tr>
			[/#list]
		</table>
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