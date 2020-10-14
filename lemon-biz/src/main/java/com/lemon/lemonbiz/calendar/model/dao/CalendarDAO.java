package com.lemon.lemonbiz.calendar.model.dao;

import java.util.List;

import com.lemon.lemonbiz.calendar.model.vo.Calendar;
import com.lemon.lemonbiz.calendar.model.vo.NewDates;

public interface CalendarDAO {

	int enrollCalendar(Calendar calendar);

	List<Calendar> selectAllList();

	int updateCalendar(Calendar calendar);

	int deleteCalendar(int no);

	int dragNdropCalendar(NewDates newDates);

}
