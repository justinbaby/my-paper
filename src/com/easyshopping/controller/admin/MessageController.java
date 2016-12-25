/*
 * 

 * 
 */
package com.easyshopping.controller.admin;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.easyshopping.Pageable;
import com.easyshopping.entity.Member;
import com.easyshopping.entity.Message;
import com.easyshopping.service.MemberService;
import com.easyshopping.service.MessageService;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * Controller - 消息
 * 
 * 
 * @version 1.0
 */
@Controller("adminMessageController")
@RequestMapping("/admin/message")
public class MessageController extends BaseController {

	@Resource(name = "messageServiceImpl")
	MessageService messageService;
	@Resource(name = "memberServiceImpl")
	MemberService memberService;

	/**
	 * 检查用户名是否合法
	 */
	@RequestMapping(value = "/check_username", method = RequestMethod.GET)
	public @ResponseBody
	boolean checkUsername(String username) {
		if (memberService.usernameExists(username)) {
			return true;
		}
		return false;
	}

	/**
	 * 发送
	 */
	@RequestMapping(value = "/send", method = RequestMethod.GET)
	public String send(Long draftMessageId, Model model) {
		Message draftMessage = messageService.find(draftMessageId);
		if (draftMessage != null && draftMessage.getIsDraft() && draftMessage.getSender() == null) {
			model.addAttribute("draftMessage", draftMessage);
		}
		return "admin/message/send";
	}

	/**
	 * 发送
	 */
	@RequestMapping(value = "/send", method = RequestMethod.POST)
	public String send(Long draftMessageId, String username, String title, String content, @RequestParam(defaultValue = "false") Boolean isDraft, HttpServletRequest request, RedirectAttributes redirectAttributes) {
		if (!isValid(Message.class, "content", content)) {
			return ERROR_VIEW;
		}
		Message draftMessage = messageService.find(draftMessageId);
		if (draftMessage != null && draftMessage.getIsDraft() && draftMessage.getSender() == null) {
			messageService.delete(draftMessage);
		}
		Member receiver = null;
		if (StringUtils.isNotEmpty(username)) {
			receiver = memberService.findByUsername(username);
			if (receiver == null) {
				return ERROR_VIEW;
			}
		}
		Message message = new Message();
		message.setTitle(title);
		message.setContent(content);
		message.setIp(request.getRemoteAddr());
		message.setIsDraft(isDraft);
		message.setSenderRead(true);
		message.setReceiverRead(false);
		message.setSenderDelete(false);
		message.setReceiverDelete(false);
		message.setSender(null);
		message.setReceiver(receiver);
		message.setForMessage(null);
		message.setReplyMessages(null);
		messageService.save(message);
		if (isDraft) {
			addFlashMessage(redirectAttributes, com.easyshopping.Message.success("admin.message.saveDraftSuccess"));
			return "redirect:draft.jhtml";
		} else {
			addFlashMessage(redirectAttributes, com.easyshopping.Message.success("admin.message.sendSuccess"));
			return "redirect:list.jhtml";
		}
	}

	/**
	 * 查看
	 */
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(Long id, Model model) {
		Message message = messageService.find(id);
		if (message == null || message.getIsDraft() || message.getForMessage() != null) {
			return ERROR_VIEW;
		}
		if ((message.getSender() != null && message.getReceiver() != null) || (message.getReceiver() == null && message.getReceiverDelete()) || (message.getSender() == null && message.getSenderDelete())) {
			return ERROR_VIEW;
		}
		if (message.getReceiver() == null) {
			message.setReceiverRead(true);
		} else {
			message.setSenderRead(true);
		}
		messageService.update(message);
		model.addAttribute("adminMessage", message);
		return "/admin/message/view";
	}

	/**
	 * 回复
	 */
	@RequestMapping(value = "/reply", method = RequestMethod.POST)
	public String reply(Long id, String content, HttpServletRequest request, RedirectAttributes redirectAttributes) {
		if (!isValid(Message.class, "content", content)) {
			return ERROR_VIEW;
		}
		Message forMessage = messageService.find(id);
		if (forMessage == null || forMessage.getIsDraft() || forMessage.getForMessage() != null) {
			return ERROR_VIEW;
		}
		if ((forMessage.getSender() != null && forMessage.getReceiver() != null) || (forMessage.getReceiver() == null && forMessage.getReceiverDelete()) || (forMessage.getSender() == null && forMessage.getSenderDelete())) {
			return ERROR_VIEW;
		}
		Message message = new Message();
		message.setTitle("reply: " + forMessage.getTitle());
		message.setContent(content);
		message.setIp(request.getRemoteAddr());
		message.setIsDraft(false);
		message.setSenderRead(true);
		message.setReceiverRead(false);
		message.setSenderDelete(false);
		message.setReceiverDelete(false);
		message.setSender(null);
		message.setReceiver(forMessage.getReceiver() == null ? forMessage.getSender() : forMessage.getReceiver());
		if ((forMessage.getReceiver() == null && !forMessage.getSenderDelete()) || (forMessage.getSender() == null && !forMessage.getReceiverDelete())) {
			message.setForMessage(forMessage);
		}
		message.setReplyMessages(null);
		messageService.save(message);

		if (forMessage.getSender() == null) {
			forMessage.setSenderRead(true);
			forMessage.setReceiverRead(false);
		} else {
			forMessage.setSenderRead(false);
			forMessage.setReceiverRead(true);
		}
		messageService.update(forMessage);

		if ((forMessage.getReceiver() == null && !forMessage.getSenderDelete()) || (forMessage.getSender() == null && !forMessage.getReceiverDelete())) {
			addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
			return "redirect:view.jhtml?id=" + forMessage.getId();
		} else {
			addFlashMessage(redirectAttributes, com.easyshopping.Message.success("admin.message.replySuccess"));
			return "redirect:list.jhtml";
		}
	}

	/**
	 * 列表
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Pageable pageable, Model model) {
		model.addAttribute("page", messageService.findPage(null, pageable));
		return "/admin/message/list";
	}

	/**
	 * 草稿箱
	 */
	@RequestMapping(value = "/draft", method = RequestMethod.GET)
	public String draft(Pageable pageable, Model model) {
		model.addAttribute("page", messageService.findDraftPage(null, pageable));
		return "/admin/message/draft";
	}

	/**
	 * 删除
	 */
	@RequestMapping(value = "delete", method = RequestMethod.POST)
	public @ResponseBody
	com.easyshopping.Message delete(Long[] ids) {
		if (ids != null) {
			for (Long id : ids) {
				messageService.delete(id, null);
			}
		}
		return SUCCESS_MESSAGE;
	}

}