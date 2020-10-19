package com.lemon.lemonbiz.calendar.model.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lemon.lemonbiz.calendar.model.dao.CalendarDAO;
import com.lemon.lemonbiz.calendar.model.vo.Calendar;
import com.lemon.lemonbiz.calendar.model.vo.NewDates;
import com.lemon.lemonbiz.member.model.service.MemberService;
import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.notice.model.service.NoticeService;
import com.lemon.lemonbiz.notice.model.vo.Notice;

@Service
public class CalendarServiceImpl implements CalendarService {

	@Autowired
	private CalendarDAO calendarDAO;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private NoticeService noticeService;
	
	
	

	@Override
	public List<Calendar> selectAllList(String memberId) {
		
		return calendarDAO.selectAllList(memberId);
	}

	@Override
	public int enrollCalendar(Calendar calendar) {
		
		if(calendar.getType().equals("회사일정")) {
			// 전체 회원 단체 알림 등록
			List<Member> memberList = memberService.selectMemberList();
			List<Notice> groupNoticeList = new ArrayList<Notice>();
			
			for (Member sameDeptMember : memberList) {
				Notice groupNotice = new Notice();
				groupNotice.setContent("새로운 회사일정 " + "\"" + calendar.getTitle() + "\"" + " 등록되었습니다.");
				groupNotice.setAddress("/calendar/calendar.do");
				groupNotice.setIcon("fa-calendar-alt");
				groupNotice.setColor("primary");
				groupNotice.setMemId(sameDeptMember.getMemberId());
				
				groupNoticeList.add(groupNotice);
			}
			
			noticeService.insertNoticeList(groupNoticeList);
		}
		
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
