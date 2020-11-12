package com.lemon.lemonbiz.attend.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lemon.lemonbiz.attend.model.service.AttendService;
import com.lemon.lemonbiz.attend.model.vo.Attend;
import com.lemon.lemonbiz.attend.model.vo.AttendInfo;
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
		public ModelAndView attend(ModelAndView mav, Model model,
							HttpServletRequest request,Attend attend) {
			
			HttpSession session = request.getSession();
			Member loginMember = (Member)session.getAttribute("loginMember");
			attend.setMemId(loginMember.getMemberId());
			
			//내 총 정보

			AttendInfo attendInfo =attendService.selectAttendInfo(attend);	
			model.addAttribute("attendInfo",attendInfo);
	
			//페이징 처리 코드
			int numPerPage = 5;
			int cPage = 1;
			try {
				cPage = Integer.parseInt(request.getParameter("cPage"));
			} catch (NumberFormatException e) {		}
			int totalContents;
			try {
				totalContents= attendInfo.getTotalDay();
			}catch(Exception e){
				totalContents=0;
			}

			String url = request.getRequestURI();
			
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
									HttpServletRequest request, Attend attend,
									@RequestParam("today") String today) {
			
			HttpSession session = request.getSession();
			Member loginMember = (Member)session.getAttribute("loginMember");
			attend.setMemId(loginMember.getMemberId());
			
			//마지막기록
			  try {		
				  Attend lastAttend = attendService.selectLastOne(attend);
		  				//if문과 else문 바꾸면 실행됨!!
			  			if(!today.equals(lastAttend.getLastArrive())) {
			  			redirectAttr.addFlashAttribute("msg", "출근 등록 성공!"); 
			  			}else
					 	redirectAttr.addFlashAttribute("msg", "출근 등록 오류!"); 
			 } catch(NullPointerException e) { 
				  attendService.attendArrive(attend); 
		  			redirectAttr.addFlashAttribute("msg", "출근 등록 성공!"); 
			 }catch(Exception e2) {
				 	redirectAttr.addFlashAttribute("msg", "출근 등록 오류!"); 
			 }
			return "redirect:/attend/attend.do";
		}
		
		//퇴근
		@RequestMapping("/attendLeave.do")
		public String attendLeabe(RedirectAttributes redirectAttr,
								  HttpServletRequest request,  Attend attend,
								  @RequestParam("today") String today) {
			HttpSession session = request.getSession();
			Member loginMember = (Member)session.getAttribute("loginMember");
			attend.setMemId(loginMember.getMemberId());
			
			//가져온값을 시간,오늘날짜로 나누기
			int nowTime=Integer.parseInt(today.substring(today.length()-2,today.length()));
			today=today.substring(0,8);


			  try {
				  	//DB 값가져오기
		  			Attend lastAttend = attendService.selectLastOne(attend);
		  			int lastArrive =Integer.parseInt(lastAttend.getLastArrive());
		  			
		  			//오늘 && 근무시간이  0 이라면 (시간지정시 해당시간내로 퇴근 여러번)
			  		if(today.equals(lastAttend.getLastArrive()) 
			  				&& lastAttend.getTime()==0.0 
			  					) { 
			  			nowTime=-24;
			  				//12시간 넘게일했다면 퇴근안됨 (퇴근제한 12시간)
				  			if((nowTime-lastAttend.getLastTime())<=12) { //12시간 이후면
					  			attendService.attendLeabe(attend);
					  			redirectAttr.addFlashAttribute("msg", "퇴근 등록 되었습니다.");
				  			}
			  			} 
			  			//야근일시 다음날 퇴근가능
			  			else if(++lastArrive==Integer.parseInt(today)) {
			  				
			  				//출근후 12시간 지나면  퇴근불가
			  				if((nowTime-lastAttend.getLastTime())<=12)
			  				attendService.attendLeabe(attend);
				  			redirectAttr.addFlashAttribute("msg", "퇴근 등록 되었습니다.");
			  			}else {
			  				redirectAttr.addFlashAttribute("msg", "퇴근시간이 아닙니다.");  
			  			}
			 } catch(Exception e) { 
				 	log.error("퇴근 등록 오류!", e);
				 	redirectAttr.addFlashAttribute("msg", "퇴근 등록 오류!"); 
			 }

			return "redirect:/attend/attend.do";
		}
		
		
		//Cal근태호출
		@RequestMapping("/attendCal.do")
		public String attendtest() {
			//코드
			
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
		
		//메인화면 출근인원
		@RequestMapping("/getTodayAttend")
		public ResponseEntity<?> getTodayCount(@RequestParam HashMap<Object,Object> params) {
			
			String date = (String)params.get("date");

			int num = attendService.getTodayCount(date);

			return new ResponseEntity<>(num,HttpStatus.OK);		
		}
		
		//main화면 출퇴근 확인
		@RequestMapping("/getAttendLeave")
		public ResponseEntity<?> getAttendLeave(@RequestParam HashMap<Object,Object> params) {
			
			String date = (String)params.get("date");

			Attend attend = attendService.getAttendLeave(params);
			
			return new ResponseEntity<>(attend,HttpStatus.OK);		
		}
		
		

}
