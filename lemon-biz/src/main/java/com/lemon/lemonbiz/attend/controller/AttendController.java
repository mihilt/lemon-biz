package com.lemon.lemonbiz.attend.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lemon.lemonbiz.attend.model.service.AttendService;
import com.lemon.lemonbiz.attend.model.vo.Attend;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/attend")
public class AttendController {

	@Autowired
	private AttendService attendService;
	
	
	@RequestMapping("/attend.do")
	public String attend(Model model) {
		log.debug("출결페이지 요청 테스트");

		List<Attend> list = attendService.selectAttendList();
		model.addAttribute("list",list);
		
		log.debug("list={}",list);
		return "attend/attend";
	}
	
	
	@RequestMapping("/attendtest.do")
	public String attendtest(
			/* @RequestParam String memberId, */
							Model model,
							Attend attend) {
		List<Attend> list = attendService.selectAttendList();
		model.addAttribute("list",list);
		
		log.debug("list={}",list);
		/* attend.setMemId(memberId); */
//		model.addAttribute("list",list);
		return "attend/attendtest";
	}
	
	@RequestMapping("/attendArrive.do")
	public String attendArrive(@RequestParam String memberId,
								RedirectAttributes redirectAttr,
								Attend attend) {
		
		attend.setMemId(memberId);
		log.debug("zzzzzzzzzz"+attend.getMemId());
		//멤아이디가 널
		
		try {
			int result =attendService.attendArrive(attend);
			redirectAttr.addFlashAttribute("msg","출근록됨!");
		} catch(Exception e) {
			log.error("출근 등록 오류!",e);
			redirectAttr.addFlashAttribute("msg","출근 등록 오류!");
		}
		return "redirect:/attend/attend.do";
	}
	
	@RequestMapping("/attendLeabe.do")
	public String attendLeabe(@RequestParam String memberId,
								RedirectAttributes redirectAttr,
								Attend attend) {
		attend.setMemId(memberId);
		log.debug("lllllllllllllllll"+attend.getMemId());
		
		try {
			int result =attendService.attendLeabe(attend);
			redirectAttr.addFlashAttribute("msg","퇴근록됨!");
		} catch(Exception e) {
			log.error("출결 등록 오류!",e);
			redirectAttr.addFlashAttribute("msg","퇴근 등록 오류!");
		}
		return "redirect:/attend/attend.do";
	}
	@RequestMapping("/attendtestlist.do")
	public String attendtestlist(Model model) {
	
 		List<Attend> list = attendService.selectAttendList(); //다른 쿼리문으로 변경 전달
	
		model.addAttribute("list",list);
		
		log.debug("testlist={}",list);
		
		return "리스트 ";
	}
}
