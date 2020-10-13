package com.lemon.lemonbiz.board.model.service;

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

@Transactional(propagation = Propagation.REQUIRED, 
			   isolation = Isolation.READ_COMMITTED,
			   rollbackFor = Exception.class)
@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDAO boardDAO;

	@Override
	public List<Map<String, Object>> selectBoardMapList() {
		return boardDAO.selectBoardMapList();
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
	public int updateBoard(Board board,int key) {
		return boardDAO.updateBoard(board,key);
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




	


	
}
