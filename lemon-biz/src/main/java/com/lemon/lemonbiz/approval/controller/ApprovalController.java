package com.lemon.lemonbiz.approval.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.taglibs.standard.lang.jstl.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.lemon.lemonbiz.approval.model.service.approvalService;
import com.lemon.lemonbiz.member.controller.MemberController;
import com.lemon.lemonbiz.member.model.vo.Dept;
import com.lemon.lemonbiz.member.model.vo.Member;
import com.sun.org.slf4j.internal.LoggerFactory;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/approval")
@SessionAttributes({"loginMember"})
public class ApprovalController {
	
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
	
	@RequestMapping(value="/approvalSelect.do")
	public String approvalSelect(@RequestParam("node") String node,
								 Model model) {
		
		List<Member> memberList = approvalService.memberList(node);

		log.debug("node = {}",node);
		log.debug("memberList={}",memberList);
		
		model.addAttribute("memberList",memberList);
		
		return "jsonView";
	}
	
	@RequestMapping(value="/selectMember.do",
					method=RequestMethod.POST,
					produces = "application/json; charset=utf8")
	@ResponseBody
	public Map<String, Object> selectMember(@RequestParam("param") String param,
							   Model model) {
		log.debug("11");
		log.debug("param = {}",param);
		Map<String, Object> map = new HashMap<>();
		
		List<Member> selectMember = approvalService.selectMember(param);
		
		map.put("selectMember",selectMember);
		
		return map;
	}
	
	
	@RequestMapping(value="/searchName.do",
					method=RequestMethod.POST,
					produces="application/json; charset=utf8")
	@ResponseBody
	public Map<String, Object> joinMemberList(@RequestParam("param") String param) {
		
		log.debug("param ={}", param);
		Map<String, Object> map = new HashMap<>();
		List<Member> joinMemberList = approvalService.joinMemberlist(param);
		
		map.put("joinMemberList", joinMemberList);
		
		return map;
	}
	
	
}
