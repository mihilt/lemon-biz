package com.lemon.lemonbiz.cost.model.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lemon.lemonbiz.cost.model.vo.Cost;

@Repository
public class CostDAOImpl implements CostDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int enrollCost(Cost cost) {
		
		return sqlSession.insert("cost.enrollCost",cost);
	}

	@Override
	public List<Cost> selectAllCost(HashMap<Object, Object> params) {
		
		return sqlSession.selectList("cost.selectAllCost",params);
	}
}
