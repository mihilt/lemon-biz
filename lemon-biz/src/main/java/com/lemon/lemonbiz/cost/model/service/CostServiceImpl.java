package com.lemon.lemonbiz.cost.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lemon.lemonbiz.cost.model.dao.CostDAO;
import com.lemon.lemonbiz.cost.model.vo.Cost;

@Service
public class CostServiceImpl implements CostService {

	@Autowired
	private CostDAO costDAO;

	@Override
	public int enrollCost(Cost cost) {
		
		return costDAO.enrollCost(cost);
	}

	@Override
	public List<Cost> selectAllCost(String memberId) {
		
		return costDAO.selectAllCost(memberId);
	}
}
