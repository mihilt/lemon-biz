package com.lemon.lemonbiz.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.FlashMapManager;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.lemon.lemonbiz.member.model.vo.Member;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter{

	private static Logger log = LoggerFactory.getLogger(LoginCheckInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		Member loginMember = (Member)session.getAttribute("loginMember");
		
		String reqUrl = request.getRequestURI().toString();
		
		log.debug(reqUrl);
		log.debug(request.getContextPath() + "/member/memberLogin.do");
		
		if(reqUrl.equals(request.getContextPath() + "/member/memberLogin.do") || 
				reqUrl.equals(request.getContextPath()+"/"))
			return true;
		
		if(loginMember == null) {
			
			FlashMap map = new FlashMap();
			map.put("msg", "로그인 후 이용하실 수 있습니다.");
			
			FlashMapManager manager = RequestContextUtils.getFlashMapManager(request);
			manager.saveOutputFlashMap(map, request, response);
			
			
			response.sendRedirect(request.getContextPath() + "/member/memberLogin.do");
			
			return false;
		}
		
		
		
		return super.preHandle(request, response, handler);
	}
	

}
