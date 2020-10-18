package com.lemon.lemonbiz.calendar.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lemon.lemonbiz.calendar.model.dao.CalendarDAO;
import com.lemon.lemonbiz.calendar.model.vo.Calendar;
import com.lemon.lemonbiz.calendar.model.vo.NewDates;

@Service
public class CalendarServiceImpl implements CalendarService {

	@Autowired
	private CalendarDAO calendarDAO;
	

	@Override
	public List<Calendar> selectAllList(String memberId) {
		
		return calendarDAO.selectAllList(memberId);
	}

	@Override
	public int enrollCalendar(Calendar calendar) {
		
		return calendarDAO.enrollCalendar(calendar);
	}
	
	@Override
	public int updateCalendar(Calendar calendar) {
		
		return calendarDAO.updateCalendar(calendar);
	}

	@Override
	public int deleteCalendar(int no) {
		
		return calendarDAO.deleteCalendar(no);
	}

	@Override
	public int dragNdropCalendar(NewDates newDates) {
		
		return calendarDAO.dragNdropCalendar(newDates);
	}

}
