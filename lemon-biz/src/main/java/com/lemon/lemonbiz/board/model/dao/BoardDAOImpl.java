package com.lemon.lemonbiz.board.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lemon.lemonbiz.board.model.vo.Board;

@Repository
public class BoardDAOImpl implements BoardDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<Map<String, Object>> selectBoardMapList() {
		return sqlSession.selectList("board.selectBoardMapList");
	}

	
	
	
	/*
	 * @Override public Board selectOneBoardCollection(int no) { return
	 * sqlSession.selectOne("board.selectOneBoardCollection",no); }
	 */
	 
	 

}
