package com.lemon.lemonbiz.mail.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lemon.lemonbiz.common.Utils;
import com.lemon.lemonbiz.common.vo.Attachment;
import com.lemon.lemonbiz.common.vo.Paging;
import com.lemon.lemonbiz.mail.model.service.MailService;
import com.lemon.lemonbiz.mail.model.vo.Mail;
import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.om.model.service.OMService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/mail")
@SessionAttributes({ "loginMember" })
@Slf4j
public class MailController {

	@ModelAttribute("myInfo")
	public Member MyInfo(Member member, HttpServletRequest request) {
		// 메일 작성 시 자동으로 기입할 작성자 정보를 먼저 호출한다.
		HttpSession session = request.getSession(); Member loginMember = (Member)
		session.getAttribute("loginMember"); Member myInfo =
		mailService.selectMyInfo(loginMember);
				 
		log.debug("myInfo = {}", myInfo); 
		return myInfo;
	}
	
	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	private MailService mailService;

	@Autowired
	private OMService omService;

	@Autowired
	private ResourceLoader resourceLoader;
	
// 여기부터 DQL
	// 각 카테고리당 페이지를 분리하지 않고 한 페이지에서 navbar를 통해 분기처리 하므로 /mailList 하나의 페이지에 모든 리스트 조회 결과를 보냄.
	@RequestMapping("/mailList.do")
	public ModelAndView omList(ModelAndView mav, HttpServletRequest request,
			@SessionAttribute("loginMember") Member loginMember) {
		
		int numPerPage = 10;
		int cPage = 1;
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		} catch (NumberFormatException e) {
		}
		int totalContents = omService.countOM();	
		String url = request.getRequestURI();
		String pageBar = Paging.getPageBarHtml(cPage, numPerPage, totalContents, url);
		
		
		Map<String, Object> map = new HashMap<String, Object>();	
		
		// 전체 메일 조회
		List<Mail> list = mailService.selectMailList();
		
		// 현재 로그인 중인 사용자와 같은 부서 소속인이 보낸 메일만 조회
		List<Mail> listDept = mailService.selectMailDept(loginMember);
		
		// 사용자가 발송한 메일 조회
		List<Mail> listMy = mailService.selectMyMail(loginMember);
				
		// 사용자가 수신한 메일 중 중요 메일로 체크한 메일 조회 
		List<Mail> listStarred = mailService.selectStarredMail(loginMember);
		
		log.debug("list = {}", list); 
		log.debug("listDept = {}", listDept);
		log.debug("listMy = {}", listMy);
		log.debug("listStarred = {}", listStarred);

		mav.addObject("list", list);
		mav.addObject("listDept", listDept);
		mav.addObject("listMy", listMy);
		mav.addObject("listStarred", listStarred);
		mav.setViewName("mail/mailList");

		return mav;
	}
// 여기까지 DQL
	
// 여기부터 DML
	
	@RequestMapping(value = "/sendMail")
	public String sendMail() {
	    return "/mail/sendMail";
	  }  
	
	@RequestMapping(value = "/mailSend")
	public String mailSend(Member member, 
			@RequestParam(value = "upFile", required = false) MultipartFile[] upFiles,
			RedirectAttributes redirectAttr, HttpServletRequest request, Mail mail,
			Model model) throws IllegalStateException, IOException {	
		
		String mFrom = request.getParameter("mFrom");
		String mTo = request.getParameter("mTo"); 
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String filename = request.getServletContext().getRealPath("resources/upload/mail/test.jpg");
		
		List<Attachment> attachList = new ArrayList<>();
		
		String saveDirectory = request.getServletContext().getRealPath("/resources/upload/board");
		
		for(MultipartFile upFile : upFiles) {
			if(upFile.isEmpty())
				continue;
			
			String renamedFilename = Utils.getRenamedFileName(upFile.getOriginalFilename());
			
			File dest = new File(saveDirectory, renamedFilename);
			upFile.transferTo(dest);
			
			Attachment attach = new Attachment();
			attach.setOriginName(upFile.getOriginalFilename());
			attach.setReName(renamedFilename);
			attachList.add(attach);
			
			mail.setAttachList(attachList);
			
			/* int result = mailService.insertMail(mail); */
			
			redirectAttr.addFlashAttribute("msg", "메일 저장 성공");
		}
		
		 try {
		      MimeMessage message = mailSender.createMimeMessage();
		      MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		 
		      messageHelper.setFrom(mFrom);  
		      messageHelper.setTo(mTo);    
		      messageHelper.setSubject(title); 
		      messageHelper.setText(content); 
		      
		      FileSystemResource fsr = new FileSystemResource(filename);
		      messageHelper.addAttachment("test.jpg", fsr);
		     
		      mailSender.send(message);
		    } catch(Exception e){
		      System.out.println(e);
		    }
		       
		 // *mail 앞에 / 빼먹지 말 것*
		 return "redirect:/mail/sendMail";
		} 
	}
		