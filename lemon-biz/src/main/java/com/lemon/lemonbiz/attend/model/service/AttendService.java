package com.lemon.lemonbiz.attend.model.service;

import java.util.List;

import com.lemon.lemonbiz.attend.model.vo.Attend;

public interface AttendService {

	List<Attend> selectAttendList();

	int attendArrive(Attend attend);

	int attendLeabe(Attend attend);

	List<Attend> selectCalArrive(Attend attend);

	List<Attend> selectCalAttend(Attend attend);

}
