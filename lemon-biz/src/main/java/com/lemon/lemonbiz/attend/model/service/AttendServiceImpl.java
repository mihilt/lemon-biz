package com.lemon.lemonbiz.attend.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lemon.lemonbiz.attend.model.dao.AttendDAO;
import com.lemon.lemonbiz.attend.model.vo.Attend;

@Service
public class AttendServiceImpl implements AttendService {

	@Autowired
	private AttendDAO attendanDAO;

	@Override
	public List<Attend> selectAttendList(Attend attend) {
		return attendanDAO.selectAttendList(attend);
	}

	@Override
	public Attend selectLastOne(Attend attend) {
		return attendanDAO.selectLastOne(attend);
	}
	
	@Override
	public int attendArrive(Attend attend) {
		return attendanDAO.attendArrive(attend);
	}
	
	@Override
	public int attendLeabe(Attend attend) {
		return attendanDAO.attendLeabe(attend);
	}

	@Override
	public List<Attend> selectCalAttend(Attend attend) {
		return attendanDAO.selectCalAttend(attend);
	}

	@Override
	public Attend selectAttendInfo(Attend attend) {
		return attendanDAO.selectAttendInfo(attend);
	}


}
