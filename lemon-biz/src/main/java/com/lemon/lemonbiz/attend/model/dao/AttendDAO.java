package com.lemon.lemonbiz.attend.model.dao;

import java.util.List;

import com.lemon.lemonbiz.attend.model.vo.Attend;

public interface AttendDAO {

	List<Attend> selectAttendList();

	int attendArrive(Attend attend);

	int attendLeabe(Attend attend);

	List<Attend> CalArrive(Attend attend);

	List<Attend> selectCalAttend(Attend attend);

}
