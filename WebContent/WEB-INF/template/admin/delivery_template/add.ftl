<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>${message("admin.deliveryTemplate.add")} - EASY SHOPPING</title>
<meta name="author" content="EASY SHOPPING Team" />
<meta name="copyright" content="EASY SHOPPING" />
<link href="${base}/resources/admin/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/admin/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/jquery.event.drag.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/common.js"></script>
<script type="text/javascript" src="${base}/resources/admin/js/input.js"></script>
<style type="text/css">
div.popupMenu {
	height: 300px;
	padding: 2px;
	overflow: auto;
	z-index: 1000000;
}

.container {
	width: 1000px;
	height: 400px;
	position: relative;
	overflow: hidden;
	border: 1px solid #dde9f5;
}

.container .item {
	line-height: 20px;
	float: left;
	position: absolute;
	top: 0px;
	left: 0px;
	color: #666666;
	overflow: hidden;
	word-wrap: break-word;
	filter: alpha(opacity = 80);
	-moz-opacity: 0.8;
	opacity: 0.8;
	border: 1px dotted #999999;
	background: #ffffff;
}

.container .selected {
	filter: alpha(opacity = 100);
	-moz-opacity: 1;
	opacity: 1;
	border: 1px solid #dde9f5;
}

.container pre {
	height: 100%;
	float: left;
	cursor: move;
}

.container textarea {
	padding-left: 0px;
	margin: 0px;
	font-size: 12px;
	resize: none;
	outline: none;
	overflow: hidden;
	border: none;
}

