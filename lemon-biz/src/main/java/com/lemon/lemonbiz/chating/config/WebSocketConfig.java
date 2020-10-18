package com.lemon.lemonbiz.chating.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import com.lemon.lemonbiz.chating.handler.WebSocketHandler;

@Configuration
// 이 Java 클래스는 Spring의 환경 설정과 관련된 파일이다.
@EnableWebSocket
// 웹소켓에 대해 대부분 자동설정을 한다.
public class WebSocketConfig implements WebSocketConfigurer {

// 안정적인 주입
//	private final YoSocketHandler wh;
//	
//	public WebSocketConfig(YoSocketHandler wh) {
//		this.wh = wh;
//	}
	
	@Autowired
	WebSocketHandler webSocket;
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(webSocket,"/chating/{roomNumber}").setAllowedOrigins("*");
	}
	
}
