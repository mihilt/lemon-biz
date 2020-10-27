package com.lemon.lemonbiz.chating.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.lemon.lemonbiz.chating.vo.Room;

@Controller
public class MainController {
	
	List<Room> roomList = new ArrayList<Room>();
	static int roomNumber = 0;
	
	@RequestMapping("/chat")
	public ModelAndView chat() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/chat/chat");
		return mv;
	}
	
	@RequestMapping("/room")
	public ModelAndView room() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/chat/room");
		return mv;
	}
	
	@RequestMapping("/createRoom")
	public @ResponseBody List<Room> createRoom(@RequestParam HashMap<Object, Object> params){
		System.out.println("-------------2-----------");
		System.out.println("params = " + params); // {roomName=ww}
		String roomName = (String)params.get("roomName");
		String creator = (String)params.get("creator");
		System.out.println("roomName = " + roomName); //ww
		
		if(roomName != null && !roomName.trim().equals("")) {
			Room room = new Room();
			room.setRoomNumber(++roomNumber);
			room.setRoomName(roomName);
			room.setCreator(creator);
			roomList.add(room);
		}
		
		return roomList;
	}
	
	@RequestMapping("/getRoom")
	public @ResponseBody List<Room> getRoom(@RequestParam HashMap<Object, Object> params){
		System.out.println("-------------1-----------");
		System.out.println("params = " + params);
		
		return roomList;
	}
	
	@RequestMapping("/deleteRoom")
	public ResponseEntity<?> deleteRoom(@RequestParam HashMap<Object, Object> params){
		System.out.println("-------------delete-----------");
		
		boolean success = false;
		Map<String , Object> map = new HashMap<>();
		
		System.out.println("params = " + params);
		int roomNumber = Integer.parseInt((String)params.get("roomNumber"));
		System.out.println("roomNumber = " + roomNumber);
		System.out.println("roomList1 = " + roomList);
		
		for(Room r : roomList) {
			if(r.getRoomNumber() == roomNumber) {
				roomList.remove(r);
				success = true;
				break;
			}
		}
		
		System.out.println("roomList2 = " + roomList);
		
		if(success == true) {			
			map.put("msg","list삭제 성공!");
			System.out.println("삭제 성공");
			return new ResponseEntity<>(map,HttpStatus.OK);			
		} else {
			map.put("msg","list등록 실패!");
			System.out.println("삭제 실패");
			return new ResponseEntity<>(map,HttpStatus.INTERNAL_SERVER_ERROR);			
		}
	}
	
	@RequestMapping("/moveChating")
	public ModelAndView chating(@RequestParam HashMap<Object, Object> params,ModelAndView mav) {
		
		System.out.println("-------------3-----------");
		System.out.println("params = " + params); //params = {roomName=ww, roomNumber=1}
		int roomNumber = Integer.parseInt((String)params.get("roomNumber"));
		System.out.println("roomNumber = " + roomNumber); //roomNumber1
	
		List<Room> list = new ArrayList<>();
		
		for(Room r : roomList) {
			if(r.getRoomNumber() == roomNumber) {
				list.add(r);
			}
		}
		if(list != null && list.size() > 0) {
			mav.addObject("roomName", params.get("roomName"));
			mav.addObject("roomNumber", params.get("roomNumber"));
			mav.setViewName("/chat/chat");
		}else {
			mav.setViewName("/chat/room");
		}
		return mav;
	}
}
