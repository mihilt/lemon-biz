package com.lemon.lemonbiz.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.FlashMapManager;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.lemon.lemonbiz.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LoginCheckInterceptor extends HandlerInterceptorAdapter{

	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		Member loginMember = (Member)session.getAttribute("loginMember");
		
		String reqUrl = request.getRequestURI().toString();
		
//		log.debug(reqUrl);
//		log.debug(request.getContextPath() + "/member/memberLogin.do");
		
		if(reqUrl.equals(request.getContextPath() + "/member/memberLogin.do") || 
				reqUrl.equals(request.getContextPath()+"/"))
			return true;
		
		if(loginMember == null) {
			
			response.sendRedirect(request.getContextPath() + "/member/memberLogin.do");
			return false;
		}
		
		
		
		return super.preHandle(request, response, handler);
	}
	

}
