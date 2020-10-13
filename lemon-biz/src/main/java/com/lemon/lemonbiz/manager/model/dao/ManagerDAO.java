package com.lemon.lemonbiz.manager.model.dao;

import com.lemon.lemonbiz.member.model.vo.Dept;
import com.lemon.lemonbiz.member.model.vo.Rank;

public interface ManagerDAO {

	int insertRank(Rank rank);

	int updateRank(Rank rank);

	int deleteRank(Rank rank);

	Dept selectOneDept(Dept dept);

	Dept selectOneRefDept(Dept dept);

	int insertDept(Dept dept);

	int deleteDept(Dept dept);

	int updateDept(Dept dept);

}