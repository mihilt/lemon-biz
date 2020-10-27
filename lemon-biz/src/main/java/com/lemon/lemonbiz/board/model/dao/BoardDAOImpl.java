package com.lemon.lemonbiz.board.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lemon.lemonbiz.board.model.vo.Board;
import com.lemon.lemonbiz.board.model.vo.BoardComment;
import com.lemon.lemonbiz.common.vo.Attachment;
import com.lemon.lemonbiz.member.model.vo.Member;

@Repository
public class BoardDAOImpl implements BoardDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<Map<String, Object>> selectBoardMapList(int cPage, int numPerPage, Map<String, Object> map) {
		int startRnum = (cPage-1) * numPerPage + 1;
		int endRnum = cPage * numPerPage;
		map.put("cPage", cPage);
		map.put("numPerPage", numPerPage);
		map.put("startRnum", startRnum);
		map.put("endRnum", endRnum);
		return sqlSession.selectList("board.selectBoardMapList",map);
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
	public int updateBoard(Board board) {
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


	@Override
	public void boardDelete(int commentNo) {
		sqlSession.delete("board.boardDelete",commentNo);
		
	}


	@Override
	public void boardfrmDelete(int key) {
		sqlSession.delete("board.boardfrmDelete",key);
	}


	@Override
	public void boardFileDelete(int key) {
		sqlSession.delete("board.boardFileDelete",key);
		
	}


	@Override
	public List<Map<String, Object>> selectTeamBoardMapList(Member loginMember) {
		return sqlSession.selectList("board.selectTeamBoardMapList",loginMember);
	}


	@Override
	public int insertTeamBoard(Board board) {
		return sqlSession.insert("board.insertTeamBoard",board);
	}


	@Override
	public List<Board> boardSearch(String searchKeyword) {
		return sqlSession.selectList("board.boardSearch",searchKeyword);
	}


	@Override
	public List<Map<String, Object>> selectMaList(int cPage, int numPerPage, Map<String, Object> map) {
			int startRnum = (cPage-1) * numPerPage + 1;
			int endRnum = cPage * numPerPage;
			map.put("cPage", cPage);
			map.put("numPerPage", numPerPage);
			map.put("startRnum", startRnum);
			map.put("endRnum", endRnum);
		return sqlSession.selectList("board.selectMaList",map);
	}


	@Override
	public int insertMaBoard(Board board) {
		return sqlSession.insert("board.insertMaBoard", board);
	}


	@Override
	public List<Board> boardtitleSearch(String searchKeyword) {
		return sqlSession.selectList("board.boardtitleSearch",searchKeyword);
	}


	@Override
	public List<Board> boardTeamSearch(Member loginMember) {
		return sqlSession.selectList("board.boardTeamSearch",loginMember);
	}


	@Override
	public List<Board> boardTeamSearch2(Member loginMember) {
		return sqlSession.selectList("board.boardTeamSearch2",loginMember);
	}


	@Override
	public List<Board> boardMSearch(String searchKeyword) {
		return sqlSession.selectList("board.boardMSearch",searchKeyword);
	}


	@Override
	public List<Board> boardMSearch2(String searchKeyword) {
		return sqlSession.selectList("board.boardMSearch2",searchKeyword);
	}


	@Override
	public int countBoard3() {
		return sqlSession.selectOne("board.countBoard3");
	}


	@Override
	public String selectTeamName(Member loginMember) {
		return sqlSession.selectOne("board.selectTeamName",loginMember);
	}


	@Override
	public List getBoardTopFive() {
		
		return sqlSession.selectList("board.getBoardTopFive");
	}




}
