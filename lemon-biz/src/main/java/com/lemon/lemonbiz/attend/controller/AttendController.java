package com.lemon.lemonbiz.attend.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lemon.lemonbiz.attend.model.service.AttendService;
import com.lemon.lemonbiz.attend.model.vo.Attend;
import com.lemon.lemonbiz.common.vo.Paging;
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
		public ModelAndView attend(ModelAndView mav, Model model, HttpServletRequest request,Attend attend) {
		
			HttpSession session = request.getSession();
			Member loginMember = (Member)session.getAttribute("loginMember");
			attend.setMemId(loginMember.getMemberId());
			
			//내 총 정보
			Attend attendInfo =attendService.selectAttendInfo(attend);
			model.addAttribute("sumArr",attendInfo.getKey());
			model.addAttribute("sumTime",attendInfo.getMemId());
			model.addAttribute("avgTime",attendInfo.getTime());
			
			log.debug("list2값="+attendInfo);
			
			//내 모든 리스트
			/*
			 * List<Attend> list = attendService.selectAttendList(attend);
			 * model.addAttribute("list", list);
			 */
			
			
			//마지막 기록 정보
			Attend lastAttend = attendService.selectLastOne(attend);
			model.addAttribute("lastAttend", lastAttend);
			log.debug("lastAttend값="+lastAttend);
			
			
			//페이징 처리 코드
			int numPerPage = 5;
			int cPage = 1;
			try {
				cPage = Integer.parseInt(request.getParameter("cPage"));
			} catch (NumberFormatException e) {
			}
			int totalContents;
			try {
				totalContents= attendInfo.getKey();
			}catch(Exception e){
				totalContents=0;
			}

			String url = request.getRequestURI();
			log.debug("totalContents = {} ",totalContents);
			log.debug("cPage = {} ",totalContents);
			log.debug("numPerPage = {} ",totalContents);
			log.debug("url = {} ",totalContents);
			
			String pageBar = Paging.getPageBarHtml(cPage, numPerPage, totalContents, url);
			Map<String,Object> map = new HashMap<String, Object>();
		
			String memId =attend.getMemId();
			List<Map<String, Object>> list = attendService.selectAttendList(cPage,numPerPage,map,memId);
			mav.addObject("list", list);
			mav.addObject("pagebar",pageBar);

			mav.setViewName("attend/attend");
			return mav;
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
		
		
		//Cal근태호출
		@RequestMapping("/attendCal.do")
		public String attendtest(/* Model model, Attend attend*/) {

		return "attend/attendCal";
		}
		
		//캘린더 데이터값
		@ResponseBody
		@RequestMapping("/selectCalAttend.do") 
		public List<Attend> selectCalAttend(Attend attend ,
									@RequestParam("memId") String memId ,
									@RequestParam("yyyymm") String yyyymm ) {
		attend.setMemId(memId);
		attend.setYyyymm(yyyymm+'%');
		List<Attend> list = attendService.selectCalAttend(attend);
		
		return list;
		}
		@RequestMapping(value = "/manageAttend.do", method = RequestMethod.GET)
		public String attendMember(Model model) {
			
			List<Attend> attendList = attendService.selectAttendList();
			
			model.addAttribute("attendList",attendList);
			return "/attend/managerAttend";
		}

}
