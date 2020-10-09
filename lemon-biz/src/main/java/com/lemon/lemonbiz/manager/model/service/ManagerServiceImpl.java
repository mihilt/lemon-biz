package com.lemon.lemonbiz.manager.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lemon.lemonbiz.manager.model.dao.ManagerDAO;
import com.lemon.lemonbiz.member.model.vo.Dept1;
import com.lemon.lemonbiz.member.model.vo.Rank;

@Service
public class ManagerServiceImpl implements ManagerService{

	@Autowired
	private ManagerDAO managerDAO;
	
	@Override
	public int insertRank(Rank rank) {
		return managerDAO.insertRank(rank);
	}

	@Override
	public int updateRank(Rank rank) {
		return managerDAO.updateRank(rank);
	}

	@Override
	public int deleteRank(Rank rank) {
		return managerDAO.deleteRank(rank);
	}

	@Override
	public Dept1 selectOneDept(Dept1 dept) {
		return managerDAO.selectOneDept(dept);
	}

	@Override
	public Dept1 selectOneRefDept(Dept1 dept) {
		return managerDAO.selectOneRefDept(dept);
	}

	@Override
	public int insertDept(Dept1 dept) {
		return managerDAO.insertDept(dept);
	}
	

}
