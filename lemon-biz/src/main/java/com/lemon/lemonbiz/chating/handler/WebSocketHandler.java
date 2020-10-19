package com.lemon.lemonbiz.chating.handler;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
//개발자가 직접 작성한 class를 bean으로 등록
public class WebSocketHandler extends TextWebSocketHandler {

	// 웹소켓 세션을 담아둘 맵
	// HashMap<String, WebSocketSession> sessionMap = new HashMap<>();
	List<HashMap<String, Object>> list = new ArrayList<>(); //웹소켓 세션을 담아둘 리스트 ---roomListSessions
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		System.out.println("-------------4-----------");
		System.out.println("session = " + session);
		//StandardWebSocketSession[id=1f8da2e9-cd64-aad0-2622-17faa4c93cb3, uri=ws://localhost:8080/lemonbiz/chating/1]
		// 소켓 연결
		// 웹소켓 연결이 되면 동작합니다.
		super.afterConnectionEstablished(session);
		boolean flag = false;
		String url = session.getUri().toString();
		System.out.println("url = " + url);
		//url = ws://localhost:8080/lemonbiz/chating/1
		
//		String roomNumber = url.split("/chating/")[0];
		// roomNumber = ws://localhost:8080/lemonbiz
		String roomNumber = url.split("/chating/")[1];
		// roomNumber = 1
		System.out.println("roomNumber = " + roomNumber);
		int idx = list.size(); //방의 사이즈를 조사한다.
		if(list.size() > 0) {
			for(int i=0; i<list.size(); i++) {
				String rN = (String) list.get(i).get("roomNumber");
				System.out.println("rN = " + rN);
				if(rN.equals(roomNumber)) {
					flag = true;
					idx = i;
					break;
				}
			}
		}
		
		if(flag) { //존재하는 방이라면 세션만 추가한다.
			HashMap<String, Object> map = list.get(idx);
			map.put(session.getId(), session);
		}else { //최초 생성하는 방이라면 방번호와 세션을 추가한다.
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("roomNumber", roomNumber);
			map.put(session.getId(), session);
			list.add(map);
		}
		
		//세션등록이 끝나면 발급받은 세션ID값의 메시지를 발송한다.
		JSONObject obj = new JSONObject();
		obj.put("type", "getId");
		obj.put("sessionId", session.getId());
		session.sendMessage(new TextMessage(obj.toJSONString()));
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) {
		System.out.println("-------------5-----------");
		// 메시지 발송
		// 메시지를 수신하면 실행됩니다.
		String msg = message.getPayload();
		// getPayload() : 메시지에 담긴 텍스트값을 얻을 수 있습니다.
		System.out.println("msg =" + msg);
		
		JSONParser parser = new JSONParser();
		
		JSONObject obj = null;
		
		try {
			obj = (JSONObject)parser.parse(msg);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		System.out.println("obj = " + obj);
	
		String rN = (String)obj.get("roomNumber");
		System.out.println("rN = " + rN);
		
		System.out.println("list = " + list);
		
		HashMap<String, Object> temp = new HashMap<String, Object>();
		if(list.size() > 0) {
			for(int i=0; i<list.size(); i++) {
				System.out.println("i = " + i);
				String roomNumber = (String)list.get(i).get("roomNumber"); //세션리스트의 저장된 방번호를 가져와서
				if(roomNumber.equals(rN)) { //같은값의 방이 존재한다면
					temp = list.get(i); //해당 방번호의 세션리스트의 존재하는 모든 object값을 가져온다.
					break;
				}
			}
			
			System.out.println("temp = " + temp);
			
			//해당 방의 세션들만 찾아서 메시지를 발송해준다.
			for(String k : temp.keySet()) { //keySet : hashMap에 저장된 모든키가 저장된 Set을 반환
				
				System.out.println("k(Set) = " + k);
				
				if(k.equals("roomNumber")) { //다만 방번호일 경우에는 건너뛴다.
					continue;
				}
				
				WebSocketSession wss = (WebSocketSession)temp.get(k);
				if(wss != null) {
					try {
						System.out.println("obj.toJSONString() = " + obj.toJSONString());
						wss.sendMessage(new TextMessage(obj.toJSONString()));
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("-------------6-----------");
		// 소켓 종료
		// 반대로 웹소켓이 종료되면 동작합니다.
		if(list.size() > 0) { //소켓이 종료되면 해당 세션값들을 찾아서 지운다.
			for(int i=0; i<list.size(); i++) {
				list.get(i).remove(session.getId());
			}
		}
		super.afterConnectionClosed(session, status);
	}

}
