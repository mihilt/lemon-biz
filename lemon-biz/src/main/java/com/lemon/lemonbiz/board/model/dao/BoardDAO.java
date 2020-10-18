package com.lemon.lemonbiz.board.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.lemon.lemonbiz.board.model.vo.Board;
import com.lemon.lemonbiz.board.model.vo.BoardComment;
import com.lemon.lemonbiz.common.vo.Attachment;
import com.lemon.lemonbiz.member.model.vo.Member;

public interface BoardDAO {

	List<Map<String, Object>> selectBoardMapList(int cPage, int numPerPage, Map<String, Object> map);

	int insertBoard(Board board);

	int insertAttachment(Attachment attach);

	Board selectOneBoardCollection(int key);

	Board selectOneBoard(int key);

	List<Attachment> selectAttachList(int key);

	Attachment selectOneAttachment(int key);

	int increaseReadConut(int key);

	int updateBoard(Board board);

	List<Board> selectBoardList(Map<String, Object> map);

	int countBoard();

	void boardInsert(BoardComment boardComment);

	List<BoardComment> selectCommentList(int key);

	void boardDelete(int commentNo);

	void boardfrmDelete(int key);

	void boardFileDelete(int key);

	List<Map<String, Object>> selectTeamBoardMapList(Member loginMember);

	int insertTeamBoard(Board board);

	List<Board> boardSearch(String searchKeyword);

	List<Map<String, Object>> selectMaList(int cPage, int numPerPage, Map<String, Object> map);

	int insertMaBoard(Board board);

	List<Board> boardtitleSearch(String searchKeyword);

	List<Board> boardTeamSearch(Member loginMember);

	List<Board> boardTeamSearch2(Member loginMember);

	List<Board> boardMSearch(String searchKeyword);

	List<Board> boardMSearch2(String searchKeyword);

	int countBoard3();

	

	

	



}
