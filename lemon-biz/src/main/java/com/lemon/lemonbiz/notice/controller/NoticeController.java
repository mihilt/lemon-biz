package com.lemon.lemonbiz.notice.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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

	@RequestMapping(value = "noticeList.do", method = RequestMethod.GET)
	public void update(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
	    Member loginMember = (Member) session.getAttribute("loginMember");
	    
		List<Notice> noticeList = noticeService.selectNoticeList(loginMember);
		request.setAttribute("noticeList", noticeList);
	
	}
}
