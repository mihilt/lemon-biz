package com.lemon.lemonbiz.common.aop;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.FlashMapManager;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.lemon.lemonbiz.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Component
@Aspect
@Slf4j
public class ManagerCheckAspect {

//	@Pointcut("execution(* com.lemon.lemonbiz.manager..*(..))")
	public void pointcut() {
		
	}
	
//	@Before("pointcut()")
	public void beforeCheck(JoinPoint joinPoint) throws Throwable  {
		log.debug("manager 기능에 접근");
		
        HttpSession session = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest().getSession();
        HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
        HttpServletResponse response = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getResponse();

		Member loginMember = (Member)session.getAttribute("loginMember");
		
		log.debug("manager 권한 체크 : " + loginMember.getIsManager());
		
		if(loginMember.getIsManager() != 1) {
			log.debug("일반 사용자가 manager 권한에 접근!!");

			FlashMap map = new FlashMap();
			map.put("msg", "그룹웨어 관리자 권한이 없는 사용자 입니다.");
			FlashMapManager manager = RequestContextUtils.getFlashMapManager(request);
			manager.saveOutputFlashMap(map, request, response);
			
			response.sendRedirect(request.getContextPath() + "/");
		}
	}
}
