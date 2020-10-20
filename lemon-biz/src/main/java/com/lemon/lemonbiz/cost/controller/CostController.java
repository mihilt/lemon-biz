package com.lemon.lemonbiz.cost.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.lemon.lemonbiz.calendar.model.vo.Calendar;
import com.lemon.lemonbiz.cost.model.service.CostService;
import com.lemon.lemonbiz.cost.model.vo.Cost;
import com.lemon.lemonbiz.member.model.vo.Member;

@RestController
@RequestMapping("/cost")
public class CostController {
	
	@Autowired
	private CostService costService;
	
	@RequestMapping(value = "selectAllCost.do")
	public @ResponseBody List<Cost> selectAllCost(@SessionAttribute("loginMember") Member loginMember){
		
		System.out.println("loginMember" + loginMember);
		
		List<Cost> list = costService.selectAllCost(loginMember.getMemberId());
		
		System.out.println("list = " + list);
		
		return list;
	}
	
	@PostMapping(value = "/enrollCost.do")
	public ResponseEntity<?> enrollCost(@RequestBody Cost cost){
		
		Map<String , Object> map = new HashMap<>();
		
		System.out.println("지출 등록  성공");
		
		System.out.println("cost" + cost);
		
		int result = costService.enrollCost(cost);
		
		return new ResponseEntity<>(map,HttpStatus.OK);
	}
	
	

}
