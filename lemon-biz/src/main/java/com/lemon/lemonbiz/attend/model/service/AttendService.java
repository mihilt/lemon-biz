package com.lemon.lemonbiz.attend.model.service;

import java.util.List;
import java.util.Map;

import com.lemon.lemonbiz.attend.model.vo.Attend;

public interface AttendService {

	List<Attend> selectAttendList(Attend attend);

	Attend selectLastOne(Attend attend);

	int attendArrive(Attend attend);

	int attendLeabe(Attend attend);

	List<Attend> selectCalAttend(Attend attend);

	Attend selectAttendInfo(Attend attend);

	int countAttend(Attend attend);

	List<Map<String, Object>> selectAttendList(int cPage, int numPerPage, Map<String, Object> map, String memId);

}
