/*
 * 

 * 
 */
package com.easyshopping.controller.admin;

import java.util.Iterator;

import javax.annotation.Resource;

import com.easyshopping.Message;
import com.easyshopping.Pageable;
import com.easyshopping.entity.Specification;
import com.easyshopping.entity.Specification.Type;
import com.easyshopping.entity.SpecificationValue;
import com.easyshopping.service.SpecificationService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * Controller - 规格
 * 
 * 
 * @version 1.0
 */
@Controller("adminSpecificationController")
@RequestMapping("/admin/specification")
public class SpecificationController extends BaseController {

	@Resource(name = "specificationServiceImpl")
	private SpecificationService specificationService;

	/**
	 * 添加
	 */
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(ModelMap model) {
		model.addAttribute("types", Type.values());
		return "/admin/specification/add";
	}

	/**
	 * 保存
	 */
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String save(Specification specification, RedirectAttributes redirectAttributes) {
		for (Iterator<SpecificationValue> iterator = specification.getSpecificationValues().iterator(); iterator.hasNext();) {
			SpecificationValue specificationValue = iterator.next();
			if (specificationValue == null || specificationValue.getName() == null) {
				iterator.remove();
			} else {
				if (specification.getType() == Type.text) {
					specificationValue.setImage(null);
				}
				specificationValue.setSpecification(specification);
			}
		}
		if (!isValid(specification)) {
			return ERROR_VIEW;
		}
		specification.setProducts(null);
		specificationService.save(specification);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}

	/**
	 * 编辑
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String edit(Long id, ModelMap model) {
		model.addAttribute("types", Type.values());
		model.addAttribute("specification", specificationService.find(id));
		return "/admin/specification/edit";
	}

	/**
	 * 更新
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(Specification specification, RedirectAttributes redirectAttributes) {
		for (Iterator<SpecificationValue> iterator = specification.getSpecificationValues().iterator(); iterator.hasNext();) {
			SpecificationValue specificationValue = iterator.next();
			if (specificationValue == null || specificationValue.getName() == null) {
				iterator.remove();
			} else {
				if (specification.getType() == Type.text) {
					specificationValue.setImage(null);
				}
				specificationValue.setSpecification(specification);
			}
		}
		if (!isValid(specification)) {
			return ERROR_VIEW;
		}
		specificationService.update(specification, "products");
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}

	/**
	 * 列表
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Pageable pageable, ModelMap model) {
		model.addAttribute("page", specificationService.findPage(pageable));
		return "/admin/specification/list";
	}

	/**
	 * 删除
	 */
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public @ResponseBody
	Message delete(Long[] ids) {
		if (ids != null) {
			for (Long id : ids) {
				Specification specification = specificationService.find(id);
				if (specification != null && specification.getProducts() != null && !specification.getProducts().isEmpty()) {
					return Message.error("admin.specification.deleteExistProductNotAllowed", specification.getName());
				}
			}
			specificationService.delete(ids);
		}
		return SUCCESS_MESSAGE;
	}

}