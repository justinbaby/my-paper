<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("shop.member.index")}[#if systemShowPowered] - EASY SHOPPING[/#if]</title>
<meta name="author" content="EASY SHOPPING Team" />
<meta name="copyright" content="EASY SHOPPING" />
<link href="${base}/resources/shop/css/common.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/css/member.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/shop/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/shop/js/common.js"></script>
</head>
<body>
	[#include "/shop/include/header.ftl" /]
    <div class="container member">
		[#include "/shop/member/include/navigation.ftl" /]
		<div class="span18 last">
			<div class="index">
				<div class="top clearfix">
					<div>
						<ul>
							<li>
								${message("shop.member.index.memberRank")}: ${member.memberRank.name}
							</li>
							<li>
								${message("shop.member.index.balance")}:
								<strong>${currency(member.balance, true, true)}</strong>
							</li>
							<li>
								${message("shop.member.index.amount")}:
								<strong>${currency(member.amount, true, true)}</strong>
							</li>
							<li>
								${message("shop.member.index.point")}:
								<em>${member.point}</em>
								<a href="coupon_code/exchange.jhtml">${message("shop.member.index.exchange")}</a>
							</li>
						</ul>
						<ul>
							<li>
								<a href="order/list.jhtml">${message("shop.member.index.waitingPaymentOrderCount")}(<em>${waitingPaymentOrderCount}</em>)</a>
								<a href="order/list.jhtml">${message("shop.member.index.waitingShippingOrderCount")}(<em>${waitingShippingOrderCount}</em>)</a>
							</li>
							<li>
								<a href="message/list.jhtml">${message("shop.member.index.messageCount")}(<em>${messageCount}</em>)</a>
								<a href="coupon_code/list.jhtml">${message("shop.member.index.couponCodeCount")}(<em>${couponCodeCount}</em>)</a>
							</li>
							<li>
								<a href="favorite/list.jhtml">${message("shop.member.index.favoriteCount")}(<em>${favoriteCount}</em>)</a>
								<a href="product_notify/list.jhtml">${message("shop.member.index.productNotifyCount")}(<em>${productNotifyCount}</em>)</a>
							</li>
							<li>
								<a href="review/list.jhtml">${message("shop.member.index.reviewCount")}(<em>${reviewCount}</em>)</a>
								<a href="consultation/list.jhtml">${message("shop.member.index.consultationCount")}(<em>${consultationCount}</em>)</a>
							</li>
						</ul>
					</div>
				</div>
				<div class="list">
					<div class="title">${message("shop.member.index.newOrder")}</div>
					<table class="list">
						<tr>
							<th>
								${message("Order.sn")}
							</th>
							<th>
								${message("shop.member.index.product")}
							</th>
							<th>
								${message("Order.consignee")}
							</th>
							<th>
								${message("Order.amount")}
							</th>
							<th>
								${message("shop.common.createDate")}
							</th>
							<th>
								${message("shop.member.index.orderStatus")}
							</th>
							<th>
								${message("shop.member.handle")}
							</th>
						</tr>
						[#list newOrders as order]
							<tr[#if !order_has_next] class="last"[/#if]>
								<td>
									${order.sn}
								</td>
								<td>
									[#list order.orderItems as orderItem]
										<img src="[#if orderItem.thumbnail??]${orderItem.thumbnail}[#else]${setting.defaultThumbnailProductImage}[/#if]" class="thumbnail" alt="${orderItem.fullName}" />
										[#if orderItem_index == 2]
											[#break /]
										[/#if]
									[/#list]
								</td>
								<td>
									${order.consignee}
								</td>
								<td>
									${currency(order.amount, true)}
								</td>
								<td>
									<span title="${order.createDate?string("yyyy-MM-dd HH:mm:ss")}">${order.createDate}</span>
								</td>
								<td>
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
								</td>
								<td>
									<a href="order/view.jhtml?sn=${order.sn}">[${message("shop.member.handle.view")}]</a>
								</td>
							</tr>
						[/#list]
					</table>
					[#if !newOrders?has_content]
						<p>${message("shop.member.noResult")}</p>
					[/#if]
				</div>
			</div>
		</div>
		[#include "/shop/include/footer.ftl" /]
	</div>
</body>
</html>