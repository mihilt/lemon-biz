package com.lemon.lemonbiz.mail.model.service;

import java.util.List;
import java.util.Map;

import com.lemon.lemonbiz.common.vo.Attachment;
import com.lemon.lemonbiz.mail.model.vo.Mail;

public interface MailService {


	List<Map<String, Object>> selectMailMapList();

	List<Mail> selectMailList();

	int insertMail(Mail mail);

	Mail selectOneMail(int key);

	Mail selectOneMailCollection(int key);

	Attachment selectOneAttachment(int key);

	List<Mail> selectMailDept(String memberId);
}
