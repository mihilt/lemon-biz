package com.lemon.lemonbiz.board.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lemon.lemonbiz.board.model.vo.Board;
import com.lemon.lemonbiz.common.vo.Attachment;

@Repository
public class BoardDAOImpl implements BoardDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<Map<String, Object>> selectBoardMapList() {
		return sqlSession.selectList("board.selectBoardMapList");
	}

	@Override
	public int insertBoard(Board board) {
		return sqlSession.insert("board.insertBoard", board);
	}

	@Override
	public int insertAttachment(Attachment attach) {
		return sqlSession.insert("board.insertAttachment",attach);
	}

	
	
	
	/*
	 * @Override public Board selectOneBoardCollection(int no) { return
	 * sqlSession.selectOne("board.selectOneBoardCollection",no); }
	 */
	 
	 

}
