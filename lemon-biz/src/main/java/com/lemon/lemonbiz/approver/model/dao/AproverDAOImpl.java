package com.lemon.lemonbiz.approver.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lemon.lemonbiz.approver.model.vo.dept;

@Repository
public class AproverDAOImpl implements ApproverDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<dept> deptList() {
		return sqlSession.selectList("approver.selectDeptList");
	}

	@Override
	public List<dept> child() {
		return sqlSession.selectList("approver.selectChild");
	}

	@Override
	public List<dept> child2() {
		return sqlSession.selectList("approver.selectChild2");
	}
	
	
	
}
