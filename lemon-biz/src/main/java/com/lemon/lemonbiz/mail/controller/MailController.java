package com.lemon.lemonbiz.mail.controller;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MailController {
	
@Autowired
private JavaMailSender mailSender;

	@RequestMapping(value = "/mail/sendMail")
	public String sendMail() {
		   
	    return "/mail/sendMail";
	  }  
	
	@RequestMapping(value = "/mail/allMail")
	public String allMail() {
		   
	    return "/mail/allMail";
	  }  
	
	@RequestMapping(value = "/mail/mailSend")
	public String mailSend(HttpServletRequest request) {
		String mFrom = request.getParameter("mFrom");
		String mTo = request.getParameter("mTo"); 
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		 try {
		      MimeMessage message = mailSender.createMimeMessage();
		      MimeMessageHelper messageHelper 
		                        = new MimeMessageHelper(message, true, "UTF-8");
		 
		      messageHelper.setFrom(mFrom);  
		      messageHelper.setTo(mTo);    
		      messageHelper.setSubject(title); 
		      messageHelper.setText(content); 
		     
		      mailSender.send(message);
		    } catch(Exception e){
		    }
		   
		    return "redirect:/mail/sendMail";
	} 
	@RequestMapping(value = "/mail/mailAll")
	public String allMail(HttpServletRequest request) {
		String mFrom = request.getParameter("mFrom");
		String mTo = request.getParameter("mTo"); 
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		 try {
		      MimeMessage message = mailSender.createMimeMessage();
		      MimeMessageHelper messageHelper 
		                        = new MimeMessageHelper(message, true, "UTF-8");
		 
		      messageHelper.setFrom(mFrom);  
		      messageHelper.setTo(mTo);    
		      messageHelper.setSubject(title); 
		      messageHelper.setText(content); 
		     
		      mailSender.send(message);
		    } catch(Exception e){
		    }
		   
		    return "redirect:/mail/allMail";
	} 
}
