package com.lemon.lemonbiz.manager.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lemon.lemonbiz.member.model.service.MemberService;
import com.lemon.lemonbiz.member.model.vo.Dept;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/manager")
public class ManagerController {
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping(value = "/insertMember.do", method = RequestMethod.GET)
	public String insertMember() {
		
		
		return "manager/insertMember";
	}

	@RequestMapping(value = "/manageDept.do", method = RequestMethod.GET)
	public void manageDept(Model model) {
		List<Dept> deptList = memberService.selectDeptList();

		model.addAttribute("deptList", deptList);
	}

}
