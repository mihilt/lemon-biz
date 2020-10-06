package com.lemon.lemonbiz.manager.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/manager")
public class ManagerController {
	
	private static Logger log = LoggerFactory.getLogger(ManagerController.class);
	
	@RequestMapping(value = "/createMember.do", method = RequestMethod.GET)
	public String createMember() {
		
		
		return "manager/memberEnroll";
	}

	

}
