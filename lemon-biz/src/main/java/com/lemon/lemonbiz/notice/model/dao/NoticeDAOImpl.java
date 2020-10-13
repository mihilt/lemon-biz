package com.lemon.lemonbiz.notice.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.notice.model.vo.Notice;

@Repository
public class NoticeDAOImpl implements NoticeDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<Notice> selectNoticeList(Member loginMember) {
		return sqlSession.selectList("notice.selectNoticeList", loginMember);
	}

	@Override
	public int insertNotice(Notice notice) {
		return sqlSession.insert("notice.insertNotice", notice);
	}

}
