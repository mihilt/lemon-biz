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

	int updateBoard(Board board, List<Attachment> oldBoard);

	int countBoard();

	List<Board> selectBoardList(Map<String, Object> map);

	void boardInsert(BoardComment boardComment);

	List<BoardComment> selectCommentList(int key);

	void boardDelete(int commentNo);

	void boardfrmDelete(int key);

	void boardFileDelete(int key);

	List<Map<String, Object>> selectTeamBoardMapList(Member loginMember);

	int insertTeamBoard(Board board);

	List<Map<String, Object>> boardSearch(String searchKeyword, int cPage, int numPerPage, Map<String, Object> map);

	List<Map<String, Object>> selectMaList(int cPage, int numPerPage, Map<String, Object> map);

	int insertMaBoard(Board board);

	List<Map<String, Object>> boardtitleSearch(String searchKeyword, int cPage, int numPerPage, Map<String, Object> map);

	List<Board> boardTeamSearch(Member loginMember);

	List<Board> boardTeamSearch2(Member loginMember);

	List<Map<String, Object>> boardMSearch(String searchKeyword, int cPage, int numPerPage, Map<String, Object> map);

	List<Map<String, Object>> boardMSearch2(String searchKeyword, int cPage, int numPerPage, Map<String, Object> map);

	int countBoard3();

	String selectTeamName(Member loginMember);

	List getBoardTopFive();

	int countTitleBoard(String searchKeyword);

	int countNameBoard(String searchKeyword);

	int countTitleBoard3(String searchKeyword);

	int countNameBoard3(String searchKeyword);

	List<Attachment> SelectBoardOne(int key);

	void updateAttachment(int boardKey);

	void updateAttachment2(int boardKey2);

	int recCheck(Map<String, Object> map);

	void recUpdate(Map<String, Object> map);

	void recDelete(Map<String, Object> map);

	int RecCount(int key);

	void boardGoodDelete(int key);

	void updateBoard2(Board board, List<Attachment> oldBoard);

	void updateBoard3(Board board);


	

	





	



}
