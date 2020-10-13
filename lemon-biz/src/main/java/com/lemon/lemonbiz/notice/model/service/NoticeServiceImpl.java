package com.lemon.lemonbiz.notice.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.notice.model.dao.NoticeDAO;
import com.lemon.lemonbiz.notice.model.vo.Notice;

@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	private NoticeDAO noticeDAO;

	@Override
	public List<Notice> selectNoticeList(Member loginMember) {
		return noticeDAO.selectNoticeList(loginMember);
	}

	@Override
	public int insertNotice(Notice notice) {
		return noticeDAO.insertNotice(notice);
	}
	
}
