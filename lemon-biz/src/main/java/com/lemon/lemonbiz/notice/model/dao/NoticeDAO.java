package com.lemon.lemonbiz.notice.model.dao;

import java.util.List;

import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.notice.model.vo.Notice;

public interface NoticeDAO {

	List<Notice> selectNoticeUncheckedList(Member loginMember);

	int insertNotice(Notice notice);

	int checkNotice(Notice notice);

	List<Notice> selectNoticeList(Member loginMember);

}