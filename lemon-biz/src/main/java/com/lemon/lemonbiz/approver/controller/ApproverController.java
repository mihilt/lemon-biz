package com.lemon.lemonbiz.approver.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lemon.lemonbiz.approver.model.service.ApproverService;

@Controller
@RequestMapping("/approver")
public class ApproverController {

	@Autowired
	private ApproverService approverService;
	
	@RequestMapping("/writeForm")
	public String writeForm() {
		
		return "approver/writeForm";
	}
	
	@RequestMapping("/getMemList")
	public String MemberList(Model model) {
		
		
		
		return "";
	}
	
	
}
