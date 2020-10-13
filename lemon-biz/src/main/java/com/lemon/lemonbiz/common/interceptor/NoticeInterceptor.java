package com.lemon.lemonbiz.common.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.notice.model.service.NoticeService;
import com.lemon.lemonbiz.notice.model.vo.Notice;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class NoticeInterceptor extends HandlerInterceptorAdapter {
	@Autowired
	private NoticeService noticeService;
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView mav) throws Exception {
		super.postHandle(request, response, handler, mav);
		
		HttpSession session = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest().getSession();
		Member loginMember = (Member)session.getAttribute("loginMember");
		
		log.debug("NoticeInterceptor 실행 \n");
		if(loginMember != null) {
			
			log.debug("새로운 알람 불러오기 실행\n");
			List<Notice> noticeList = noticeService.selectNoticeList(loginMember);
			
			request.setAttribute("noticeList", noticeList);
		}
	}

	
	
}
