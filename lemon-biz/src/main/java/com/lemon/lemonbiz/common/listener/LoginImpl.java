package com.lemon.lemonbiz.common.listener;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import lombok.extern.slf4j.Slf4j;

/**
 * Application Lifecycle Listener implementation class LoginImpl
 *
 */
@Slf4j
@WebListener
public class LoginImpl implements HttpSessionListener {

	static int loginUserCount = 0;
	
    /**
     * Default constructor. 
     */
    public LoginImpl() {
        // TODO Auto-generated constructor stub
    }

	/**
     * @see HttpSessionListener#sessionCreated(HttpSessionEvent)
     */
    @Override
    public void sessionCreated(HttpSessionEvent se)  { 
         // TODO Auto-generated method stub
    	loginUserCount++;
    	log.debug("세션 생성 {}",loginUserCount);
    	
    }

	/**
     * @see HttpSessionListener#sessionDestroyed(HttpSessionEvent)
     */
    @Override
    public void sessionDestroyed(HttpSessionEvent se)  { 
         // TODO Auto-generated method stub
    	loginUserCount--;
    	log.debug("세션 소멸 {}",loginUserCount);

    }
	
}
