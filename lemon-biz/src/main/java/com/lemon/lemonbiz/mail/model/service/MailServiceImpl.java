package com.lemon.lemonbiz.mail.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lemon.lemonbiz.common.vo.Attachment;
import com.lemon.lemonbiz.mail.model.dao.MailDAO;
import com.lemon.lemonbiz.mail.model.vo.Mail;

@Transactional(propagation = Propagation.REQUIRED, 
isolation = Isolation.READ_COMMITTED,
rollbackFor = Exception.class)

@Service
public class MailServiceImpl implements MailService{


	@Autowired
	private MailDAO mailDAO;

	@Override
	public List<Map<String, Object>> selectMailMapList() {
		return mailDAO.selectMailMapList();
	}

	@Override
	public List<Mail> selectMailList() {
		return mailDAO.selectMailList();
	}

	
	@Override
	public int insertMail(Mail mail) {
		int result = 0;
		result = mailDAO.insertMail(mail);
		
		if(mail.getAttachList() != null) {
			
			for(Attachment attach : mail.getAttachList()) {
				attach.setKey(mail.getKey());
				result = mailDAO.insertAttachment(attach);
			}			
		}
		return result;
	}

	@Transactional(readOnly = true)
	@Override
	public Mail selectOneMail(int key) {

		Mail mail = mailDAO.selectOneMail(key);
		

		List<Attachment> attachList = mailDAO.selectAttachList(key);
		mail.setAttachList(attachList);
		
		return mail;
	}

	@Override
	public Mail selectOneMailCollection(int key) {
		return mailDAO.selectOneMailCollection(key);
	}

	@Override
	public Attachment selectOneAttachment(int key) {
		return mailDAO.selectOneAttachment(key);
	}

	@Override
	public List<Mail> selectMailDept(String memberId) {
		return mailDAO.selectMailDept(memberId);
	}

}