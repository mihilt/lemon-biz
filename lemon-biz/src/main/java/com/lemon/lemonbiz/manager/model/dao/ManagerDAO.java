package com.lemon.lemonbiz.manager.model.dao;

import com.lemon.lemonbiz.member.model.vo.Dept1;
import com.lemon.lemonbiz.member.model.vo.Rank;

public interface ManagerDAO {

	int insertRank(Rank rank);

	int updateRank(Rank rank);

	int deleteRank(Rank rank);

	Dept1 selectOneDept(Dept1 dept);

	Dept1 selectOneRefDept(Dept1 dept);

	int insertDept(Dept1 dept);

}
