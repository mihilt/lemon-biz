package com.lemon.lemonbiz.board.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lemon.lemonbiz.board.model.dao.BoardDAO;
import com.lemon.lemonbiz.board.model.vo.Board;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDAO boardDAO;

	@Override
	public List<Map<String, Object>> selectBoardMapList() {
		return boardDAO.selectBoardMapList();
	}

	/*
	 * @Override public Board selectOneBoardCollection(int no) { return
	 * boardDAO.selectOneBoardCollection(no); }
	 */

}
