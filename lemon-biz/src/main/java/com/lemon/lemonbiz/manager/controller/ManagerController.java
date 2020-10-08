package com.lemon.lemonbiz.manager.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lemon.lemonbiz.manager.model.service.ManagerService;
import com.lemon.lemonbiz.member.model.service.MemberService;
import com.lemon.lemonbiz.member.model.vo.Dept;
import com.lemon.lemonbiz.member.model.vo.Rank;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/manager")
public class ManagerController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private ManagerService managerService;
	
	@RequestMapping(value = "/insertMember.do", method = RequestMethod.GET)
	public void insertMember(Model model) {
		List<Dept> deptList = memberService.selectDeptList();
		List<Rank> rankList = memberService.selectRankList();
		
		
		model.addAttribute("deptList", deptList);
		model.addAttribute("rankList", rankList);
		
	}

	@RequestMapping(value = "/manageDept.do", method = RequestMethod.GET)
	public void manageDept(Model model) {
		List<Dept> deptList = memberService.selectDeptList();

		model.addAttribute("deptList", deptList);
	}

	@RequestMapping(value = "/insertDept.do", method = RequestMethod.GET)
	public void insertDept() {
		
	}
	
	@RequestMapping(value = "/manageRank.do", method = RequestMethod.GET)
	public void manageRank() {
		
	}
	
	@RequestMapping(value = "/insertRank.do", method = RequestMethod.GET)
	public void insertRankGet() {
		
	}
	
	@RequestMapping(value = "/insertRank.do", method = RequestMethod.POST)
	public String insertRankPost(Rank rank, RedirectAttributes redirectAttr) {
		
		int result = managerService.insertRank(rank);
		
		redirectAttr.addFlashAttribute("msg", (result > 0) ? "직급 생성을 완료하였습니다." : "직급 생성에 오류가 발생했습니다.");
		
		return "redirect:insertRank.do";
	}
	
}
