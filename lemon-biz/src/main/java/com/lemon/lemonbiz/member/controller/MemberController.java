package com.lemon.lemonbiz.member.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.lemon.lemonbiz.member.model.service.MemberService;
import com.lemon.lemonbiz.member.model.vo.Dept;
import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.member.model.vo.Rank;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member")
@SessionAttributes({ "loginMember" })
public class MemberController {

	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	private MemberService memberService;

	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	@RequestMapping(value = "/memberEnroll.do", method = RequestMethod.POST)
	public String memberEnroll(RedirectAttributes redirectAttr, Member member) {

		log.debug("member={}" + member);

		// 존재하는 사원인지 검사
		if (memberService.selectOneMember(member.getMemberId()) != null) {
			String msg = "이미 존재하는 사원 번호 입니다.";
			redirectAttr.addFlashAttribute("msg", msg);
			return "redirect:/manager/insertMember.do";
		}

		// BCryptPasswordEncoder
		String rawPassword = member.getMemberId();
		String encodedPassword = bcryptPasswordEncoder.encode(rawPassword);
		member.setPassword(encodedPassword);

		// 사원 등록
		int result = 0;

		try {
			result = memberService.insertMember(member);

		} catch (Exception e) {
			log.debug("사원 등록 실패");
		}

		String msg = result > 0 ? "사원 등록에 성공했습니다." : "사원 등록에 실패했습니다.";
		redirectAttr.addFlashAttribute("msg", msg);

		return "redirect:/manager/insertMember.do";
	}

	@RequestMapping(value = "/memberLogin.do", method = RequestMethod.POST)
	public String memberLogin(@RequestParam("memberId") String memberId, @RequestParam("password") String password,
			RedirectAttributes redirectAttr, Model model) {
		Member loginMember = null;
		try {
			loginMember = memberService.selectOneMember(memberId);
			// 로그인 성공
			if (loginMember != null && bcryptPasswordEncoder.matches(password, loginMember.getPassword())) {
				model.addAttribute("loginMember", loginMember);
				return "redirect:/";
			} else {
				// 로그인 실패
				log.debug("로그인 실패");
				redirectAttr.addFlashAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
				return "redirect:memberLogin.do";
			}
		} catch (Exception e) {
			// 오류
			log.debug("오류");
			redirectAttr.addFlashAttribute("msg", "로그인 처리 중 오류가 발생했습니다.");
			return "redirect:memberLogin.do";
		}

	}

	@RequestMapping("/memberLogout.do")
	public String memberLogout(SessionStatus sessionStatus) {

		log.debug("로그아웃 요청");

		if (!sessionStatus.isComplete())
			sessionStatus.setComplete();

		return "redirect:/";
	}

	@RequestMapping(value = "/memberLogin.do", method = RequestMethod.GET)
	public String memberLogin() {

		return "forward:/WEB-INF/views/login/memberLogin.jsp";
	}

	@RequestMapping(value = "/myPage.do", method = RequestMethod.GET)
	public String myPage(Model model) {

		List<Dept> deptList = memberService.selectDeptList();
		List<Rank> rankList = memberService.selectRankList();

		model.addAttribute("deptList", deptList);
		model.addAttribute("rankList", rankList);

		return "forward:/WEB-INF/views/mypage/showMyPage.jsp";
	}

	@RequestMapping(value = "memberUpdate.do", method = RequestMethod.POST)
	public String update(Member member, RedirectAttributes redirectAttr, Model model, HttpServletRequest request,
			@RequestParam(value = "profile_img", required = false) MultipartFile[] profileImgs)
			throws IllegalStateException, IOException {

		String saveDirectory = request.getServletContext().getRealPath("/resources/upload/profile_images");

		for (MultipartFile profileImg : profileImgs) {
			// 파일을 선택하지 않고 전송한 경우
			if (profileImg.isEmpty())
				continue;

			int beginIndex = profileImg.getOriginalFilename().lastIndexOf('.');
			String ext = profileImg.getOriginalFilename().substring(beginIndex);

			// 메모리의 파일 -> 서버컴퓨터 디렉토리 저장 transferTo
			File dest = new File(saveDirectory, member.getMemberId() + ext);
			profileImg.transferTo(dest);

		}

		int result = memberService.updateMember(member);
		redirectAttr.addFlashAttribute("msg", (result > 0) ? "수정을 완료하였습니다." : "수정에 오류가 발생했습니다.");
		Member loginMember = memberService.selectOneMember(member.getMemberId());
		model.addAttribute("loginMember", loginMember);

		return "redirect:myPage.do";
	}

