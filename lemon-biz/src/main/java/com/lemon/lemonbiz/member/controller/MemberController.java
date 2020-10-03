package com.lemon.lemonbiz.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lemon.lemonbiz.member.model.service.MemberService;
import com.lemon.lemonbiz.member.model.vo.Member;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping(value = "/memberEnroll.do", method = RequestMethod.POST)
	public String memberEnroll(@RequestParam("memberId") String memberId,
							   RedirectAttributes redirectAttr) {
		if(memberService.selectOneMember(memberId) != null) {
			String msg = "이미 존재하는 아이디 입니다.";
			redirectAttr.addFlashAttribute("msg", msg);
			return "redirect:/";
		}
		
		int result = memberService.insertMember(memberId);
		
		String msg = result > 0 ? "사원 등록에 성공했습니다." : "사원 등록에 실패했습니다.";
		redirectAttr.addFlashAttribute("msg", msg);
		
		return "redirect:/";
	}

	@RequestMapping(value = "/memberLogin.do", method = RequestMethod.POST)
	public String memberLogin(@RequestParam("memberId") String memberId, 
							  @RequestParam("password") String password) {

		Member loginMember = memberService.selectOneMember(memberId);

		System.out.println(loginMember);
		
		// 로그인 성공
		if(loginMember != null && password.equals(loginMember.getPassword())) {
			System.out.println("성공");
		}
		// 로그인 실패
		else {
			System.out.println("실패");
		}
		
		return "redirect:/";
	}

}
