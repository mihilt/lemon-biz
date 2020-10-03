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

	@RequestMapping(value = "/memberLogin.do", method = RequestMethod.POST)
	public String memberLogin(@RequestParam("memberId") String memberId, 
							  @RequestParam("password") String password,
							  RedirectAttributes redirectAttr) {

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
