package com.lemon.lemonbiz.board.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lemon.lemonbiz.board.model.dao.BoardDAO;
import com.lemon.lemonbiz.board.model.vo.Board;
import com.lemon.lemonbiz.common.vo.Attachment;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDAO boardDAO;

	@Override
	public List<Map<String, Object>> selectBoardMapList() {
		return boardDAO.selectBoardMapList();
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

	/*
	 * @Override public Board selectOneBoardCollection(int no) { return
	 * boardDAO.selectOneBoardCollection(no); }
	 */

}
