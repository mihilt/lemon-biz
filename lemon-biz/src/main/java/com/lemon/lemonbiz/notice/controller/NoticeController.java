package com.lemon.lemonbiz.notice.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.notice.model.service.NoticeService;
import com.lemon.lemonbiz.notice.model.vo.Notice;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/notice")
@SessionAttributes({"loginMember"})
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;

	//알림 리스트 조회
	@RequestMapping(value = "noticeList.do", method = RequestMethod.GET)
	public void update(HttpServletRequest request, 
					   Notice notice,
					   @SessionAttribute("loginMember") Member loginMember) {
		
		List<Notice> noticeList = null; 
				
		try {
			noticeList = noticeService.selectNoticeList(loginMember);
		}catch(Exception e) {
			log.error("알림 리스트 조회 오류", e);
			throw e;
		}
		request.setAttribute("noticeList", noticeList);
	
	}
	
	//알림 확인
	@RequestMapping(value = "checkNotice.do", method = RequestMethod.GET)
	public ResponseEntity<?> checkNotice(Notice notice) {

		try {
			noticeService.checkNotice(notice);
		}catch(Exception e) {
			log.error("알림 확인 오류", e);
			throw e;
		}
		return new ResponseEntity<>(HttpStatus.OK);
	}
	
	//알림 삭제
	@RequestMapping(value = "noticeList/delete.do", method = RequestMethod.GET)
	public String delete(Notice notice) {
		
		try {
			noticeService.deleteNotice(notice);
		}catch(Exception e) {
			log.error("알림 삭제 오류", e);
			throw e;
		}
		
		return "redirect:/notice/noticeList.do";
	}
	
}
