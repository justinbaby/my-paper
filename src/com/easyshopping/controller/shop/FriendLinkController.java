/*
 * 

 * 
 */
package com.easyshopping.controller.shop;

import javax.annotation.Resource;

import com.easyshopping.entity.FriendLink.Type;
import com.easyshopping.service.FriendLinkService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Controller - 友情链接
 * 
 * 
 * @version 1.0
 */
@Controller("shopFriendLinkController")
@RequestMapping("/friend_link")
public class FriendLinkController extends BaseController {

	@Resource(name = "friendLinkServiceImpl")
	private FriendLinkService friendLinkService;

	/**
	 * 首页
	 */
	@RequestMapping(method = RequestMethod.GET)
	public String index(ModelMap model) {
		model.addAttribute("textFriendLinks", friendLinkService.findList(Type.text));
		model.addAttribute("imageFriendLinks", friendLinkService.findList(Type.image));
		return "/shop/friend_link/index";
	}

}