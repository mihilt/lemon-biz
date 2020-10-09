package com.lemon.lemonbiz.manager.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lemon.lemonbiz.member.model.vo.Dept1;
import com.lemon.lemonbiz.member.model.vo.Rank;

@Repository
public class ManagerDAOImpl implements ManagerDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int insertRank(Rank rank) {
		return sqlSession.insert("manager.insertRank", rank);
	}

	@Override
	public int updateRank(Rank rank) {
		return sqlSession.update("manager.updateRank", rank);
	}

	@Override
	public int deleteRank(Rank rank) {
		return sqlSession.delete("manager.deleteRank", rank);
	}

	@Override
	public Dept1 selectOneDept(Dept1 dept) {
		return sqlSession.selectOne("manager.selectOneDept", dept);
	}

	@Override
	public Dept1 selectOneRefDept(Dept1 dept) {
		return sqlSession.selectOne("manager.selectOneRefDept", dept);
	}

	@Override
	public int insertDept(Dept1 dept) {
		return sqlSession.insert("manager.insertDept", dept);
	}
	
	
}
