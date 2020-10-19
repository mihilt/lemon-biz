package com.lemon.lemonbiz.board.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.lemon.lemonbiz.board.model.vo.Board;
import com.lemon.lemonbiz.board.model.vo.BoardComment;
import com.lemon.lemonbiz.common.vo.Attachment;
import com.lemon.lemonbiz.member.model.vo.Member;

public interface BoardService {

	List<Map<String, Object>> selectBoardMapList(int cPage, int numPerPage, Map<String, Object> map);

	int insertBoard(Board board);

	Board selectOneBoardCollection(int key);

	Board selectOneBoard(int key);

	Attachment selectOneAttachment(int key);

	Board selectOneBoardCollection(int key, boolean hasRead);

	int updateBoard(Board board);

	int countBoard();

	List<Board> selectBoardList(Map<String, Object> map);

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

	List<Map<String, Object>> boardtitleSearch(String searchKeyword, int cPage, int numPerPage, Map<String, Object> map);

	List<Board> boardTeamSearch(Member loginMember);

	List<Board> boardTeamSearch2(Member loginMember);

	List<Board> boardMSearch(String searchKeyword);

	List<Board> boardMSearch2(String searchKeyword);

	int countBoard3();

	String selectTeamName(Member loginMember);

	

	





	



}
