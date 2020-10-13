package com.lemon.lemonbiz.calendar.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.lemon.lemonbiz.calendar.model.vo.Calendar;

@Repository
public class CalendarDAOImpl implements CalendarDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;


	@Override
	public List<Calendar> selectAllList() {
	
		return sqlSession.selectList("calendar.selectAllList");
	}

	@Override
	public int enrollCalendar(Calendar calendar) {
		
		return sqlSession.insert("calendar.enrollCalendar",calendar);
	}

	@Override
	public int updateCalendar(Calendar calendar) {
		
		return sqlSession.update("calendar.updateCalendar",calendar);
	}

	@Override
	public int deleteCalendar(int no) {
		
		return sqlSession.delete("calendar.deleteCalendar",no);
	}

}
