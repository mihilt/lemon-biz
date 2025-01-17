package com.lemon.lemonbiz.calendar.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.lemon.lemonbiz.calendar.model.service.CalendarService;
import com.lemon.lemonbiz.calendar.model.vo.Calendar;
import com.lemon.lemonbiz.calendar.model.vo.NewDates;
import com.lemon.lemonbiz.member.model.vo.Member;

@RestController
@RequestMapping("/calendar")
public class CalendarController {
	
	@Autowired
	private CalendarService calendarService;
	
	@RequestMapping("/calendar.do")
	public ModelAndView boardList(ModelAndView mav) {

		mav.setViewName("calendar/calendar");
		return mav;
	}
	
	@RequestMapping(value="/selectAllList.do")
	public @ResponseBody List<Calendar> selectAllList(HttpServletResponse response,@SessionAttribute("loginMember") Member loginMember){
		
		System.out.println("loginMember" + loginMember);
		String memberId = loginMember.getMemberId();
		List<Calendar> list = calendarService.selectAllList(memberId);
		
		System.out.println("list = " + list);
		System.out.println("list불러오기 성공");
		
		return list;
	}
	
	@PostMapping(value = "/enrollCalendar.do")
	public ResponseEntity<?> enrollCalendar(@RequestBody Calendar calendar){
		
		System.out.println("캘린더 등록  성공");
		
		System.out.println("calendar" + calendar);
		
		Map<String , Object> map = new HashMap<>();
		
		
		int result = calendarService.enrollCalendar(calendar);
		
		if(result > 0) {			
			map.put("msg","calendar등록 성공!");
			return new ResponseEntity<>(map,HttpStatus.OK);			
		} else {
			map.put("msg","calendar등록 실패!");
			return new ResponseEntity<>(map,HttpStatus.INTERNAL_SERVER_ERROR);			
		}
	
	}
	
	@PostMapping("/updateCalendar.do")
	public ResponseEntity<?> updateCalendar(@RequestBody Calendar calendar){
		System.out.println("calendar = " + calendar);
		
		Map<String , Object> map = new HashMap<>();
		
		int result = calendarService.updateCalendar(calendar);
		
		if(result > 0) {			
			map.put("msg","calendar업데이트 성공!");
			System.out.println("업데이트 성공");
			return new ResponseEntity<>(map,HttpStatus.OK);			
		} else {
			map.put("msg","calendar업데이트 실패!");
			System.out.println("업데이트 실패");
			return new ResponseEntity<>(map,HttpStatus.INTERNAL_SERVER_ERROR);			
		}
	}
	
	@PostMapping("/dragNdropCalendar.do")
	public ResponseEntity<?> dragNdropCalendar(@RequestBody NewDates newDates){
		System.out.println("newDates = " + newDates);
		
		Map<String , Object> map = new HashMap<>();
		
		int result = calendarService.dragNdropCalendar(newDates);
		
		if(result > 0) {			
			map.put("msg","dragNdrop업데이트 성공!");
			System.out.println("dragNdrop 업데이트 성공");
			return new ResponseEntity<>(map,HttpStatus.OK);			
		} else {
			map.put("msg","dragNdrop업데이트 실패!");
			System.out.println("dragNdrop 업데이트 실패");
			return new ResponseEntity<>(map,HttpStatus.INTERNAL_SERVER_ERROR);			
		}
		
	}
	
	@DeleteMapping("/deleteCalendar.do/{no}")
	public ResponseEntity<?> deleteCalendar(@PathVariable("no") int no){
		System.out.println("no = " +no);
		
		Map<String , Object> map = new HashMap<>();
		
		int result = calendarService.deleteCalendar(no);
		
		if(result > 0) {			
			map.put("msg","calendar삭제 성공!");
			System.out.println("삭제 성공");
			return new ResponseEntity<>(map,HttpStatus.OK);			
		} else {
			map.put("msg","calendar등록 실패!");
			System.out.println("삭제 실패");
			return new ResponseEntity<>(map,HttpStatus.INTERNAL_SERVER_ERROR);			
		}
	}
	
	@RequestMapping("/getTodayCount")
	public ResponseEntity<?> getTodayCount(ModelAndView mav,@RequestParam HashMap<Object,Object> params) {
		
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		System.out.println("params = " + params);
		
		int num = calendarService.getTodayCount(params);
		
		System.out.println("num = " + num);

		return new ResponseEntity<>(num,HttpStatus.OK);		
	}
}
