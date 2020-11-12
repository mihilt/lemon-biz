package com.lemon.lemonbiz.attend.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.lemon.lemonbiz.attend.model.vo.Attend;
import com.lemon.lemonbiz.attend.model.vo.AttendInfo;

public interface AttendService {

	List<Attend> selectAttendList(Attend attend);

	Attend selectLastOne(Attend attend);

	int attendArrive(Attend attend);

	int attendLeabe(Attend attend);

	List<Attend> selectCalAttend(Attend attend);

	AttendInfo selectAttendInfo(Attend attend);


	int getTodayCount(String date);


	int countAttend(Attend attend);

	List<Map<String, Object>> selectAttendList(int cPage, int numPerPage, Map<String, Object> map, String memId);

	List<Attend> selectAttendList();

	Attend getAttendLeave(HashMap<Object, Object> params);


}
