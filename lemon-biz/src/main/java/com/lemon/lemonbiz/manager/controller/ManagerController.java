package com.lemon.lemonbiz.manager.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lemon.lemonbiz.manager.model.service.ManagerService;
import com.lemon.lemonbiz.member.model.service.MemberService;
import com.lemon.lemonbiz.member.model.vo.Dept;
import com.lemon.lemonbiz.member.model.vo.Member;
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
	public void insertDeptGet() {
		
	}
	
	@RequestMapping(value = "/insertDept.do", method = RequestMethod.POST)
	public String insertDeptPost(Dept dept, RedirectAttributes redirectAttr) {
		
		Dept dept1 = managerService.selectOneDept(dept);
		Dept dept2 = managerService.selectOneRefDept(dept);
		
		if(dept1 == null) {
			
			if(dept2 == null) {
				
				redirectAttr.addFlashAttribute("msg", "존재하는 상위 부서가 없습니다.");
				
				return "redirect:/manager/insertDept.do";
				
			}
			
			int result = managerService.insertDept(dept);
			redirectAttr.addFlashAttribute("msg", "생성을 완료하였습니다.");
			
		} else {
			
			redirectAttr.addFlashAttribute("msg", "이미 존재하는 부서 번호 입니다.");
			
		}
		
		return "redirect:/manager/insertDept.do";
		
	}
	
	
	@RequestMapping(value = "/manageRank.do", method = RequestMethod.GET)
	public void manageRank(Model model) {
		List<Rank> rankList = memberService.selectRankList();
		model.addAttribute("rankList", rankList);
		
	}
	
	@RequestMapping(value = "/manageRank/update.do", method = RequestMethod.GET)
	public String updateRank(Rank rank, RedirectAttributes redirectAttr) {
		
		int result = managerService.updateRank(rank);
		
		redirectAttr.addFlashAttribute("msg", (result > 0) ? "직급 수정을 완료하였습니다." : "직급 수정에 오류가 발생했습니다.");
		
		return "redirect:/manager/manageRank.do";
	}
	
	@RequestMapping(value = "/manageRank/delete.do", method = RequestMethod.GET)
	public String deleteRank(Rank rank, RedirectAttributes redirectAttr) {
		
		int result = managerService.deleteRank(rank);
		
		redirectAttr.addFlashAttribute("msg", (result > 0) ? "직급 삭제를 완료하였습니다." : "직급 삭제에 오류가 발생했습니다.");
		
		return "redirect:/manager/manageRank.do";
	}
	
	@RequestMapping(value = "manageDept/delete.do", method = RequestMethod.GET)
	public String deleteDept(Dept dept, RedirectAttributes redirectAttr) {
		
		int result = managerService.deleteDept(dept);
		
		redirectAttr.addFlashAttribute("msg", (result > 0) ? "부서 삭제를 완료하였습니다." : "부서 삭제에 오류가 발생했습니다.");
		
		return "redirect:/manager/manageDept.do";
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
	
	
	@RequestMapping(value = "/manageMember.do", method = RequestMethod.GET)
	public void manageMember(Model model) {
		
		List<Member> memberList = memberService.selectMemberList();
		
		model.addAttribute("memberList", memberList);
		
	}
	
	@RequestMapping(value = "/manageMember/detail.do", method = RequestMethod.GET)
	public String manageMemberDetail(Model model, Member getMember) {
		
		Member member = memberService.selectOneMember(getMember.getMemberId());
		List<Dept> deptList = memberService.selectDeptList();
		List<Rank> rankList = memberService.selectRankList();
		
		
		model.addAttribute("deptList", deptList);
		model.addAttribute("rankList", rankList);
		model.addAttribute("member", member);
		
		return "forward:/WEB-INF/views/manager/memberDetail.jsp";
		
	}
	
	@RequestMapping(value = "/manageMember/detail/update.do", method = RequestMethod.GET)
	public String manageMemberDetailUpdate(Model model, Member member, RedirectAttributes redirectAttr) {
		
		int result = memberService.updateMember(member);
		redirectAttr.addFlashAttribute("msg", (result > 0) ? "수정을 완료하였습니다." : "수정에 오류가 발생했습니다.");
		
		return "redirect:/manager/manageMember/detail.do?memberId="+member.getMemberId();
		
	}
	
}
