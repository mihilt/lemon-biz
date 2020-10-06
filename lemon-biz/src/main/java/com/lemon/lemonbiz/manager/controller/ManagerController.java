package com.lemon.lemonbiz.manager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/manager")
public class ManagerController {
	
	
	@RequestMapping(value = "/insertMember.do", method = RequestMethod.GET)
	public String insertMember() {
		
		
		return "manager/insertMember";
	}

	

}
