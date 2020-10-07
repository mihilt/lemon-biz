package com.lemon.lemonbiz.board.model.dao;

import java.util.List;
import java.util.Map;

import com.lemon.lemonbiz.board.model.vo.Board;
import com.lemon.lemonbiz.common.vo.Attachment;

public interface BoardDAO {

	List<Map<String, Object>> selectBoardMapList();

	int insertBoard(Board board);

	int insertAttachment(Attachment attach);

	/* Board selectOneBoardCollection(int no); */

}
