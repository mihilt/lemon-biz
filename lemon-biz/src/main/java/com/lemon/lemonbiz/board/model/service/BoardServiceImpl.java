
package com.lemon.lemonbiz.board.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lemon.lemonbiz.board.model.dao.BoardDAO;
import com.lemon.lemonbiz.board.model.vo.Board;
import com.lemon.lemonbiz.board.model.vo.BoardComment;
import com.lemon.lemonbiz.common.vo.Attachment;
import com.lemon.lemonbiz.member.model.service.MemberService;
import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.notice.model.service.NoticeService;
import com.lemon.lemonbiz.notice.model.vo.Notice;

@Transactional(propagation = Propagation.REQUIRED, 
			   isolation = Isolation.READ_COMMITTED,
			   rollbackFor = Exception.class)
@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDAO boardDAO;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private NoticeService noticeService;

	@Override
	public List<Map<String, Object>> selectBoardMapList(int cPage, int numPerPage, Map<String, Object> map) {
		return boardDAO.selectBoardMapList(cPage,numPerPage,map);
	}
	
	
	@Override
	public List<Board> selectBoardList(Map<String, Object> map) {
		return boardDAO.selectBoardList(map);
	}


	@Override
	public int insertBoard(Board board) {
		int result = 0;
		//1. board insert
		result = boardDAO.insertBoard(board);
		
		//2. attachment insert
		if(board.getAttachList() != null) {
			
			for(Attachment attach : board.getAttachList()) {
				//생성된 boardNo값 대입하기
				attach.setPostKey(board.getKey());
				result = boardDAO.insertAttachment(attach);
			}
			
		}			
		return result;
	}
	
	@Transactional(readOnly = true)
	@Override
	public Board selectOneBoard(int key) {
		//1. board테이블 조회
		Board board = boardDAO.selectOneBoard(key);
		
		//2. attachment 테이블 조회
		List<Attachment> attachList = boardDAO.selectAttachList(key);
		board.setAttachList(attachList);
		
		return board;
	}
	
	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public Board selectOneBoardCollection(int key) {
		int result = boardDAO.increaseReadConut(key);
		return boardDAO.selectOneBoardCollection(key);
	}

	@Override
	public Attachment selectOneAttachment(int key) {
		return boardDAO.selectOneAttachment(key);
	}

	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public Board selectOneBoardCollection(int key, boolean hasRead) {
		
		if(hasRead == false) {			
			int result = boardDAO.increaseReadConut(key);
		}
		return boardDAO.selectOneBoardCollection(key);
	}


	@Override
	public int updateBoard(Board board) {
		return boardDAO.updateBoard(board);
	}


	@Override
	public int countBoard() {
		return boardDAO.countBoard();
	}


	@Override
	public void boardInsert(BoardComment boardComment) {
		boardDAO.boardInsert(boardComment);
		
	}


	@Override
	public List<BoardComment> selectCommentList(int key) {
		return boardDAO.selectCommentList(key);
	}


	@Override
	public void boardDelete(int commentNo) {
		boardDAO.boardDelete(commentNo);
		
	}


	@Override
	public void boardfrmDelete(int key) {
		boardDAO.boardfrmDelete(key);
	}


	@Override
	public void boardFileDelete(int key) {
		boardDAO.boardFileDelete(key);
		
	}


	@Override
	public List<Map<String, Object>> selectTeamBoardMapList(Member loginMember) {
		return boardDAO.selectTeamBoardMapList(loginMember);
	}


	@Override
	public int insertTeamBoard(Board board) {
		
		int result = 0;
		//1. board insert
		result = boardDAO.insertTeamBoard(board);
		
		//2. attachment insert
		if(board.getAttachList() != null) {
			
			for(Attachment attach : board.getAttachList()) {
				//생성된 boardNo값 대입하기
				attach.setPostKey(board.getKey());
				result = boardDAO.insertAttachment(attach);
			}
			
		}			
		return result;
	}


	@Override
	public List<Board> boardSearch(String searchKeyword) {
		return boardDAO.boardSearch(searchKeyword);
	}


	@Override
	public List<Map<String, Object>> selectMaList(int cPage, int numPerPage, Map<String, Object> map) {
		return boardDAO.selectMaList(cPage,numPerPage,map);
	}


	@Override
	public int insertMaBoard(Board board) {

		int result = 0;
		//1. board insert
		result = boardDAO.insertMaBoard(board);
		
		//2. attachment insert
		if(board.getAttachList() != null) {
			
			for(Attachment attach : board.getAttachList()) {
				//생성된 boardNo값 대입하기
				attach.setPostKey(board.getKey());
				result = boardDAO.insertAttachment(attach);
			}
			
		}
		
		// 전체 회원 단체 알림 등록
		List<Member> memberList = memberService.selectMemberList();
		List<Notice> groupNoticeList = new ArrayList<Notice>();
		
		
		for (Member sameDeptMember : memberList) {
			Notice groupNotice = new Notice();
			groupNotice.setContent("새로운 공지사항 " + "\"" + board.getTitle() + "\"" + " 등록되었습니다.");
			groupNotice.setAddress("/board/boardMaList.do");
			groupNotice.setIcon("fa-exclamation");
			groupNotice.setColor("danger");
			groupNotice.setMemId(sameDeptMember.getMemberId());
			
			groupNoticeList.add(groupNotice);
		}
		
		noticeService.insertNoticeList(groupNoticeList);
		
		return result;
	}


	@Override
	public List<Board> boardtitleSearch(String searchKeyword) {
		return boardDAO.boardtitleSearch(searchKeyword);
	}


	@Override
	public List<Board> boardTeamSearch(Member loginMember) {
		return boardDAO.boardTeamSearch(loginMember);
	}


	@Override
	public List<Board> boardTeamSearch2(Member loginMember) {
		return boardDAO.boardTeamSearch2(loginMember);
	}


	@Override
	public List<Board> boardMSearch(String searchKeyword) {
		return boardDAO.boardMSearch(searchKeyword);
	}


	@Override
	public List<Board> boardMSearch2(String searchKeyword) {
		return boardDAO.boardMSearch2(searchKeyword);
	}


	@Override
	public int countBoard3() {
		return boardDAO.countBoard3();
	}


	@Override
	public String selectTeamName(Member loginMember) {
		return boardDAO.selectTeamName(loginMember);
	}


	@Override
	public List getBoardTopFive() {
		
		return boardDAO.getBoardTopFive();
	}
	
	


	


	
}
