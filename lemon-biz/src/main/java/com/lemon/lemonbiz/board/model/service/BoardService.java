package com.lemon.lemonbiz.board.model.service;

import java.util.List;
import java.util.Map;

import com.lemon.lemonbiz.board.model.vo.Board;

public interface BoardService {

	List<Map<String, Object>> selectBoardMapList();

	/* Board selectOneBoardCollection(int no); */

}
