package com.lemon.lemonbiz.board.model.dao;

import java.util.List;
import java.util.Map;

import com.lemon.lemonbiz.board.model.vo.Board;
import com.lemon.lemonbiz.board.model.vo.BoardComment;
import com.lemon.lemonbiz.common.vo.Attachment;

public interface BoardDAO {

	List<Map<String, Object>> selectBoardMapList();

	int insertBoard(Board board);

	int insertAttachment(Attachment attach);

	Board selectOneBoardCollection(int key);

	Board selectOneBoard(int key);

	List<Attachment> selectAttachList(int key);

	Attachment selectOneAttachment(int key);

	int increaseReadConut(int key);

	int updateBoard(Board board,int key);

	List<Board> selectBoardList(Map<String, Object> map);

	int countBoard();

	void boardInsert(BoardComment boardComment);

	List<BoardComment> selectCommentList(int key);


	

	



}
