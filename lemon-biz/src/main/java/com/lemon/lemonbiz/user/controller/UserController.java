package com.lemon.lemonbiz.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lemon.lemonbiz.user.model.service.UserService;


@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@RequestMapping(value = "/test.do", 
					method = RequestMethod.POST)
	public void test() {
		
		String test = userService.test();
		
		System.out.println(test);
	}

}

