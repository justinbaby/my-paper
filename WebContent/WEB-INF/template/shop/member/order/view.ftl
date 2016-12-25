<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("shop.member.order.view")}[#if systemShowPowered] - EASY SHOPPING[/#if]</title>
<meta name="author" content="EASY SHOPPING Team" />
<meta name="copyright" content="EASY SHOPPING" />
<link href="${base}/resources/shop/css/common.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/css/member.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/shop/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/common.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $dialogOverlay = $("#dialogOverlay");
	var $dialog = $("#dialog");
	var $close = $("#close");
	var $deliveryContent = $("#deliveryContent");
	var $cancel = $("#cancel");
	var $deliveryQuery = $("a.deliveryQuery");

	[@flash_message /]
	
	// 订单取消
	$cancel.click(function() {
		if (confirm("${message("shop.member.order.cancelConfirm")}")) {
			$.ajax({
				url: "cancel.jhtml?sn=${order.sn}",
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
		return false;
	});
	
	// 物流动态
	$deliveryQuery.click(function() {
		var $this = $(this);
		$.ajax({
			url: "delivery_query.jhtml?sn=" + $this.attr("sn"),
			type: "GET",
			dataType: "json",
			cache: true,
			beforeSend: function() {
				$dialog.show();
				$dialogOverlay.show();
				$deliveryContent.html("${message("shop.member.order.loading")}");
			},
			success: function(data) {
				if (data.data != null) {
					var html = '<table>';
					$.each(data.data, function(i, item) {
						html += '<tr><th>' + item.time + '<\/th><td>' + item.context + '<\/td><\/tr>';
					});
					html += '<\/table>';
					$deliveryContent.html(html);
				} else {
					$deliveryContent.text(data.message);
				}
			}
		});
		return false;
	});
	
	// 关闭物流动态
	$close.click(function() {
		$dialog.hide();
		$dialogOverlay.hide();
	});

});
</script>
</head>
<body>
	<div id="dialogOverlay" class="dialogOverlay"></div>
	[#assign current = "orderList" /]
	[#include "/shop/include/header.ftl" /]
	<div class="container member">
		[#include "/shop/member/include/navigation.ftl" /]
		<div class="span18 last">
			<div class="input order">
				<div id="dialog" class="dialog">
					<div id="close" class="close"></div>
					<ul>
						<li>${message("shop.member.order.time")}</li>
						<li>${message("shop.member.order.content")}</li>
					</ul>
					<div id="deliveryContent" class="deliveryContent"></div>
				</div>
				<div class="title">${message("shop.member.order.view")}</div>
				<div class="top">
					<span>${message("Order.sn")}: ${order.sn}</span>
					<span>
						${message("shop.member.order.status")}: 
						<strong>
							[#if order.expired]
								${message("shop.member.order.hasExpired")}
							[#elseif order.orderStatus == "completed" || order.orderStatus == "cancelled"]
								${message("Order.OrderStatus." + order.orderStatus)}
							[#elseif order.paymentStatus == "unpaid" || order.paymentStatus == "partialPayment"]
								${message("shop.member.order.waitingPayment")}
								[#if order.shippingStatus != "unshipped"]
									${message("Order.ShippingStatus." + order.shippingStatus)}
								[/#if]
							[#else]
								${message("Order.PaymentStatus." + order.paymentStatus)}
								[#if order.paymentStatus == "paid" && order.shippingStatus == "unshipped"]
									${message("shop.member.order.waitingShipping")}
								[#else]
									${message("Order.ShippingStatus." + order.shippingStatus)}
								[/#if]
							[/#if]
						</strong>
					</span>
					<span class="handle">
						[#if !order.expired && (order.orderStatus == "unconfirmed" || order.orderStatus == "confirmed") && (order.paymentStatus == "unpaid" || order.paymentStatus == "partialPayment")]
							<a href="payment.jhtml?sn=${order.sn}" class="button">${message("shop.member.order.payment")}</a>
						[/#if]
						[#if !order.expired && order.orderStatus == "unconfirmed" && order.paymentStatus == "unpaid"]
							<a href="javascript:;" id="cancel" class="button">${message("shop.member.order.cancel")}</a>
						[/#if]
					</span>
					<div class="tips">
						[#if order.expired]
							${message("shop.member.order.hasExpiredTips")}
						[#elseif order.orderStatus == "completed"]
							${message("shop.member.order.completedTips")}
						[#elseif order.orderStatus == "cancelled"]
							${message("shop.member.order.cancelledTips")}
						[#elseif order.expire??]
							${message("shop.member.order.expireTips", order.expire?string("yyyy-MM-dd HH:mm"))}
						[#elseif order.paymentStatus == "paid" && order.shippingStatus == "unshipped"]
							${message("shop.member.order.waitingShippingTips")}
						[#elseif order.paymentStatus == "partialRefunds" || order.paymentStatus == "refunded"]
							${message("shop.member.order.refundedTips")}
						[#elseif order.shippingStatus == "partialShipment" || order.shippingStatus == "shipped"]
							${message("shop.member.order.shippedTips")}
						[#elseif order.shippingStatus == "partialReturns" || order.shippingStatus == "returned"]
							${message("shop.member.order.returnedTips")}
						[#else]
							${message("shop.member.order.processingTips")}
						[/#if]
					</div>
				</div>
				<table class="info">
					<tr>
						<th>
							${message("shop.common.createDate")}:
						</th>
						<td>
							${order.createDate?string("yyyy-MM-dd HH:mm:ss")}
						</td>
					</tr>
					<tr>
						<th>
							${message("Order.paymentMethod")}:
						</th>
						<td>
							${order.paymentMethodName}
						</td>
					</tr>
					<tr>
						<th>
							${message("Order.shippingMethod")}:
						</th>
						<td>
							${order.shippingMethodName}
						</td>
					</tr>
					[#if order.point > 0]
						<tr>
							<th>
								${message("Order.point")}:
							</th>
							<td>
								${order.point}
							</td>
						</tr>
					[/#if]
					<tr>
						<th>
							${message("Order.price")}:
						</th>
						<td>
							${currency(order.price, true)}
						</td>
					</tr>
					[#if order.fee > 0]
						<tr>
							<th>
								${message("Order.fee")}:
							</th>
							<td>
								${currency(order.fee, true)}
							</td>
						</tr>
					[/#if]
					[#if order.freight > 0]
						<tr>
							<th>
								${message("Order.freight")}:
							</th>
							<td>
								${currency(order.freight, true)}
							</td>
						</tr>
					[/#if]
					[#if order.promotionDiscount > 0]
						<tr>
							<th>
								${message("Order.promotionDiscount")}:
							</th>
							<td>
								${currency(order.promotionDiscount, true)}
							</td>
						</tr>
					[/#if]
					[#if order.couponDiscount > 0]
						<tr>
							<th>
								${message("Order.couponDiscount")}:
							</th>
							<td>
								${currency(order.couponDiscount, true)}
							</td>
						</tr>
					[/#if]
					<tr>
						<th>
							${message("Order.amount")}:
						</th>
						<td>
							${currency(order.amount, true)}
						</td>
					</tr>
					[#if order.couponCode??]
						<tr>
							<th>
								${message("shop.member.order.coupon")}:
							</th>
							<td>
								${order.couponCode.coupon.name}
							</td>
						</tr>
					[/#if]
					[#if order.promotion??]
						<tr>
							<th>
								${message("Order.promotion")}:
							</th>
							<td>
								${order.promotion}
							</td>
						</tr>
					[/#if]
					<tr>
						<th>
							${message("Order.memo")}:
						</th>
						<td>
							${order.memo}
						</td>
					</tr>
				</table>
				[#if order.isInvoice]
					<table class="info">
						<tr>
							<th>
								${message("Order.invoiceTitle")}:
							</th>
							<td>
								${order.invoiceTitle}
							</td>
						</tr>
						<tr>
							<th>
								${message("Order.tax")}:
							</th>
							<td>
								${currency(order.tax, true)}
							</td>
						</tr>
					</table>
				[/#if]
				<table class="info">
					<tr>
						<th>
							${message("Order.consignee")}:
						</th>
						<td>
							${order.consignee}
						</td>
					</tr>
					<tr>
						<th>
							${message("Order.zipCode")}:
						</th>
						<td>
							${order.zipCode}
						</td>
					</tr>
					<tr>
						<th>
							${message("Order.address")}:
						</th>
						<td>
							${order.areaName}${order.address}
						</td>
					</tr>
					<tr>
						<th>
							${message("Order.phone")}:
						</th>
						<td>
							${order.phone}
						</td>
					</tr>
				</table>
				[#if order.shippings?has_content]
					<table class="info">
						[#list order.shippings as shipping]
							<tr>
								<th>
									${message("Shipping.deliveryCorp")}:
								</th>
								<td>
									[#if shipping.deliveryCorpUrl??]
										<a href="${shipping.deliveryCorpUrl}" target="_blank">${shipping.deliveryCorp}</a>
									[#else]
										${(shipping.deliveryCorp)!"-"}
									[/#if]
								</td>
								<th>
									${message("Shipping.trackingNo")}:
								</th>
								<td>
									${(shipping.trackingNo)!"-"}
									[#if setting.kuaidi100Key?has_content && shipping.deliveryCorpCode?? && shipping.trackingNo??]
										<a href="javascript:;" class="deliveryQuery" sn="${shipping.sn}">[${message("shop.member.order.deliveryQuery")}]</a>
									[/#if]
								</td>
								<th>
									${message("shop.member.order.deliveryDate")}:
								</th>
								<td>
									${shipping.createDate?string("yyyy-MM-dd HH:mm")}
								</td>
							</tr>
						[/#list]
					</table>
				[/#if]
				<table class="orderItem">
					<tr>
						
						<th>
							${message("OrderItem.name")}
						</th>
						<th>
							${message("OrderItem.price")}
						</th>
						<th>
							${message("OrderItem.quantity")}
						</th>
						<th>
							${message("OrderItem.subtotal")}
						</th>
					</tr>
					[#list order.orderItems as orderItem]
						<tr>
							
							<td>
								[#if orderItem.product??]
									<a href="${base}${orderItem.product.path}" title="${orderItem.fullName}" target="_blank">${abbreviate(orderItem.fullName, 30)}</a>
								[#else]
									<span title="${orderItem.fullName}">${abbreviate(orderItem.fullName, 30)}</span>
								[/#if]
								[#if orderItem.isGift]
									<span class="red">[${message("shop.member.order.gift")}]</span>
								[/#if]
							</td>
							<td>
								[#if !orderItem.isGift]
									${currency(orderItem.price, true)}
								[#else]
									-
								[/#if]
							</td>
							<td>
								${orderItem.quantity}
							</td>
							<td>
								[#if !orderItem.isGift]
									${currency(orderItem.subtotal, true)}
								[#else]
									-
								[/#if]
							</td>
						</tr>
					[/#list]
				</table>
			</div>
		</div>
	</div>
	[#include "/shop/include/footer.ftl" /]
</body>
</html>