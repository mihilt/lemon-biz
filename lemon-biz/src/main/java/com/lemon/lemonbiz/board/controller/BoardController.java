package com.lemon.lemonbiz.board.controller;


import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lemon.lemonbiz.board.model.service.BoardService;
import com.lemon.lemonbiz.board.model.vo.Board;
import com.lemon.lemonbiz.common.Utils;
import com.lemon.lemonbiz.common.vo.Attachment;

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
	
	@RequestMapping("/boardForm.do")
	public void boardForm() {
		//url -> viewName
		//ViewNameTranslator에 의해서 자동 유추됨.
	}
	
	@RequestMapping(value = "/boardEnroll.do",
					method = RequestMethod.POST)
	public String boardEnroll(Board board, 
							  @RequestParam(value = "upFile",
									  	    required = false) MultipartFile[] upFiles,
							  RedirectAttributes redirectAttr,
							  HttpServletRequest request) 
									  throws IllegalStateException, IOException {
//		log.debug("board = {}", board);
		
		
		//1. 서버컴퓨터에 업로드한 파일 저장하기
		List<Attachment> attachList = new ArrayList<>();
		
		//저장경로
		String saveDirectory = request.getServletContext()
									  .getRealPath("/resources/upload/board");
		
		for(MultipartFile upFile : upFiles) {
			//파일을 선택하지 않고 전송한 경우
			if(upFile.isEmpty())
				continue;
			
			//1.파일명(renameFilename) 생성
			String renamedFilename = Utils.getRenamedFileName(upFile.getOriginalFilename());
			
			//2.메모리의 파일 -> 서버컴퓨터 디렉토리 저장  tranferTo
			File dest = new File(saveDirectory, renamedFilename);
			upFile.transferTo(dest);
			
			//3.attachment객체 생성
			Attachment attach = new Attachment();
			attach.setOriginName(upFile.getOriginalFilename());
			attach.setReName(renamedFilename);
			attachList.add(attach);
			
//				log.debug("upFile.name = {}", upFile.getOriginalFilename());
//				log.debug("upFile.size = {}", upFile.getSize());
			
		}
		
		log.debug("attachList = {}", attachList);
		board.setAttachList(attachList);
		
		
		
		//2. Board, Attachment객체 DB에 저장하기
		int result = boardService.insertBoard(board);
		
		//3. 처리결과 msg 전달
		redirectAttr.addFlashAttribute("msg", "게시글 등록 성공");
		
		
		return "redirect:/board/boardList.do";
	}
	 
	 
}
