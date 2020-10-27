package com.lemon.lemonbiz.attend.model.service;

import java.util.HashMap;
import java.util.List;

import com.lemon.lemonbiz.attend.model.vo.Attend;

public interface AttendService {

	List<Attend> selectAttendList(Attend attend);

	Attend selectLastOne(Attend attend);

	int attendArrive(Attend attend);

	int attendLeabe(Attend attend);

	List<Attend> selectCalAttend(Attend attend);

	Attend selectAttendInfo(Attend attend);

	int getTodayCount(String date);


}
