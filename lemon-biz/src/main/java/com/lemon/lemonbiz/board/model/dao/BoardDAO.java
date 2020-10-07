package com.lemon.lemonbiz.board.model.dao;

import java.util.List;
import java.util.Map;

import com.lemon.lemonbiz.board.model.vo.Board;

public interface BoardDAO {

	List<Map<String, Object>> selectBoardMapList();

	/* Board selectOneBoardCollection(int no); */

}
