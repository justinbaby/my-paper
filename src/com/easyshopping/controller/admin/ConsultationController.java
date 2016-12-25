/*
 * 

 * 
 */
package com.easyshopping.controller.admin;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.easyshopping.Message;
import com.easyshopping.Pageable;
import com.easyshopping.entity.Consultation;
import com.easyshopping.service.ConsultationService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * Controller - 咨询
 * 
 * 
 * @version 1.0
 */
@Controller("adminConsultationController")
@RequestMapping("/admin/consultation")
public class ConsultationController extends BaseController {

	@Resource(name = "consultationServiceImpl")
	private ConsultationService consultationService;

	/**
	 * 回复
	 */
	@RequestMapping(value = "/reply", method = RequestMethod.GET)
	public String reply(Long id, ModelMap model) {
		model.addAttribute("consultation", consultationService.find(id));
		return "/admin/consultation/reply";
	}

	/**
	 * 回复
	 */
	@RequestMapping(value = "/reply", method = RequestMethod.POST)
	public String reply(Long id, String content, HttpServletRequest request, RedirectAttributes redirectAttributes) {
		if (!isValid(Consultation.class, "content", content)) {
			return ERROR_VIEW;
		}
		Consultation consultation = consultationService.find(id);
		if (consultation == null) {
			return ERROR_VIEW;
		}
		Consultation replyConsultation = new Consultation();
		replyConsultation.setContent(content);
		replyConsultation.setIp(request.getRemoteAddr());
		consultationService.reply(consultation, replyConsultation);

		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:reply.jhtml?id=" + id;
	}

	/**
	 * 编辑
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String edit(Long id, ModelMap model) {
		model.addAttribute("consultation", consultationService.find(id));
		return "/admin/consultation/edit";
	}

	/**
	 * 更新
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(Long id, @RequestParam(defaultValue = "false") Boolean isShow, RedirectAttributes redirectAttributes) {
		Consultation consultation = consultationService.find(id);
		if (consultation == null) {
			return ERROR_VIEW;
		}
		if (isShow != consultation.getIsShow()) {
			consultation.setIsShow(isShow);
			consultationService.update(consultation);
		}
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}

	/**
	 * 列表
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Pageable pageable, ModelMap model) {
		model.addAttribute("page", consultationService.findPage(null, null, null, pageable));
		return "/admin/consultation/list";
	}

	/**
	 * 删除回复
	 */
	@RequestMapping(value = "/delete_reply", method = RequestMethod.POST)
	public @ResponseBody
	Message deleteReply(Long id) {
		Consultation consultation = consultationService.find(id);
		if (consultation == null || consultation.getForConsultation() == null) {
			return ERROR_MESSAGE;
		}
		consultationService.delete(consultation);
		return SUCCESS_MESSAGE;
	}

	/**
	 * 删除
	 */
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public @ResponseBody
	Message delete(Long[] ids) {
		if (ids != null) {
			consultationService.delete(ids);
		}
		return SUCCESS_MESSAGE;
	}

}