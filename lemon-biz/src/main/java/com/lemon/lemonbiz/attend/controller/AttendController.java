package com.lemon.lemonbiz.attend.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lemon.lemonbiz.attend.model.service.AttendService;
import com.lemon.lemonbiz.attend.model.vo.Attend;
import com.lemon.lemonbiz.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/attend")
public class AttendController {

	@Autowired
	private AttendService attendService;

		//내 근태 페이지
		@RequestMapping("/attend.do")
		public String attend(Model model, HttpServletRequest request,Attend attend) {
			log.debug("출결페이지 요청 테스트");
			
			HttpSession session = request.getSession();
			Member loginMember = (Member)session.getAttribute("loginMember");
			attend.setMemId(loginMember.getMemberId());
			
			List<Attend> list = attendService.selectAttendList(attend);
			Attend attendInfo =attendService.selectAttendInfo(attend);
			Attend lastAttend = attendService.selectLastOne(attend);
			log.debug("list2값="+attendInfo);
			
			
			model.addAttribute("list", list);
			model.addAttribute("sumArr",attendInfo.getKey());
			model.addAttribute("sumTime",attendInfo.getMemId());
			model.addAttribute("avgTime",attendInfo.getTime());
			model.addAttribute("lastAttend", lastAttend);
			
			//Fri Oct 09 2020 19:53:37 GMT+0900 (대한민국 표준시)
			log.debug("lastAttend="+ lastAttend);
			return "attend/attend";
		}

		//출근
		@RequestMapping("/attendArrive.do")
		public String attendArrive( RedirectAttributes redirectAttr,
									HttpServletRequest request, Attend attend) {

			HttpSession session = request.getSession();
			Member loginMember = (Member)session.getAttribute("loginMember");
			attend.setMemId(loginMember.getMemberId());

			try {
				attendService.attendArrive(attend);
				redirectAttr.addFlashAttribute("msg", "출근록됨!");
			} catch (Exception e) {
				log.error("출근 등록 오류!", e);
				redirectAttr.addFlashAttribute("msg", "출근 등록 오류!");
			}
			return "redirect:/attend/attend.do";
		}
		
		//퇴근
		@RequestMapping("/attendLeabe.do")
		public String attendLeabe( RedirectAttributes redirectAttr,
									HttpServletRequest request,  Attend attend) {
			
			HttpSession session = request.getSession();
			Member loginMember = (Member)session.getAttribute("loginMember");
			attend.setMemId(loginMember.getMemberId());
			
			try {
				attendService.attendLeabe(attend);
				redirectAttr.addFlashAttribute("msg", "퇴근록됨!");
			} catch (Exception e) {
				log.error("출결 등록 오류!", e);
				redirectAttr.addFlashAttribute("msg", "퇴근 등록 오류!");
			}
			return "redirect:/attend/attend.do";
		}
		
		//test호출
		@RequestMapping("/attendtest.do")
		public String attendtest(/* Model model, Attend attend*/) {

		return "attend/attendtest";
		}
		
		//캘린더 값 삽입
		@ResponseBody
		@RequestMapping("/selectCalAttend.do") 
		public List<Attend> selectCalAttend(Attend attend ,
									@RequestParam("memId") String memId ,
									@RequestParam("yyyymm") String yyyymm ) {
		attend.setMemId(memId);
		attend.setYyyymm(yyyymm+'%');
		log.debug("ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ"+memId+yyyymm);
		List<Attend> list = attendService.selectCalAttend(attend);
		log.debug("ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ"+list);
		
		return list;
		}

}
