package com.lemon.lemonbiz.common.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Component
@Aspect
@Slf4j
public class LoggerAspect {

//	@Pointcut("execution(* com.lemon.lemonbiz..*(..))")
	public void pointcut() {
		
	}

//	@Around("pointcut()")
	public Object aroundLogger(ProceedingJoinPoint joinPoint) 
											throws Throwable {
		Signature signature = joinPoint.getSignature();
		String type = signature.getDeclaringTypeName();
		String methodName = signature.getName();
		
		//jointPoint 실행전
		log.debug("[Around - Before] {}.{}", type, methodName);
		
		Object obj = joinPoint.proceed();
		
		//joinPoint 실행후
		log.debug("[Around - After] {}.{}", type, methodName);
		
		return obj;
	}
	
	
//	@Before("pointcut()")
	public void beforeLogger(JoinPoint joinPoint) {
		Signature signature = joinPoint.getSignature();
		String type = signature.getDeclaringTypeName();
		String methodName = signature.getName();
		log.debug("[Before] {}.{}", type, methodName);
	}
	
//	@AfterReturning(value = "pointcut()",
//					returning = "returnObj")
	public void afterReturningLogger(JoinPoint joinPoint,
									 Object returnObj) {
		Signature signature = joinPoint.getSignature();
		String type = signature.getDeclaringTypeName();
		String methodName = signature.getName();
		log.debug("[AfterReturning] {}.{}", type, methodName);
		log.debug("returnObj = {}", returnObj);
	}
}
