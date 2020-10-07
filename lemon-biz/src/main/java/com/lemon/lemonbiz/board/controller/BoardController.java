package com.lemon.lemonbiz.board.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.lemon.lemonbiz.board.model.service.BoardService;
import com.lemon.lemonbiz.board.model.vo.Board;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/board")
@Slf4j
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	@RequestMapping("/boardList.do")
	public ModelAndView boardList(ModelAndView mav) {

		List<Map<String, Object>> list = boardService.selectBoardMapList();
		
		log.debug("list = {}", list);
		mav.addObject("list", list);
		
		mav.setViewName("board/boardList");
		return mav;
	}
	
	@RequestMapping("/boardTeamList.do")
	public ModelAndView boardTeamList(ModelAndView mav) {

		List<Map<String, Object>> list = boardService.selectBoardMapList();
		
		log.debug("list = {}", list);
		mav.addObject("list", list);
		
		mav.setViewName("board/boardTeamList");
		return mav;
	}
	
	
	
	/*
	 * @RequestMapping("/boardDetail.do") public ModelAndView
	 * boardDetail(@RequestParam("no") int no, ModelAndView mav) {
	 * 
	 * Board board = boardService.selectOneBoardCollection(no);
	 * log.debug("board = {}", board);
	 * 
	 * mav.addObject("board", board);
	 * 
	 * mav.setViewName("board/boardDetail"); return mav; }
	 */
	 
	 
}
