package com.lemon.lemonbiz.board.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lemon.lemonbiz.board.model.vo.Board;
import com.lemon.lemonbiz.board.model.vo.BoardComment;
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
	public List<Board> selectBoardList(Map<String, Object> map) {
		return sqlSession.selectList("board.selectBoardList",map);
	}


	@Override
	public int insertBoard(Board board) {
		return sqlSession.insert("board.insertBoard", board);
	}

	@Override
	public int insertAttachment(Attachment attach) {
		return sqlSession.insert("board.insertAttachment",attach);
	}
	

	@Override
	public Board selectOneBoard(int key) {
		return sqlSession.selectOne("board.selectOneBoard",key);
	}
	

	@Override
	public List<Attachment> selectAttachList(int key) {
		return sqlSession.selectList("board.selectAttachList",key);
	}

	@Override
	public Board selectOneBoardCollection(int key) {
		return sqlSession.selectOne("board.selectOneBoardCollection",key);
	}

	@Override
	public Attachment selectOneAttachment(int key) {
		return sqlSession.selectOne("board.selectOneAttachment",key);
	}

	@Override
	public int increaseReadConut(int key) {
		return sqlSession.update("board.increaseReadConut",key);
	}


	@Override
	public int updateBoard(Board board,int key) {
		return sqlSession.update("board.updateBoard",board);
	}


	@Override
	public int countBoard() {
		return sqlSession.selectOne("board.countBoard");
	}


	@Override
	public void boardInsert(BoardComment boardComment) {
		sqlSession.insert("board.boardInsert",boardComment);
		
	}


	@Override
	public List<BoardComment> selectCommentList(int key) {
		return sqlSession.selectList("board.selectCommentList",key);
	}



	



}