.container .resize {
	height: 6px;
	width: 6px;
	position: absolute;
	bottom: 0px;
	right: 0px;
	overflow: hidden;
	cursor: nw-resize;
	background-color: #aaaaaa;
}
</style>
<script type="text/javascript">
$().ready(function() {

	var $inputForm = $("#inputForm");
	var $content = $("#content");
	var $addTag = $("#addTag");
	var $tagOption = $("#tagOption a");
	var $deleteTag = $("#deleteTag");
	var $container = $("#container");
	var $browserButton = $("#browserButton");
	var $background = $("#background");
	var $width = $("#width");
	var $height = $("#height");
	var zIndex = 1;
	
	[@flash_message /]
	
	// 添加标签
	$addTag.mouseover(function() {
		var $this = $(this);
		var offset = $this.offset();
		var $menuWrap = $this.closest("div.menuWrap");
		var $popupMenu = $menuWrap.children("div.popupMenu");
		$popupMenu.css({left: offset.left, top: offset.top + $this.height() + 2}).show();
		$menuWrap.mouseleave(function() {
			$popupMenu.hide();
		});
	});
	
	// 添加选项
	$tagOption.click(function() {
		var $this = $(this);
		var value = $this.attr("val");
		if (value != "") {
			var $item = $('<div class="item"><pre>' + value + '<\/pre><div class="resize"><\/div><\/div>').appendTo($container);
			$item.drag("start", function(ev, dd) {
				var $this = $(this);
				dd.width = $this.width();
				dd.height = $this.height();
				dd.limit = {
					right: $container.innerWidth() - $this.outerWidth(),
					bottom: $container.innerHeight() - $this.outerHeight()
				};
				dd.isResize = $(ev.target).hasClass("resize");
			}).drag(function(ev, dd) {
				var $this = $(this);
				if (dd.isResize) {
					$this.css({
						width: Math.max(20, Math.min(dd.width + dd.deltaX, $container.innerWidth() - $this.position().left) - 2),
						height: Math.max(20, Math.min(dd.height + dd.deltaY, $container.innerHeight() - $this.position().top) - 2)
					}).find("textarea").blur();
				} else {
					$this.css({
						top: Math.min(dd.limit.bottom, Math.max(0, dd.offsetY)),
						left: Math.min(dd.limit.right, Math.max(0, dd.offsetX))
					});
				}
			}, {relative: true}).mousedown(function() {
				$(this).css("z-index", zIndex++);
			}).click(function() {
				var $this = $(this);
				$container.find("div.item").not($this).removeClass("selected");
				$this.toggleClass("selected");
			}).dblclick(function() {
				var $this = $(this);
				if ($this.find("textarea").size() == 0) {
					var $pre = $this.find("pre");
					var value = $pre.hide().text($pre.html()).html();
					$('<textarea>' + value + '<\/textarea>').replaceAll($pre).width($this.innerWidth() - 6).height($this.innerHeight() - 6).blur(function() {
						var $this = $(this);
						$this.replaceWith('<pre>' + $this.val() + '<\/pre>');
					}).focus();
				}
			});
		}
		$this.closest("div.popupMenu").hide();
		return false;
	});
	
	// 删除标签
	$deleteTag.click(function() {
		$container.find("div.selected").remove();
		return false;
	});
	
	// 单据背景图
	$browserButton.browser({
		callback: function(url) {
			$container.css({
				background: "url(" + url + ") 0px 0px no-repeat"
			});
		}
	});
	
	$background.bind("input propertychange change", function() {
		$container.css({
			background: "url(" + $background.val() + ") 0px 0px no-repeat"
		});
	});
	
	// 宽度
	$width.bind("input propertychange change", function() {
		$container.width($width.val());
	});
	
	// 高度
	$height.bind("input propertychange change", function() {
		$container.height($height.val());
	});
	
	// 表单验证
	$inputForm.validate({
		rules: {
			name: "required",
			width: {
				required: true,
				integer: true,
				min: 1
			},
			height: {
				required: true,
				integer: true,
				min: 1
			},
			offsetX: {
				required: true,
				integer: true
			},
			offsetY: {
				required: true,
				integer: true
			}
		},
		submitHandler: function(form) {
			if ($.trim($container.html()) == "") {
				$.message("warn", "${message("admin.deliveryTemplate.emptyNotAllow")}");
				return false;
			}
			$content.val($container.html());
			form.submit();
		}
	});

});
</script>
</head>
<body>
	<div class="path">
		<a href="${base}/admin/common/index.jhtml">${message("admin.path.index")}</a> &raquo; ${message("admin.deliveryTemplate.add")}
	</div>
	<form id="inputForm" action="save.jhtml" method="post">
		<input type="hidden" id="content" name="content" />
		<table class="input">
			<tr>
				<th>
					<span class="requiredField">*</span>${message("DeliveryTemplate.name")}:
				</th>
				<td>
					<input type="text" name="name" class="text" maxlength="200" />
				</td>
			</tr>
			<tr>
				<th>
					${message("admin.common.handle")}:
				</th>
				<td>
					<div class="menuWrap">
						<a href="javascript:;" id="addTag" class="button">${message("admin.deliveryTemplate.addTags")}</a>
						<div class="popupMenu">
							<ul id="tagOption">
								<li>
									<a href="javascript:;" val="[#noparse]${deliveryCenter.name}[/#noparse]">${message("admin.deliveryTemplate.deliveryCenterName")}</a>
								</li>
								<li>
									<a href="javascript:;" val="[#noparse]${deliveryCenter.contact}[/#noparse]">${message("admin.deliveryTemplate.deliveryCenterContact")}</a>
								</li>
								<li>
									<a href="javascript:;" val="[#noparse]${deliveryCenter.areaName}[/#noparse]">${message("admin.deliveryTemplate.deliveryCenterArea")}</a>
								</li>
								<li>
									<a href="javascript:;" val="[#noparse]${deliveryCenter.address}[/#noparse]">${message("admin.deliveryTemplate.deliveryCenterAddress")}</a>
								</li>
								<li>
									<a href="javascript:;" val="[#noparse]${deliveryCenter.zipCode}[/#noparse]">${message("admin.deliveryTemplate.deliveryCenterZipCode")}</a>
								</li>
								<li>
									<a href="javascript:;" val="[#noparse]${deliveryCenter.phone}[/#noparse]">${message("admin.deliveryTemplate.deliveryCenterPhone")}</a>
								</li>
								<li>
									<a href="javascript:;" val="[#noparse]${deliveryCenter.mobile}[/#noparse]">${message("admin.deliveryTemplate.deliveryCenterMobile")}</a>
								</li>
								<li>
									<a href="javascript:;" val="[#noparse]${order.consignee}[/#noparse]">${message("admin.deliveryTemplate.orderConsignee")}</a>
								</li>
								<li>
									<a href="javascript:;" val="[#noparse]${order.areaName}[/#noparse]">${message("admin.deliveryTemplate.orderAreaName")}</a>
								</li>
								<li>
									<a href="javascript:;" val="[#noparse]${order.address}[/#noparse]">${message("admin.deliveryTemplate.orderAddress")}</a>
								</li>
								<li>
									<a href="javascript:;" val="[#noparse]${order.zipCode}[/#noparse]">${message("admin.deliveryTemplate.orderZipCode")}</a>
								</li>
								<li>
									<a href="javascript:;" val="[#noparse]${order.phone}[/#noparse]">${message("admin.deliveryTemplate.orderPhone")}</a>
								</li>
								<li>
									<a href="javascript:;" val="[#noparse]${order.sn}[/#noparse]">${message("admin.deliveryTemplate.orderSn")}</a>
								</li>
								<li>
									<a href="javascript:;" val="[#noparse]${order.freight}[/#noparse]">${message("admin.deliveryTemplate.orderFreight")}</a>
								</li>
								<li>
									<a href="javascript:;" val="[#noparse]${order.fee}[/#noparse]">${message("admin.deliveryTemplate.orderFee")}</a>
								</li>
								<li>
									<a href="javascript:;" val="[#noparse]${order.amountPaid}[/#noparse]">${message("admin.deliveryTemplate.orderAmountPaid")}</a>
								</li>
								<li>
									<a href="javascript:;" val="[#noparse]${order.weight}[/#noparse]">${message("admin.deliveryTemplate.orderWeight")}</a>
								</li>
								<li>
									<a href="javascript:;" val="[#noparse]${order.quantity}[/#noparse]">${message("admin.deliveryTemplate.orderQuantity")}</a>
								</li>
								<li>
									<a href="javascript:;" val="[#noparse]${currency(order.amount, true)}[/#noparse]">${message("admin.deliveryTemplate.orderAmount")}</a>
								</li>
								<li>
									<a href="javascript:;" val="[#noparse]${order.memo}[/#noparse]">${message("admin.deliveryTemplate.orderMemo")}</a>
								</li>
								<li>
									<a href="javascript:;" val="[#noparse]${setting.siteName}[/#noparse]">${message("admin.deliveryTemplate.siteName")}</a>
								</li>
								<li>
									<a href="javascript:;" val="[#noparse]${setting.siteUrl}[/#noparse]">${message("admin.deliveryTemplate.siteUrl")}</a>
								</li>
								<li>
									<a href="javascript:;" val="[#noparse]${setting.address}[/#noparse]">${message("admin.deliveryTemplate.siteAddress")}</a>
								</li>
								<li>
									<a href="javascript:;" val="[#noparse]${setting.phone}[/#noparse]">${message("admin.deliveryTemplate.sitePhone")}</a>
								</li>
								<li>
									<a href="javascript:;" val="[#noparse]${setting.zipCode}[/#noparse]">${message("admin.deliveryTemplate.siteZipCode")}</a>
								</li>
								<li>
									<a href="javascript:;" val="[#noparse]${setting.email}[/#noparse]">${message("admin.deliveryTemplate.siteEmail")}</a>
								</li>
								<li>
									<a href="javascript:;" val="[#noparse]${.now?string('yyyy-MM-dd')}[/#noparse]">${message("admin.deliveryTemplate.now")}</a>
								</li>
							</ul>
						</div>
					</div>
					<a href="javascript:;" id="deleteTag" class="button">${message("admin.deliveryTemplate.deleteTags")}</a>
				</td>
			</tr>
			<tr>
				<th>
					${message("DeliveryTemplate.content")}:
				</th>
				<td>
					<div id="container" class="container"></div>
				</td>
			</tr>
			<tr>
				<th>
					${message("DeliveryTemplate.background")}:
				</th>
				<td>
					<span class="fieldSet">
						<input type="text" id="background" name="background" class="text" maxlength="200" />
						<input type="button" id="browserButton" class="button" value="${message("admin.browser.select")}" />
					</span>
				</td>
			</tr>
			<tr>
				<th>
					<span class="requiredField">*</span>${message("DeliveryTemplate.width")}:
				</th>
				<td>
					<input type="text" id="width" name="width" class="text" value="1000" maxlength="9" />
				</td>
			</tr>
			<tr>
				<th>
					<span class="requiredField">*</span>${message("DeliveryTemplate.height")}:
				</th>
				<td>
					<input type="text" id="height" name="height" class="text" value="400" maxlength="9" />
				</td>
			</tr>
			<tr>
				<th>
					<span class="requiredField">*</span>${message("DeliveryTemplate.offsetX")}:
				</th>
				<td>
					<input type="text" name="offsetX" class="text" value="0" maxlength="9" />
				</td>
			</tr>
			<tr>
				<th>
					<span class="requiredField">*</span>${message("DeliveryTemplate.offsetY")}:
				</th>
				<td>
					<input type="text" name="offsetY" class="text" value="0" maxlength="9" />
				</td>
			</tr>
			<tr>
				<th>
					${message("DeliveryTemplate.isDefault")}:
				</th>
				<td>
					<input type="checkbox" name="isDefault" />
					<input type="hidden" name="_isDefault" value="false" />
				</td>
			</tr>
			<tr>
				<th>
					${message("DeliveryTemplate.memo")}
				</th>
				<td>
					<input type="text" name="memo" class="text" maxlength="200" />
				</td>
			</tr>
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