package com.lemon.lemonbiz.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lemon.lemonbiz.member.model.service.MemberService;
import com.lemon.lemonbiz.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member")
@SessionAttributes({"loginMember"})
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@RequestMapping(value = "/memberEnroll.do", method = RequestMethod.POST)
	public String memberEnroll(RedirectAttributes redirectAttr,
							   Member member) {
		
		String rawPassword = member.getMemberId();
		String encodedPassword = bcryptPasswordEncoder.encode(rawPassword);
		member.setPassword(encodedPassword);
		
		if(memberService.selectOneMember(member.getMemberId()) != null) {
			String msg = "이미 존재하는 사원 번호 입니다.";
			redirectAttr.addFlashAttribute("msg", msg);
			return "redirect:/manager/insertMember.do";
		}
		
		int result = 0;
		try {
			result = memberService.insertMember(member);
		} catch(Exception e) {
			log.debug("사원 등록 실패");
		}
		
		String msg = result > 0 ? "사원 등록에 성공했습니다." : "사원 등록에 실패했습니다.";
		redirectAttr.addFlashAttribute("msg", msg);
		
		return "redirect:/manager/insertMember.do";
	}

	@RequestMapping(value = "/memberLogin.do", method = RequestMethod.POST)
	public String memberLogin(@RequestParam("memberId") String memberId, 
							  @RequestParam("password") String password,
							  RedirectAttributes redirectAttr,
							  Model model) {
		Member loginMember = null;
		try {
			loginMember = memberService.selectOneMember(memberId);
			// 로그인 성공
			if(loginMember != null && 
			   bcryptPasswordEncoder.matches(password, loginMember.getPassword())){
				model.addAttribute("loginMember", loginMember);
				return "redirect:/";
			} else {
				// 로그인 실패
				log.debug("로그인 실패");
				redirectAttr.addFlashAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
				return "redirect:memberLogin.do";
			}
		} catch(Exception e) {
			// 오류
			log.debug("오류");
			redirectAttr.addFlashAttribute("msg", "로그인 처리 중 오류가 발생했습니다.");
			return "redirect:memberLogin.do";
		}
		
	}
	
	@RequestMapping("/memberLogout.do")
	public String memberLogout(SessionStatus sessionStatus) {

		log.debug("로그아웃 요청");
		
		if(!sessionStatus.isComplete())
			sessionStatus.setComplete();
		
		return "redirect:/";
	}
	
	@RequestMapping(value = "/memberLogin.do", method = RequestMethod.GET)
	public String memberLogin() {
		
		return "forward:/WEB-INF/views/login/memberLogin.jsp";
	}
	
	@RequestMapping(value = "/myPage.do", method = RequestMethod.GET)
	public String myPage() {
		
		return "forward:/WEB-INF/views/mypage/showMyPage.jsp";
	}

}
