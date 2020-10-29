package com.lemon.lemonbiz.board.controller;


import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lemon.lemonbiz.board.model.service.BoardService;
import com.lemon.lemonbiz.board.model.vo.Board;
import com.lemon.lemonbiz.board.model.vo.BoardComment;
import com.lemon.lemonbiz.common.Utils;
import com.lemon.lemonbiz.common.vo.Attachment;
import com.lemon.lemonbiz.common.vo.Paging;
import com.lemon.lemonbiz.common.vo.PagingType;
import com.lemon.lemonbiz.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;


@Controller
@RequestMapping("/board")
@Slf4j
public class BoardController {

	@Autowired
	private BoardService boardService;

	@Autowired
	private ResourceLoader resourceLoader;
	
	@RequestMapping("/boardList.do")
	public ModelAndView boardList(ModelAndView mav,HttpServletRequest request,@SessionAttribute("loginMember") Member loginMember) {

		int numPerPage = 10;
		int cPage = 1;
		
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		} catch (NumberFormatException e) {
			
		}
		int totalContents = boardService.countBoard();
		/* log.debug("totalContents = {} ",totalContents); */
		String url = request.getRequestURI();
		/* log.debug("url = {} " , url); */
		String pageBar = Paging.getPageBarHtml(cPage, numPerPage, totalContents, url);
		Map<String,Object> map = new HashMap<String, Object>();
	
		
		List<Map<String, Object>> list = boardService.selectBoardMapList(cPage,numPerPage,map);
		mav.addObject("list", list);
		mav.addObject("pagebar",pageBar);		
		mav.setViewName("board/boardList");
		return mav;
	}
	
	/*
	 * @RequestMapping("/selectList.do") public ResponseEntity<?> selectList(){
	 * List<Map<String, Object>> list = boardService.selectBoardMapList(); return
	 * new ResponseEntity<>(list, HttpStatus.OK); }
	 */
	
	@RequestMapping("/boardForm.do")
	public void boardForm() {

	}
	
	@RequestMapping(value = "/boardEnroll.do",
			method = RequestMethod.POST)
	public String boardEnroll(Board board,
						  @RequestParam(value = "upFile",
								  	    required = false) MultipartFile[] upFiles,
						  RedirectAttributes redirectAttr,
						  HttpServletRequest request) 
								  throws IllegalStateException, IOException {
	log.debug("board = {}", board);
	
	
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
		
		//2.메모리의 파일 -> 서버컴퓨터 디렉토리 저장  transferTo
		File dest = new File(saveDirectory, renamedFilename);
		upFile.transferTo(dest);
		
		//3.attachment객체 생성
		Attachment attach = new Attachment();
		attach.setOriginName(upFile.getOriginalFilename());
		attach.setReName(renamedFilename);
		attachList.add(attach);
		
	//		log.debug("upFile.name = {}", upFile.getOriginalFilename());
	//		log.debug("upFile.size = {}", upFile.getSize());
		
	}
	
	log.debug("attachList = {}", attachList);
	board.setAttachList(attachList);
	
	//2. Board, Attachment객체 DB에 저장하기
	int result = boardService.insertBoard(board);
	
	//3. 처리결과 msg 전달
	redirectAttr.addFlashAttribute("msg", "게시글 등록 성공");
	
	
	return "redirect:/board/boardList.do";
	}

	
	@RequestMapping("boardDetail.do")
	public ModelAndView boardDeatil(@RequestParam("key") int key, ModelAndView mav,
						  			HttpServletRequest request, HttpServletResponse response,@SessionAttribute("loginMember") Member loginMember) {
		
		Cookie[] cookies = request.getCookies();
		String boardCookieVal = "";
		boolean hasRead = false;//현재 요청(브라우져)에서 이 게시글을 이미 읽었는가 여부
		
		if(cookies != null) {
			for(Cookie c : cookies) {
				String name = c.getName();
				String value = c.getValue();
				
				if("boardCookie".equals(name)) {
					boardCookieVal = value;
//					System.out.println(name + " = " + value);
					
					//이번 게시글 읽음 여부
					if(value.contains("[" + key + "]")) {
						hasRead = true;
						break;
					}
					
				}
			}
		}
		
		//게시글을 읽지 않은 경우
		if(hasRead == false) {
			Cookie boardCookie = new Cookie("boardCookie",
											boardCookieVal + "[" + key + "]");
			boardCookie.setMaxAge(365*24*60*60);//영속쿠키
			// /mvc/board/view
			boardCookie.setPath(request.getContextPath() + "/board/");
			response.addCookie(boardCookie);
		}
		
		//collection 이용 join
		Board board = boardService.selectOneBoardCollection(key,hasRead);
		List<BoardComment> commentList = boardService.selectCommentList(key);
		
		log.debug("commentList = {}", commentList); 
		mav.addObject("board", board);
		mav.addObject("commentList", commentList);
		
		mav.setViewName("board/boardDetail");
		
		return mav;
	}
	
	@RequestMapping("boardDetail2.do")
	public ModelAndView boardDeatil2(@RequestParam("key") int key, ModelAndView mav,
						  			HttpServletRequest request, HttpServletResponse response,@SessionAttribute("loginMember") Member loginMember) {
		
		Cookie[] cookies = request.getCookies();
		String boardCookieVal = "";
		boolean hasRead = false;//현재 요청(브라우져)에서 이 게시글을 이미 읽었는가 여부
		
		if(cookies != null) {
			for(Cookie c : cookies) {
				String name = c.getName();
				String value = c.getValue();
				
				if("boardCookie".equals(name)) {
					boardCookieVal = value;
//					System.out.println(name + " = " + value);
					
					//이번 게시글 읽음 여부
					if(value.contains("[" + key + "]")) {
						hasRead = true;
						break;
					}
					
				}
			}
		}
		
		//게시글을 읽지 않은 경우
		if(hasRead == false) {
			Cookie boardCookie = new Cookie("boardCookie",
											boardCookieVal + "[" + key + "]");
			boardCookie.setMaxAge(365*24*60*60);//영속쿠키
			// /mvc/board/view
			boardCookie.setPath(request.getContextPath() + "/board/");
			response.addCookie(boardCookie);
		}
		
		//collection 이용 join
		Board board = boardService.selectOneBoardCollection(key,hasRead);
		List<BoardComment> commentList = boardService.selectCommentList(key);
		
		/* log.debug("commentList = {}", commentList); */
		mav.addObject("board", board);
		mav.addObject("commentList", commentList);
		
		mav.setViewName("board/boardDetail2");
		
		return mav;
	}
	
	@RequestMapping(value = "/fileDownload.do")
	@ResponseBody
	public Resource fileDownload(@RequestParam("key") int key,
								 @RequestHeader("user-agent") String userAgent,
								 HttpServletRequest request,
								 HttpServletResponse response) throws UnsupportedEncodingException {
		//1. Attachment 객체 가져오기
		Attachment attach = boardService.selectOneAttachment(key);
		
		//2. Resource 객체 생성
		String saveDirectory = request.getServletContext()	
									  .getRealPath("/resources/upload/board");
		File downFile = new File(saveDirectory, attach.getReName());
		Resource resource = resourceLoader.getResource("file:" + downFile);
		log.debug("resource = {}", resource);
		
		//3. 응답헤더
		//IE대비 파일명 분기처리
		boolean isMSIE = userAgent.indexOf("MSIE") != -1 
                	  || userAgent.indexOf("Trident") != -1;
		String originalFilename = attach.getOriginName();
	    if(isMSIE){
	        //ie 구버젼을 위해 퍼센트인코딩을 명시적으로 처리. 
	    	//퍼센트인코딩(URLEncoder.encode)이후 공백을 의미하는 +를 %20로 다시 치환.
	        originalFilename = URLEncoder.encode(originalFilename, "UTF-8")//%EC%B7%A8+%EC%97%85+%ED%8A%B9+%EA%B0%95.txt
	        							 .replaceAll("\\+", "%20");
	    } 
	    else {
	        originalFilename = new String(originalFilename.getBytes("UTF-8"),"ISO-8859-1");
	    }

	    response.setContentType("application/octet-stream; charset=utf-8");
		response.addHeader("Content-Disposition", "attachment; filename=\"" + originalFilename + "\"");//쌍따옴표 사용하지 말것.
		
		return resource;
	}
	
	@RequestMapping(value ="/boardUpdate.do")
	
	public ModelAndView boardUpdate(@RequestParam("key") int key ,ModelAndView mav) {

		Board board = boardService.selectOneBoardCollection(key);
		if(board.getAttachList() !=null) {
		try {
		List<Attachment> atc =board.getAttachList();
		log.debug("atc={}",atc);
		String Oname1 = atc.get(0).getOriginName();
		String Oname2 = atc.get(1).getOriginName();
		log.debug("dd={}",Oname1);
		log.debug("d2={}",Oname2);
		mav.addObject("Oname1",Oname1);
		mav.addObject("Oname2",Oname2);
		}catch (Exception e) {
			
		}
		}
		mav.addObject("board", board);
	  
	    mav.setViewName("board/boardForm3");
 
	    return mav; 
	}
	@RequestMapping("/boardupdatesucces.do")
	public ModelAndView boardupdatesucces(@ModelAttribute Board board,@RequestParam("key") int key ,ModelAndView mav,
										@RequestParam(value = "upFile1",required = false) MultipartFile upFile1,
										@RequestParam(value = "upFile2",required = false) MultipartFile upFile2,
					@RequestParam(value="delFile1", required=false) String delFile1,@RequestParam(value="delFile2", required=false) String delFile2, HttpServletRequest request) throws IllegalStateException, IOException {


		//1. 서버컴퓨터에 업로드한 파일 저장하기
		List<Attachment> attachList = new ArrayList<>();
		
	
		List<Attachment> oldBoard = boardService.SelectBoardOne(key); 
			
			
			

		board.setKey(key);
		boardService.updateBoard(board,oldBoard);
		mav.addObject("board", board);
	    mav.setViewName("redirect:/board/boardDetail.do?key="+key);
	    return mav; 
	}
		
	
	
	@RequestMapping(value="/boardInsert.do", method = RequestMethod.POST)
	
	public String boardInsert(@ModelAttribute BoardComment boardComment ,RedirectAttributes redirectAttr) {		
		
		
		boardService.boardInsert(boardComment);
		int key = boardComment.getBoardRef();
		log.debug("boardComment = {}" ,boardComment); 
		
		
		redirectAttr.addFlashAttribute("msg", "댓글 등록 성공");
		return "redirect:/board/boardDetail.do?key="+key;
	}
	
	@RequestMapping("/boardDelete.do")
	
	public String boardDelete(@RequestParam("key") int key,@RequestParam("boardCommentNo") int commentNo,RedirectAttributes redirectAttr) {
		
		boardService.boardDelete(commentNo);
		redirectAttr.addFlashAttribute("msg", "삭제 완료!");
		return "redirect:/board/boardDetail.do?key="+key;
	}
	
	@RequestMapping("/boardfrmDelete.do")
	
	public String boardfrmDelete(@RequestParam("key") int key, Attachment attachment,HttpServletRequest request,RedirectAttributes redirectAttr) {
			
		String renamedFileName = attachment.getReName();
		boardService.boardFileDelete(key);
		boardService.boardfrmDelete(key);
		
		if(renamedFileName != null) {
			String saveDirectory = request.getServletContext().getRealPath("/resources/upload/board");
			File delFile = new File(saveDirectory, renamedFileName);
			delFile.delete();
		}

		return "redirect:/board/boardList.do";
		
	}
	
	@RequestMapping("/boardfrmDelete2.do")
	
	public String boardfrmDelete2(@RequestParam("key") int key, Attachment attachment,HttpServletRequest request,RedirectAttributes redirectAttr) {
			
		String renamedFileName = attachment.getReName();
		boardService.boardFileDelete(key);
		boardService.boardfrmDelete(key);
		
		if(renamedFileName != null) {
			String saveDirectory = request.getServletContext().getRealPath("/resources/upload/board");
			File delFile = new File(saveDirectory, renamedFileName);
			delFile.delete();
		}

		return "redirect:/board/boardTeamList.do";
		
	}
	
	@RequestMapping("/boardTeamList.do")
	public ModelAndView boardTeamList(ModelAndView mav,HttpServletRequest request,@SessionAttribute("loginMember") Member loginMember) {

		int numPerPage = 10;
		int cPage = 1;
		int startRnum = (cPage-1) * numPerPage + 1;
		int endRnum = cPage * numPerPage;
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		} catch (NumberFormatException e) {
			
		}
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("startRnum", startRnum);
		map.put("endRnum", endRnum);
		String name = boardService.selectTeamName(loginMember);
		List<Map<String, Object>> list = boardService.selectTeamBoardMapList(loginMember);
		/* log.debug("loginMember = {}",loginMember); */
		int totalContents = boardService.countBoard();
		
		String url = request.getRequestURI();
		String pageBar = Paging.getPageBarHtml(cPage, numPerPage, totalContents, url);
		
		log.debug("list = {}", list);
		mav.addObject("list", list);
		mav.addObject("name",name);
		log.debug("name22 = {}",name);
		mav.addObject("pagebar",pageBar);
		
		mav.setViewName("board/boardTeamList");
		return mav;
	}
	@RequestMapping("/boardForm2.do")
	public void boardForm2() {

	}
	
	@RequestMapping(value = "/boardEnroll2.do",
			method = RequestMethod.POST)
	public String boardEnroll2(Board board,@RequestParam("deptKey") int deptKey,
						  @RequestParam(value = "upFile",
								  	    required = false) MultipartFile[] upFiles,
						  RedirectAttributes redirectAttr,
						  HttpServletRequest request,@SessionAttribute("loginMember") Member loginMember) 
								  throws IllegalStateException, IOException {

		
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
		
		//2.메모리의 파일 -> 서버컴퓨터 디렉토리 저장  transferTo
		File dest = new File(saveDirectory, renamedFilename);
		upFile.transferTo(dest);
		
		//3.attachment객체 생성
		Attachment attach = new Attachment();
		attach.setOriginName(upFile.getOriginalFilename());
		attach.setReName(renamedFilename);
		attachList.add(attach);
		
	}
	
	log.debug("attachList = {}", attachList);
	board.setAttachList(attachList);
	board.setDeptKey(deptKey);
	//2. Board, Attachment객체 DB에 저장하기
	int result = boardService.insertTeamBoard(board);
	
	//3. 처리결과 msg 전달
	redirectAttr.addFlashAttribute("msg", "게시글 등록 성공");
	
	
	return "redirect:/board/boardTeamList.do";
	}
	
	@RequestMapping("/boardSearch.do")
	public String boardSearch(@RequestParam("searchKeyword")String searchKeyword,
									Model model,HttpServletRequest request) {
		
		int numPerPage = 2;
		int cPage = 1;
		
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		} catch (NumberFormatException e) {
			
		}
		int totalContents = boardService.countNameBoard(searchKeyword);
		/* log.debug("totalContents = {} ",totalContents); */
		String url = request.getRequestURI();
		/* log.debug("url = {} " , url); */
		String pageBar = PagingType.getPageBarHtml(cPage, numPerPage, totalContents, url, searchKeyword);
		Map<String,Object> map = new HashMap<String, Object>();
	
		List<Map<String, Object>> list = boardService.boardSearch(searchKeyword,cPage,numPerPage,map);
		model.addAttribute("list", list);
		model.addAttribute("pagebar",pageBar);		
		return "board/boardFindNList";
	}
		
	
	@RequestMapping("/boardMaList.do")
	public ModelAndView boardMaList(ModelAndView mav,HttpServletRequest request,@SessionAttribute("loginMember") Member loginMember) {

		int numPerPage = 3;
		int cPage = 1;
		
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		} catch (NumberFormatException e) {
			
		}
		int totalContents = boardService.countBoard3();
		/* log.debug("totalContents = {} ",totalContents); */
		String url = request.getRequestURI();
		/* log.debug("url = {} " , url); */
		String pageBar = Paging.getPageBarHtml(cPage, numPerPage, totalContents, url);
		Map<String,Object> map = new HashMap<String, Object>();
	
		List<Map<String, Object>> list = boardService.selectMaList(cPage,numPerPage,map);
		mav.addObject("list", list);
		mav.addObject("pagebar",pageBar);		
		
		mav.setViewName("board/boardManager");
		return mav;
	}
	@RequestMapping("/boardFormMa.do")
		public void boardFormMa() {

	}
	
	@RequestMapping(value = "/boardEnroll3.do",
			method = RequestMethod.POST)
	public String boardEnroll3(Board board,@RequestParam("name") String name, 
						  @RequestParam(value = "upFile",
								  	    required = false) MultipartFile[] upFiles,
						  RedirectAttributes redirectAttr,
						  HttpServletRequest request) 
								  throws IllegalStateException, IOException {
	log.debug("board = {}", board);
	
	
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
		
		//2.메모리의 파일 -> 서버컴퓨터 디렉토리 저장  transferTo
		File dest = new File(saveDirectory, renamedFilename);
		upFile.transferTo(dest);
		
		//3.attachment객체 생성
		Attachment attach = new Attachment();
		attach.setOriginName(upFile.getOriginalFilename());
		attach.setReName(renamedFilename);
		attachList.add(attach);
		
	//		log.debug("upFile.name = {}", upFile.getOriginalFilename());
	//		log.debug("upFile.size = {}", upFile.getSize());
		
	}
	
	log.debug("attachList = {}", attachList);
	board.setAttachList(attachList);
	board.setName(name);
	
	//2. Board, Attachment객체 DB에 저장하기
	int result = boardService.insertMaBoard(board);
	
	//3. 처리결과 msg 전달
	redirectAttr.addFlashAttribute("msg", "게시글 등록 성공");
	
	
	return "redirect:/board/boardMaList.do";
	}
	
	@RequestMapping("/boardDetail3.do")
	public ModelAndView boardDetail3(@RequestParam("key") int key, ModelAndView mav,
  			HttpServletRequest request, HttpServletResponse response,@SessionAttribute("loginMember") Member loginMember) {

	Cookie[] cookies = request.getCookies();
	String boardCookieVal = "";
	boolean hasRead = false;//현재 요청(브라우져)에서 이 게시글을 이미 읽었는가 여부
	
	if(cookies != null) {
	for(Cookie c : cookies) {
	String name = c.getName();
	String value = c.getValue();
	
	if("boardCookie".equals(name)) {
	boardCookieVal = value;
	//System.out.println(name + " = " + value);
	
	//이번 게시글 읽음 여부
	if(value.contains("[" + key + "]")) {
	hasRead = true;
	break;
	}
	
	}
	}
	}
	
	//게시글을 읽지 않은 경우
	if(hasRead == false) {
	Cookie boardCookie = new Cookie("boardCookie",
						boardCookieVal + "[" + key + "]");
	boardCookie.setMaxAge(365*24*60*60);//영속쿠키
	// /mvc/board/view
	boardCookie.setPath(request.getContextPath() + "/board/");
	response.addCookie(boardCookie);
	}
	
	//collection 이용 join
	Board board = boardService.selectOneBoardCollection(key,hasRead);
	List<BoardComment> commentList = boardService.selectCommentList(key);
	
	/* log.debug("commentList = {}", commentList); */
	mav.addObject("board", board);
	mav.addObject("commentList", commentList);
	
	mav.setViewName("board/boardDetail3");
	
	return mav;
	}
	
	@RequestMapping("boardfrmDelete3.do")
	public String boardfrmDelete3(@RequestParam("key") int key, Attachment attachment,HttpServletRequest request,RedirectAttributes redirectAttr) {
		
		String renamedFileName = attachment.getReName();
		boardService.boardFileDelete(key);
		boardService.boardfrmDelete(key);
		
		if(renamedFileName != null) {
			String saveDirectory = request.getServletContext().getRealPath("/resources/upload/board");
			File delFile = new File(saveDirectory, renamedFileName);
			delFile.delete();
		}

		return "redirect:/board/boardMaList.do";
		
	}
	
	@RequestMapping("/boardSearch2.do")
	public String boardSearch2(@RequestParam("searchKeyword")String searchKeyword,
								Model model,HttpServletRequest request) {

		int numPerPage = 2;
		int cPage = 1;
		
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		} catch (NumberFormatException e) {
			
		}
		int totalContents = boardService.countTitleBoard(searchKeyword);
		/* log.debug("totalContents = {} ",totalContents); */
		String url = request.getRequestURI();
		/* log.debug("url = {} " , url); */
		String pageBar = PagingType.getPageBarHtml(cPage, numPerPage, totalContents, url, searchKeyword);
		Map<String,Object> map = new HashMap<String, Object>();
		List<Map<String, Object>> list = boardService.boardtitleSearch(searchKeyword,cPage,numPerPage,map);
		
		log.debug("list222 ={}" , list);
		model.addAttribute("list", list);
		model.addAttribute("pagebar",pageBar);		
		return "board/boardFindNList";
	}
	
	@RequestMapping("/boardTeamSearch.do")
	public String boardTeamSearch(Board board,@RequestParam("searchKeyword")String searchKeyword,
			Model model,@SessionAttribute("loginMember") Member loginMember) {
		
		loginMember.setSearchKeyword(searchKeyword);
		List<Board> list = boardService.boardTeamSearch(loginMember);
		 log.debug("loginMember = {}",loginMember); 
		model.addAttribute("list", list);
		return "board/boardFindTList";
	}
	
	@RequestMapping("/boardTeamSearch2.do")
	public String boardTeamSearch2(Board board,@RequestParam("searchKeyword")String searchKeyword,
			Model model,@SessionAttribute("loginMember") Member loginMember) {
		
		loginMember.setSearchKeyword(searchKeyword);
		List<Board> list = boardService.boardTeamSearch2(loginMember);
		 log.debug("loginMember = {}",loginMember); 
		model.addAttribute("list", list);
		return "board/boardFindTList";
	}
	
	@RequestMapping("/boardMSearch.do")
	public String boardMSearch(@RequestParam("searchKeyword")String searchKeyword,
								Model model,HttpServletRequest request) {

		int numPerPage = 2;
		int cPage = 1;
		
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		} catch (NumberFormatException e) {
			
		}
		int totalContents = boardService.countTitleBoard3(searchKeyword);
		/* log.debug("totalContents = {} ",totalContents); */
		String url = request.getRequestURI();
		/* log.debug("url = {} " , url); */
		String pageBar = PagingType.getPageBarHtml(cPage, numPerPage, totalContents, url, searchKeyword);
		Map<String,Object> map = new HashMap<String, Object>();
	
		List<Map<String, Object>> list = boardService.boardMSearch(searchKeyword,cPage,numPerPage,map);
		model.addAttribute("list", list);
		model.addAttribute("pagebar",pageBar);		
		return "board/boardFindMList";
	}
		
	@RequestMapping("/boardMSearch2.do")
	public String boardMSearch2(@RequestParam("searchKeyword")String searchKeyword,
								Model model,HttpServletRequest request) {
		int numPerPage = 4;
		int cPage = 1;
		
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		} catch (NumberFormatException e) {
			
		}
		int totalContents = boardService.countNameBoard3(searchKeyword);
		/* log.debug("totalContents = {} ",totalContents); */
		String url = request.getRequestURI();
		/* log.debug("url = {} " , url); */
		String pageBar = PagingType.getPageBarHtml(cPage, numPerPage, totalContents, url, searchKeyword);
		Map<String,Object> map = new HashMap<String, Object>();
	
		List<Map<String, Object>> list = boardService.boardMSearch2(searchKeyword,cPage,numPerPage,map);
		model.addAttribute("list", list);
		model.addAttribute("pagebar",pageBar);		
		return "board/boardFindMList";
	}
	@RequestMapping(value="/RecUpdate.do")
	@ResponseBody
	public Object RecUpdate(@RequestParam("key")int key,@RequestParam("id")String id) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("key", key);
		map.put("id", id);

		int result = boardService.recCheck(map);
		log.debug("result= {}",result);
		if(result == 0){ // 추천하지 않았다면 추천 추가
			boardService.recUpdate(map);
		}else{ // 추천을 하였다면 추천 삭제
			boardService.recDelete(map);
		}
		
		return result;
	}

	@ResponseBody
	@RequestMapping("/RecCount.do")
	public Object RecCount(@RequestParam("key")int key) {
		
		int count = boardService.RecCount(key);
		log.debug("count={}",count );
		return count;
	}
}
