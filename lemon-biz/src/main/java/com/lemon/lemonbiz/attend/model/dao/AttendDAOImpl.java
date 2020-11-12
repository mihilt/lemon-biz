package com.lemon.lemonbiz.attend.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lemon.lemonbiz.attend.model.vo.Attend;
import com.lemon.lemonbiz.attend.model.vo.AttendInfo;

@Repository
public class AttendDAOImpl implements AttendDAO {
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int attendArrive(Attend attend) {
		return sqlSession.insert("attend.attendArrive",attend);
	}

	@Override
	public List<Attend> selectAttendList(Attend attend) {
		return sqlSession.selectList("attend.selectAttendList",attend);
	}

	@Override
	public int attendLeabe(Attend attend) {
		return sqlSession.update("attend.attendLeabe",attend);
	}

	@Override
	public List<Attend> selectCalAttend(Attend attend) {
		return sqlSession.selectList("attend.selectCalAttend",attend);
	}
	
	@Override
	public Attend selectLastOne(Attend attend) {
		return sqlSession.selectOne("attend.selectLastOne",attend);
	}

	@Override
	public AttendInfo selectAttendInfo(Attend attend) {
		return sqlSession.selectOne("attend.selectAttendInfo",attend);
	}

	@Override

	public int getTodayCount(String date) {
		
		return sqlSession.selectOne("attend.getTodayCount",date);
	}
	

	public int countAttend(Attend attend) {
		return sqlSession.selectOne("attend.countAttend");
	}

	@Override
	public List<Map<String, Object>> selectAttendList(int cPage, int numPerPage, Map<String, Object> map,String memId) {
		int startRnum = (cPage-1) * numPerPage + 1;
		int endRnum = cPage * numPerPage;
		map.put("cPage", cPage);
		map.put("numPerPage", numPerPage);
		map.put("startRnum", startRnum);
		map.put("endRnum", endRnum);
		map.put("memId",memId);
		return sqlSession.selectList("attend.selectAttendListPaging",map);
	}

	@Override
	public List<Attend> selectAttendList() {
		return sqlSession.selectList("attend.AttendAllList");
	}

	@Override
	public Attend getAttendLeave(HashMap<Object, Object> params) {
		return sqlSession.selectOne("attend.getAttendLeave",params);
	}

	
}