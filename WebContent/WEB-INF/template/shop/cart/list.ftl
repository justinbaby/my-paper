<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("shop.cart.title")}[#if systemShowPowered] - EASY SHOPPING[/#if]</title>
<meta name="author" content="EASY SHOPPING Team" />
<meta name="copyright" content="EASY SHOPPING" />
<link href="${base}/resources/shop/css/common.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/css/cart.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/shop/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/common.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $quantity = $("input[name='quantity']");
	var $increase = $("span.increase");
	var $decrease = $("span.decrease");
	var $delete = $("a.delete");
	var $giftItems = $("#giftItems");
	var $promotion = $("#promotion");
	var $effectivePoint = $("#effectivePoint");
	var $effectivePrice = $("#effectivePrice");
	var $clear = $("#clear");
	var $submit = $("#submit");
	var timeouts = {};
	
	// 初始数量
	$quantity.each(function() {
		var $this = $(this);
		$this.data("value", $this.val());
	});
	
	// 数量
	$quantity.keypress(function(event) {
		var key = event.keyCode ? event.keyCode : event.which;
		if ((key >= 48 && key <= 57) || key==8) {
			return true;
		} else {
			return false;
		}
	});
	
	// 增加数量
	$increase.click(function() {
		var $quantity = $(this).parent().siblings("input");
		var quantity = $quantity.val();
		if (/^\d*[1-9]\d*$/.test(quantity)) {
			$quantity.val(parseInt(quantity) + 1);
		} else {
			$quantity.val(1);
		}
		edit($quantity);
	});
	
	// 减少数量
	$decrease.click(function() {
		var $quantity = $(this).parent().siblings("input");
		var quantity = $quantity.val();
		if (/^\d*[1-9]\d*$/.test(quantity) && parseInt(quantity) > 1) {
			$quantity.val(parseInt(quantity) - 1);
		} else {
			$quantity.val(1);
		}
		edit($quantity);
	});
	
	// 编辑数量
	$quantity.bind("input propertychange change", function(event) {
		if (event.type != "propertychange" || event.originalEvent.propertyName == "value") {
			edit($(this));
		}
	});
	
	// 编辑数量
	function edit($quantity) {
		var quantity = $quantity.val();
		if (/^\d*[1-9]\d*$/.test(quantity)) {
			var $tr = $quantity.closest("tr");
			var id = $tr.find("input[name='id']").val();
			clearTimeout(timeouts[id]);
			timeouts[id] = setTimeout(function() {
				$.ajax({
					url: "edit.jhtml",
					type: "POST",
					data: {id: id, quantity: quantity},
					dataType: "json",
					cache: false,
					beforeSend: function() {
						$submit.prop("disabled", true);
					},
					success: function(data) {
						if (data.message.type == "success") {
							$quantity.data("value", quantity);
							$tr.find("span.subtotal").text(currency(data.subtotal, true));
							if (data.giftItems != null && data.giftItems.length > 0) {
								$giftItems.html('<dt>${message("shop.cart.gift")}:<\/dt>');
								$.each(data.giftItems, function(i, giftItem) { 
									$giftItems.append('<dd><a href="${base}' + giftItem.gift.path + '" title="' + giftItem.gift.fullName + '" target="_blank">' + giftItem.gift.fullName.substring(0, 50) + ' * ' + giftItem.quantity + '<\/a><\/dd>');
								});
								$giftItems.show();
							} else {
								$giftItems.hide();
							}
							if (data.promotions != null && data.promotions.length > 0) {
								var promotionName = "";
								$.each(data.promotions, function(i, promotion) { 
									promotionName += promotion.name + " ";
								});
								$promotion.text(promotionName);
							} else {
								$promotion.empty();
							}
							if (!data.isLowStock) {
								$tr.find("span.lowStock").remove();
							}
							$effectivePoint.text(data.effectivePoint);
							$effectivePrice.text(currency(data.effectivePrice, true, true));
						} else if (data.message.type == "warn") {
							$.message(data.message);
							$quantity.val($quantity.data("value"));
						} else if (data.message.type == "error") {
							$.message(data.message);
							$quantity.val($quantity.data("value"));
							setTimeout(function() {
								location.reload(true);
							}, 3000);
						}
					},
					complete: function() {
						$submit.prop("disabled", false);
					}
				});
			}, 500);
		} else {
			$quantity.val($quantity.data("value"));
		}
	}

	// 删除
	$delete.click(function() {
		if (confirm("${message("shop.dialog.deleteConfirm")}")) {
			var $this = $(this);
			var $tr = $this.closest("tr");
			var id = $tr.find("input[name='id']").val();
			clearTimeout(timeouts[id]);
			$.ajax({
				url: "delete.jhtml",
				type: "POST",
				data: {id: id},
				dataType: "json",
				cache: false,
				beforeSend: function() {
					$submit.prop("disabled", true);
				},
				success: function(data) {
					if (data.message.type == "success") {
						if (data.quantity > 0) {
							$tr.remove();
							if (data.giftItems != null && data.giftItems.length > 0) {
								$giftItems.html('<dt>${message("shop.cart.gift")}:<\/dt>');
								$.each(data.giftItems, function(i, giftItem) { 
									$giftItems.append('<dd><a href="${base}' + giftItem.gift.path + '" title="' + giftItem.gift.fullName + '" target="_blank">' + giftItem.gift.fullName.substring(0, 50) + ' * ' + giftItem.quantity + '<\/a><\/dd>');
								});
								$giftItems.show();
							} else {
								$giftItems.hide();
							}
							if (data.promotions != null && data.promotions.length > 0) {
								var promotionName = "";
								$.each(data.promotions, function(i, promotion) { 
									promotionName += promotion.name + " ";
								});
								$promotion.text(promotionName);
							} else {
								$promotion.empty();
							}
							$effectivePoint.text(data.effectivePoint);
							$effectivePrice.text(currency(data.effectivePrice, true, true));
						} else {
							location.reload(true);
						}
					} else {
						$.message(data.message);
						setTimeout(function() {
							location.reload(true);
						}, 3000);
					}
				},
				complete: function() {
					$submit.prop("disabled", false);
				}
			});
		}
		return false;
	});
	
	// 清空
	$clear.click(function() {
		if (confirm("${message("shop.dialog.clearConfirm")}")) {
			$.each(timeouts, function(i, timeout) {
				clearTimeout(timeout);
			});
			$.ajax({
				url: "clear.jhtml",
				type: "POST",
				dataType: "json",
				cache: false,
				success: function(data) {
					location.reload(true);
				}
			});
		}
		return false;
	});
	
	// 提交
	$submit.click(function() {
		if (!$.checkLogin()) {
			$.redirectLogin("${base}/cart/list.jhtml", "${message("shop.cart.accessDenied")}");
			return false;
		}
	});
	
});
</script>
</head>
<body>
	[#include "/shop/include/header.ftl" /]
	<div class="container cart">
		<div class="span24">
			<div class="step step1">
				<ul>
					<li class="current">${message("shop.cart.step1")}</li>
					<li>${message("shop.cart.step2")}</li>
					<li>${message("shop.cart.step3")}</li>
				</ul>
			</div>
			[#if cart?? && cart.cartItems?has_content]
				<table>
					<tr>
						<th>${message("shop.cart.image")}</th>
						<th>${message("shop.cart.product")}</th>
						<th>${message("shop.cart.price")}</th>
						<th>${message("shop.cart.quantity")}</th>
						<th>${message("shop.cart.subtotal")}</th>
						<th>${message("shop.cart.handle")}</th>
					</tr>
					[#list cart.cartItems as cartItem]
						<tr>
							<td width="60">
								<input type="hidden" name="id" value="${cartItem.id}" />
								<img src="[#if cartItem.product.thumbnail??]${cartItem.product.thumbnail}[#else]${setting.defaultThumbnailProductImage}[/#if]" alt="${cartItem.product.name}" />
							</td>
							<td>
								<a href="${base}${cartItem.product.path}" title="${cartItem.product.fullName}" target="_blank">${abbreviate(cartItem.product.fullName, 60, "...")}</a>
								[#if cartItem.isLowStock]
									<span class="red lowStock">[${message("shop.cart.lowStock")}]</span>
								[/#if]
							</td>
							<td>
								${currency(cartItem.price, true)}
							</td>
							<td class="quantity" width="60">
								<input type="text" name="quantity" value="${cartItem.quantity}" maxlength="4" onpaste="return false;" />
								<div>
									<span class="increase">&nbsp;</span>
									<span class="decrease">&nbsp;</span>
								</div>
							</td>
							<td width="140">
								<span class="subtotal">${currency(cartItem.subtotal, true)}</span>
							</td>
							<td>
								<a href="javascript:;" class="delete">${message("shop.cart.delete")}</a>
							</td>
						</tr>
					[/#list]
				</table>
				<dl id="giftItems"[#if !cart.giftItems?has_content] class="hidden"[/#if]>
					[#if cart.giftItems?has_content]
						<dt>${message("shop.cart.gift")}:</dt>
						[#list cart.giftItems as giftItem]
							<dd>
								<a href="${base}${giftItem.gift.path}" title="${giftItem.gift.fullName}" target="_blank">${abbreviate(giftItem.gift.fullName, 60, "...")} * ${giftItem.quantity}</a>
							</dd>
						[/#list]
					[/#if]
				</dl>
				<div class="total">
					<em id="promotion">
						[#list cart.promotions as promotion]
							${promotion.name}
						[/#list]
					</em>
					[@current_member]
						[#if !currentMember??]
							<em>
								${message("shop.cart.promotionTips")}
							</em>
						[/#if]
					[/@current_member]
					${message("shop.cart.effectivePoint")}: <em id="effectivePoint">${cart.effectivePoint}</em>
					${message("shop.cart.effectivePrice")}: <strong id="effectivePrice">${currency(cart.effectivePrice, true, true)}</strong>
				</div>
				<div class="bottom">
					<a href="javascript:;" id="clear" class="clear">${message("shop.cart.clear")}</a>
					<a href="${base}/member/order/info.jhtml" id="submit" class="submit">${message("shop.cart.submit")}</a>
				</div>
			[#else]
				<p>
					<a href="${base}/">${message("shop.cart.empty")}</a>
				</p>
			[/#if]
		</div>
	</div>
	[#include "/shop/include/footer.ftl" /]
</body>
</html>