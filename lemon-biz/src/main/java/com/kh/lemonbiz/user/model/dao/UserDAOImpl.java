package com.kh.lemonbiz.user.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDAOImpl implements UserDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public String test() {
		System.out.println(sqlSession.insert("user.test"));
		return null;
		
	}
	
}