	@RequestMapping(value = "updatePassword.do", method = RequestMethod.GET)
	public String updatePassword() {
		return "forward:/WEB-INF/views/mypage/updatePassword.jsp";
	}

	@RequestMapping(value = "updatePassword.do", method = RequestMethod.POST)
	public String updatePasswordPost(Member member, @RequestParam("change_pwd") String changePwd,
			RedirectAttributes redirectAttr) {

		Member loginMember = null;

		try {
			loginMember = memberService.selectOneMember(member.getMemberId());

			if (loginMember != null && bcryptPasswordEncoder.matches(member.getPassword(), loginMember.getPassword())) {

				String encodedPassword = bcryptPasswordEncoder.encode(changePwd);
				loginMember.setPassword(encodedPassword);

				int result = memberService.updatePassword(loginMember);

				redirectAttr.addFlashAttribute("msg", (result > 0) ? "비밀번호 변경이 완료되었습니다." : "비밀변호 변경 처리 중 오류가 발생했습니다.");

				return "redirect:updatePassword.do";
			} else {
				redirectAttr.addFlashAttribute("msg", "현재 비밀번호가 일치하지 않습니다.");
				return "redirect:updatePassword.do";
			}
		} catch (Exception e) {
			redirectAttr.addFlashAttribute("msg", "비밀변호 변경 처리 중 오류가 발생했습니다.");
			return "redirect:updatePassword.do";
		}

	}

	@RequestMapping(value = "organization.do", method = RequestMethod.GET)
	public void organization(Model model) {
		List<Dept> hierarchicalDeptList = memberService.hierarchicalDeptList();
		List<Member> memberList = memberService.selectMemberList();

		model.addAttribute("hierarchicalDeptList", hierarchicalDeptList);
		model.addAttribute("memberList", memberList);

	}

	@RequestMapping(value = "selectOneMemberAjax.do", method = RequestMethod.GET)
	public void selectOneMemberAjax(@RequestParam("memberId") String memberId, HttpServletResponse response) {
		Member member = memberService.selectOneMember(memberId);

		response.setContentType("application/json; charset=utf-8");

		Gson gson = new Gson();
		try {
			gson.toJson(member, response.getWriter());
		} catch (JsonIOException | IOException e) {
			e.printStackTrace();
		}

	}

	@RequestMapping(value = "memberForgotPassword.do", method = RequestMethod.GET)
	public String memberForgotPasswordGet() {
		return "forward:/WEB-INF/views/login/memberForgotPassword.jsp";
	}

	@RequestMapping(value = "memberForgotPassword.do", method = RequestMethod.POST)
	public String memberForgotPasswordPost(Member receivedMember, RedirectAttributes redirectAttr) {

		log.debug("member={}", receivedMember);

		Member realMember = memberService.selectOneMember(receivedMember.getMemberId());

		if (realMember == null) {
			redirectAttr.addFlashAttribute("msg", "존재하지 않는 사원 번호입니다.");
			return "redirect:memberForgotPassword.do";
		}

		if (realMember.getEmail().equals(receivedMember.getEmail())) {

			// 사원번호와 이메일 모두 일치

			//랜덤 비밀번호 생성
			int index = 0;
			
			char[] charArr = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E',
					'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y',
					'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's',
					't', 'u', 'v', 'w', 'x', 'y', 'z' };
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < 8; i++) {
				index = (int) (charArr.length * Math.random());
				sb.append(charArr[index]);
			}
			
			String newPassword = sb.toString();

			//비밀번호 변경
			// BCryptPasswordEncoder
			String encodedPassword = bcryptPasswordEncoder.encode(newPassword);
			realMember.setPassword(encodedPassword);
			
			//변경 service
			int result = memberService.updatePassword(realMember);
			String msg = result > 0 ? "사원 비밀번호 초기화를 성공하였습니다. 메일 확인을 해주세요." : "사원 비밀번호 초기화를 실패했습니다.";
			redirectAttr.addFlashAttribute("msg", msg);
			
			//메일 발송
			String mFrom = "lemonbiz.manager@gmail.com";
			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

				messageHelper.setFrom(mFrom);
				messageHelper.setTo(realMember.getEmail());
				messageHelper.setSubject(realMember.getName() + " 사원님의 계정 비밀번호 초기화");
				messageHelper.setText("변경된 임시 비밀번호 : " + newPassword + "\n로그인 후 비밀번호를 재설정 해주시기 바랍니다.");

				mailSender.send(message);
			} catch (Exception e) {
				System.out.println(e);
			}

		} else {
			redirectAttr.addFlashAttribute("msg", "이메일이 일치하지 않습니다.");
			return "redirect:memberForgotPassword.do";
		}

		return "redirect:memberForgotPassword.do";
	}

}
