package com.lemon.lemonbiz.approval.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lemon.lemonbiz.member.model.vo.Dept;

@Repository
public class approvalDAOImpl implements approvalDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<Dept> deptList() {
		return sqlSession.selectList("approval.selectDeptList");
	}

	@Override
	public List<Dept> child() {
		return sqlSession.selectList("approval.selectChild");
	}

	@Override
	public List<Dept> child2() {
		return sqlSession.selectList("approval.selectChild2");
	}
	
	
	
}
