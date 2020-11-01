package com.lemon.lemonbiz.mail.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lemon.lemonbiz.common.vo.Attachment;
import com.lemon.lemonbiz.mail.model.vo.Mail;
import com.lemon.lemonbiz.member.model.vo.Member;

@Repository
public class MailDAOImpl implements MailDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<Map<String, Object>> selectMailMapList() {
		return sqlSession.selectList("board.selectMailMapList");
	}

	@Override
	public List<Mail> selectMailList() {
		return sqlSession.selectList("mail.selectMailList");
	}

	@Override
	public int insertMail(Mail mail) {
		return sqlSession.insert("mail.insertMail", mail);
	}

	@Override
	public int insertAttachment(Attachment attach) {
		return sqlSession.insert("mail.insertAttachment", attach);
	}

	/*
	 * @Override public Mail selectOneMail(int key) { return
	 * sqlSession.selectOne("mail.selectOneMail", key); }
	 */

	@Override
	public List<Attachment> selectAttachList(int key) {
		return sqlSession.selectList("key.selectAttachList", key);
	}

	@Override
	public Mail selectOneMailCollection(int key) {
		return sqlSession.selectOne("board.selectOneKeyCollection", key);
	}

	@Override
	public Attachment selectOneAttachment(int key) {
		return sqlSession.selectOne("mail.selectOneAttachment", key);
	}

	@Override
	public List<Mail> selectMailDept(Member member) {
		return sqlSession.selectList("mail.selectMailDept", member);
	}

	@Override
	public List<Mail> selectMyMail(Member loginMember) {
		return sqlSession.selectList("mail.selectMyMail", loginMember);
	}

	@Override
	public List<Mail> selectStarredMail(Member loginMember) {
		return sqlSession.selectList("mail.selectStarredMail", loginMember);
	}

	@Override
	public Member selectMyInfo(Member loginMember) {
		return sqlSession.selectOne("mail.selectMyInfo", loginMember);
	}
}
