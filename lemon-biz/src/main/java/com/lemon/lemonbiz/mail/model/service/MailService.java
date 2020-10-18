package com.lemon.lemonbiz.mail.model.service;

import java.util.List;
import java.util.Map;

import com.lemon.lemonbiz.common.vo.Attachment;
import com.lemon.lemonbiz.mail.model.vo.Mail;
import com.lemon.lemonbiz.member.model.vo.Member;

public interface MailService {


	List<Map<String, Object>> selectMailMapList();

	List<Mail> selectMailList();

	int insertMail(Mail mail);

	/* Mail selectOneMail(int key); */

	Mail selectOneMailCollection(int key);

	Attachment selectOneAttachment(int key);

	List<Mail> selectMailDept(Member member);

	List<Mail> selectMyMail(Member loginMember);

	List<Mail> selectStarredMail(Member loginMember);

	Member selectMyInfo(Member loginMember);
}
