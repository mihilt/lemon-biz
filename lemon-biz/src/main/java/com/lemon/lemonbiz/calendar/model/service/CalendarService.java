package com.lemon.lemonbiz.calendar.model.service;

import java.util.List;

import com.lemon.lemonbiz.calendar.model.vo.Calendar;

public interface CalendarService {

	int enrollCalendar(Calendar calendar);

	List<Calendar> selectAllList();

	int updateCalendar(Calendar calendar);

	int deleteCalendar(int no);

}