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
	public List<Notice> selectNoticeUncheckedList(Member loginMember) {
		return noticeDAO.selectNoticeUncheckedList(loginMember);
	}

	@Override
	public int insertNotice(Notice notice) {
		return noticeDAO.insertNotice(notice);
	}

	@Override
	public int checkNotice(Notice notice) {
		return noticeDAO.checkNotice(notice);
	}

	@Override
	public List<Notice> selectNoticeList(Member loginMember) {
		return noticeDAO.selectNoticeList(loginMember);
	}

	@Override
	public int insertNoticeList(List<Notice> groupNoticeList) {
		return noticeDAO.insertNoticeList(groupNoticeList);
	}
	
}
