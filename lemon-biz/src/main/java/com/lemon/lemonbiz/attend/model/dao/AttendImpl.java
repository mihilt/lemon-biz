package com.lemon.lemonbiz.attend.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lemon.lemonbiz.attend.model.vo.Attend;


@Repository
public class AttendImpl implements AttendDAO {
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int attendArrive(Attend attend) {
		return sqlSession.insert("attend.attendArrive",attend);
	}

	@Override
	public List<Attend> selectAttendList() {
		return sqlSession.selectList("attend.selectAttendList");
	}

	@Override
	public int attendLeabe(Attend attend) {
		return sqlSession.update("attend.attendLeabe",attend);
	}
	
	
}
