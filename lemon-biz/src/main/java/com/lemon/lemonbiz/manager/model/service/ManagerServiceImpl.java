package com.lemon.lemonbiz.manager.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lemon.lemonbiz.manager.model.dao.ManagerDAO;
import com.lemon.lemonbiz.member.model.vo.Rank;

@Service
public class ManagerServiceImpl implements ManagerService{

	@Autowired
	private ManagerDAO managerDAO;
	
	@Override
	public int insertRank(Rank rank) {
		return managerDAO.insertRank(rank);
	}

}
