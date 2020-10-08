package com.lemon.lemonbiz.manager.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lemon.lemonbiz.member.model.vo.Dept;
import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.member.model.vo.Rank;

@Repository
public class ManagerDAOImpl implements ManagerDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int insertRank(Rank rank) {
		return sqlSession.insert("manager.insertRank", rank);
	}
	
}
