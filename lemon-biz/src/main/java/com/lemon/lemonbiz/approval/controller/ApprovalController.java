package com.lemon.lemonbiz.approval.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lemon.lemonbiz.approval.model.service.approvalService;
import com.lemon.lemonbiz.member.model.vo.Dept;

@Controller
@RequestMapping("/approval")
public class ApprovalController {
	
	private static Logger log = LoggerFactory.getLogger(ApprovalController.class);

	@Autowired
	private approvalService approvalService;
	
	@RequestMapping("/writeForm.html")
	public String writeForm(Model model) {
		
		List<Dept> dept = approvalService.deptList();
		List<Dept> child = approvalService.child();
		List<Dept> child2 = approvalService.child2();
		log.debug("dept = {}",dept);
		log.debug("child = {}",child);
		log.debug("child2 = {}",child2);
		
		model.addAttribute("dept",dept);
		model.addAttribute("child",child);
		model.addAttribute("child2",child2);
		
		return "approval/writeForm";
	}
	
	//@RequestMapping("/tree.do")
	public String approval(Model model) {
		
		List<Dept> dept = approvalService.deptList();
		
		
		log.debug("dept = {}",dept);
		
		return "";
	}
	
	
}