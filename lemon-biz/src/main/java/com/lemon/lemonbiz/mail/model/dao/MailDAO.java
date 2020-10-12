package com.lemon.lemonbiz.mail.model.dao;

import java.util.List;
import java.util.Map;

import com.lemon.lemonbiz.common.vo.Attachment;
import com.lemon.lemonbiz.mail.model.vo.Mail;

public interface MailDAO {

	List<Map<String, Object>> selectMailMapList();

	List<Mail> selectMailList();

	int insertMail(Mail Mail);

	int insertAttachment(Attachment attach);

	Mail selectOneMail(int key);

	List<Attachment> selectAttachList(int key);

	Mail selectOneMailCollection(int key);

	Attachment selectOneAttachment(int key);
	
	List<Mail> selectMailDept(String memberId);
}
