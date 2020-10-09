package com.lemon.lemonbiz.approval.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.member.model.vo.Dept1;


@Repository
public class approvalDAOImpl implements approvalDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<Dept1> deptList() {
		return sqlSession.selectList("approval.selectDeptList");
	}

	@Override
	public List<Dept1> child() {
		return sqlSession.selectList("approval.selectChild");
	}

	@Override
	public List<Dept1> child2() {
		return sqlSession.selectList("approval.selectChild2");
	}

	@Override
	public List<Member> memberList(String node) {
		return sqlSession.selectList("approval.memberList",node);
	}
	
	
	
}
