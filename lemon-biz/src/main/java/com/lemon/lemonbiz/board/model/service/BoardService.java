package com.lemon.lemonbiz.board.model.service;

import java.util.List;
import java.util.Map;

import com.lemon.lemonbiz.board.model.vo.Board;
import com.lemon.lemonbiz.board.model.vo.BoardComment;
import com.lemon.lemonbiz.common.vo.Attachment;

public interface BoardService {

	List<Map<String, Object>> selectBoardMapList();

	int insertBoard(Board board);

	Board selectOneBoardCollection(int key);

	Board selectOneBoard(int key);

	Attachment selectOneAttachment(int key);

	Board selectOneBoardCollection(int key, boolean hasRead);

	int updateBoard(Board board, int key);

	int countBoard();

	List<Board> selectBoardList(Map<String, Object> map);

	void boardInsert(BoardComment boardComment);

	List<BoardComment> selectCommentList(int key);



	



}
