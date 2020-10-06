package com.lemon.lemonbiz.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.lemon.lemonbiz.member.model.vo.Member;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter{

	private static Logger log = LoggerFactory.getLogger(LoginCheckInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		Member loginMember = (Member)session.getAttribute("loginMember");
		
		if(loginMember == null) {
			
			response.sendRedirect(request.getContextPath() + "/");
			
			return false;
		}
		
		
		
		return super.preHandle(request, response, handler);
	}
	

}
