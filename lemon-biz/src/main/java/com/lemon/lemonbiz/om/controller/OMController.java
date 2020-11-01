package com.lemon.lemonbiz.om.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lemon.lemonbiz.approval.model.service.ApprovalService;
import com.lemon.lemonbiz.common.Utils;
import com.lemon.lemonbiz.common.vo.Attachment;
import com.lemon.lemonbiz.common.vo.Paging;
import com.lemon.lemonbiz.member.model.service.MemberService;
import com.lemon.lemonbiz.member.model.vo.Dept;
import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.om.model.service.OMService;
import com.lemon.lemonbiz.om.model.vo.OM;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/om")
@Slf4j
public class OMController {
	@Autowired
	private OMService omService;

	@Autowired
	private ResourceLoader resourceLoader;

	@Autowired
	private ApprovalService approvalService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private JavaMailSender mailSender;

/// DQL ///
	// 여기서부터 DQL - List 처리
	// 사내 메일 리스트 조회 분기처리
	@RequestMapping(value = { "/omList.do", "/omAttachedList.do", "/omMyList.do", "/omSelfList.do", "/omTeamList.do",
			"/omMyListIn.do", "/omMyListEx.do" })
	public ModelAndView omLists(ModelAndView mav, HttpServletRequest request,
			@SessionAttribute("loginMember") Member loginMember) {

		int numPerPage = 10;
		int cPage = 1;
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		} catch (NumberFormatException e) {
		}
		String url = request.getRequestURI();
		int totalContents = 0;

		Map<String, Object> map = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		String myId = loginMember.getMemberId();

		log.debug("servletPath = {}", request.getServletPath());

		// request.getServletPath()를 사용한 분기 처리 시에는 반드시 상단에 매핑한 상위 주소를 포함한 값과 대조하여야 한다.
		// 일반 메일 리스트
		if (request.getServletPath().equals("/om/omList.do")) {
			list = omService.selectOMMapList(cPage, numPerPage, map, myId);
			totalContents = omService.countAll(myId);
			mav.setViewName("om/omList");
			
		} else if (request.getServletPath().equals("/om/omTeamList.do")) {
			list = omService.selectTeamOMMapList(cPage, numPerPage, map, loginMember);
			totalContents = omService.countTeam(myId);
			mav.setViewName("om/omTeamList");
			
		} else if (request.getServletPath().equals("/om/omAttachedList.do")) {
			list = omService.selectOMMapList(cPage, numPerPage, map, myId);
			totalContents = omService.countAtt(myId);
			mav.setViewName("om/omAttachedList");
			
			// 사용자 메일 리스트
		} else if (request.getServletPath().equals("/om/omSelfList.do")) {
			list = omService.selectSelfOMMapList(cPage, numPerPage, map, myId);
			totalContents = omService.countSelf(myId);
			mav.setViewName("om/omSelfList");
			
		} else if (request.getServletPath().equals("/om/omMyList.do")) {
			list = omService.selectMyOMMapList(cPage, numPerPage, map, myId);
			totalContents = omService.countMy(myId);
			mav.setViewName("om/omMyList");
			
		} else if (request.getServletPath().equals("/om/omMyListEx.do")) {
			list = omService.selectMyOMMapListEX(cPage, numPerPage, map, myId);
			totalContents = omService.countMyEx(myId);
			mav.setViewName("om/omMyListEx");
			
		} else if (request.getServletPath().equals("/om/omMyListIn.do")) {
			list = omService.selectMyOMMapListIN(cPage, numPerPage, map, myId);
			totalContents = omService.countMyIn(myId);
			mav.setViewName("om/omMyListIn");
		}
		
		String pageBar = Paging.getPageBarHtml(cPage, numPerPage, totalContents, url);
		mav.addObject("list", list);
		mav.addObject("pagebar", pageBar);

		return mav;
	}
	// 여기까지 DQL - List 처리

	// 여기서부터 DQL - Detail 처리
	// 각 사내 메일 상세 조회
	@RequestMapping("/omDetail.do")
	public ModelAndView omDeatil(@RequestParam("key") int key, ModelAndView mav, HttpServletRequest request,
			HttpServletResponse response, @SessionAttribute("loginMember") Member loginMember) {

		Cookie[] cookies = request.getCookies();
		String omCookieVal = "";
		boolean hasRead = false;

		if (cookies != null) {
			for (Cookie c : cookies) {
				String name = c.getName();
				String value = c.getValue();

				if ("omCookie".equals(name)) {
					omCookieVal = value;

					if (value.contains("[" + key + "]")) {
						hasRead = true;
						break;
					}
				}
			}
		}
		if (hasRead == false) {
			Cookie omCookie = new Cookie("omCookie", omCookieVal + "[" + key + "]");
			omCookie.setMaxAge(365 * 24 * 60 * 60);
			omCookie.setPath(request.getContextPath() + "/om/");
			response.addCookie(omCookie);
		}
		OM om = omService.selectOneOMCollection(key, hasRead);
		Member sender = memberService.selectOneMember(om.getMemId());
		mav.addObject("sender", sender);
		mav.addObject("om", om);
		mav.setViewName("om/omDetail");

		return mav;
	}
	// 여기까지 DQL - Detail 처리
/// DQL 끝 ///

/// DML 시작 ///
	// 여기서부터 사내 & 외부 메일 작성
	@RequestMapping(value = "/omEnroll.do", method = RequestMethod.POST)
	public String omEnroll(OM om, @RequestParam("name") String name,
			@RequestParam(value = "upFile", required = false) MultipartFile[] upFilesN,
			@RequestParam(value = "upFile", required = false) MultipartFile[] upFilesEI,
			@RequestParam(value = "upFile", required = false) MultipartFile[] upFilesE, RedirectAttributes redirectAttr,
			HttpServletRequest request, Model model, @SessionAttribute("loginMember") Member loginMember,

			@RequestParam(value = "goE", required = false) String goE,
			@RequestParam(value = "goEI", required = false) String goEI,
			@RequestParam(value = "goS", required = false) String goS,
			@RequestParam(value = "sender", required = false) String sender,

			@RequestParam(value = "omrId1", required = true) String omrId1,
			@RequestParam(value = "omrId2", required = false) String omrId2,
			@RequestParam(value = "omrId3", required = false) String omrId3,
			@RequestParam(value = "omrId4", required = false) String omrId4,
			@RequestParam(value = "omrId5", required = false) String omrId5,
			@RequestParam(value = "omrId6", required = false) String omrId6,
			@RequestParam(value = "omrId7", required = false) String omrId7,
			@RequestParam(value = "omrId8", required = false) String omrId8,
			@RequestParam(value = "omrId9", required = false) String omrId9,
			@RequestParam(value = "omrId10", required = false) String omrId10)
			throws IllegalStateException, IOException {

		// 내부 수신자 추가 (최대 10명)
		List<String> omrs = new ArrayList<>();

		omrs.add(omrId1);
		omrs.add(omrId2);
		omrs.add(omrId3);
		omrs.add(omrId4);
		omrs.add(omrId5);
		omrs.add(omrId6);
		omrs.add(omrId7);
		omrs.add(omrId8);
		omrs.add(omrId9);
		omrs.add(omrId10);

		// 여기서부터 insert 및 발송 처리
		int result = 0;
		int resultReturn = 0;
		int i = 0;

		// 여기서부터 발송
			// 수신인의 수 만큼 발송 및 DB 저장 메소드 반복
			for (i = 0; i < omrs.size(); i++) {
				if (omrs.get(i).length() > 0) {

					// 여기서부터 외부로도 발송 (goEI : 선택된 사원들의 이메일 주소로도 외부 발송하는 체크박스 체크한 경우)
					if (goEI != null) {

						Member mem = memberService.selectOneMember(omrs.get(i));

						String mFrom = "lemonbiz.manager@gmail.com";
						String sendTo = mem.getEmail();
						String title = request.getParameter("title");
						String content = request.getParameter("content");

						try {
							MimeMessage message = mailSender.createMimeMessage();
							MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

							messageHelper.setFrom(mFrom);
							messageHelper.setTo(sendTo);
							messageHelper.setSubject(title);
							messageHelper.setText(content, true);

							String saveDirectory = request.getServletContext()
									.getRealPath("/resources/upload/om/ex-internal");

							for (MultipartFile upFileG : upFilesEI) {
								if (upFileG.isEmpty())
									continue;
								String renamedFilename = Utils.getRenamedFileNameEI(upFileG.getOriginalFilename());
								File destG = new File(saveDirectory, renamedFilename);
								upFileG.transferTo(destG);
								messageHelper.addAttachment(renamedFilename, destG);
							}
							// 외부로 발송하면서 동시에 발송인이 해당 메일을 중요 메일로 설정하는 경우
							if (goS != null) {
								om.setIsStarred(1);
								// 외부 발송하나 중요메일료 설정하지 않는 경우
							} else {
							}
							// 최종 외부 발송 처리 및 발송건수 수집
							omService.insertOME(om, omrs.get(i));
							mailSender.send(message);
							result++;
						} catch (Exception e) {
							e.printStackTrace();
						}
						// 여기까지 외부로도 발송

						// 사내 메일 공통 분기
					} else {
						for (MultipartFile upFile : upFilesN) {

							List<Attachment> attachList = new ArrayList<>();
							String saveDirectory = request.getServletContext()
									.getRealPath("/resources/upload/om/internal");

							if (upFile.isEmpty())
								continue;
							String renamedFilename = Utils.getRenamedFileNameN(upFile.getOriginalFilename());
							File destI = new File(saveDirectory, renamedFilename);
							upFile.transferTo(destI);

							Attachment attach = new Attachment();
							attach.setOriginName(upFile.getOriginalFilename());
							attach.setReName(renamedFilename);
							attachList.add(attach);

							log.debug("attachList = {}", attachList);
							om.setAttachList(attachList);
							om.setName(name);

							// 사내 메일로만 발송하며 동시에 중요 메일로 설정한 경우
						}
						if (goS != null) {
							om.setIsStarred(1);
						}
						// 사내 메일로만 발송하며 중요 메일로 설정하지 않은 경우
						omService.insertOM(om, omrs.get(i));
						log.debug("omrs = {}", omrs.get(i));
						result++;
						log.debug("result = {}", result);
						// 여기까지 사내메일로만 발송
					}
				}

			}
			// 외부 메일 발송 절차
			if (goE != null) {
				String[] omres = goE.split(",");
				for (int n = 0; n < omres.length; n++) {

					String mFrom = "lemonbiz.manager@gmail.com";
					String sendTo = omres[n];
					String title = request.getParameter("title");
					String content = request.getParameter("content");

					try {
						MimeMessage message = mailSender.createMimeMessage();
						MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

						messageHelper.setFrom(mFrom);
						messageHelper.setTo(sendTo);
						messageHelper.setSubject(title);
						messageHelper.setText(content, true);

						List<Attachment> attachList = new ArrayList<>();
						String saveDirectory = request.getServletContext().getRealPath("/resources/upload/om/external");

						for (MultipartFile upFileG : upFilesE) {
							if (upFileG.isEmpty())
								continue;
							String renamedFilename = Utils.getRenamedFileNameE(upFileG.getOriginalFilename());
							File destK = new File(saveDirectory, renamedFilename);
							upFileG.transferTo(destK);
							messageHelper.addAttachment(renamedFilename, destK);
							
							Attachment attach = new Attachment();
							attach.setOriginName(upFileG.getOriginalFilename());
							attach.setReName(renamedFilename);
							attachList.add(attach);

							log.debug("attachList = {}", attachList);
							om.setAttachList(attachList);
							om.setName(name);
						}
						// 외부로 발송하면서 동시에 발송인이 해당 메일을 중요 메일로 설정하는 경우
						if (goS != null) {
							om.setIsStarred(1);
							// 외부 발송하나 중요메일료 설정하지 않는 경우
						} else {
						}
						// 최종 외부 발송 처리 및 발송건수 수집
						omService.insertOME(om, loginMember.getMemberId());
						mailSender.send(message);
						result++;
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
			if (result > 0) {
				redirectAttr.addFlashAttribute("msg", " 총 " + result + "건의 메일이 성공적으로 전송되었습니다.");
			} else {
				redirectAttr.addFlashAttribute("msg", "메일 전송에 실패하였습니다.");
			}
		return "redirect:/om/omList.do";
	}
	// 여기까지 사내 & 외부 메일 작성

	
	@RequestMapping(value = "/omReturn.do")
	public ModelAndView omReturn(@RequestParam("key") int key, ModelAndView mav, HttpServletRequest request,
			HttpServletResponse response) {
		OM origin = omService.selectOneOM(key);
		Member sender = memberService.selectOneMember(origin.getMemId());
		mav.addObject("origin", origin);
		mav.addObject("sender", sender);
		mav.setViewName("om/omReturn");
		return mav;
	}
	
	// 여기서부터 회신
	@RequestMapping(value = "/omReSend.do", method = RequestMethod.POST)
	public String omReturn(OM om, @RequestParam("name") String name, 
			@RequestParam(value = "upFile", required = false) MultipartFile[] upFilesN,
			@RequestParam(value = "upFile", required = false) MultipartFile[] upFilesEI,
			@RequestParam(value = "upFile", required = false) MultipartFile[] upFilesE, RedirectAttributes redirectAttr,
			HttpServletRequest request, Model model, @SessionAttribute("loginMember") Member loginMember,

			@RequestParam(value = "goE", required = false) String goE,
			@RequestParam(value = "goEI", required = false) String goEI,
			@RequestParam(value = "goS", required = false) String goS,
			@RequestParam(value = "sender", required = true) String sender)
			throws IllegalStateException, IOException {

		// 여기서부터 insert 및 발송 처리
		int resultReturn = 0;

		// 여기서부터 발송

					// 여기서부터 외부로도 발송 (goEI : 선택된 사원들의 이메일 주소로도 외부 발송하는 체크박스 체크한 경우)
					if (goEI != null) {
						Member sendee = memberService.selectOneMember(sender);
						String mFrom = "lemonbiz.manager@gmail.com";
						String sendTo = sendee.getEmail();
						String title = request.getParameter("title");
						String content = request.getParameter("content");

						try {
							MimeMessage message = mailSender.createMimeMessage();
							MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

							messageHelper.setFrom(mFrom);
							messageHelper.setTo(sendTo);
							messageHelper.setSubject(title);
							messageHelper.setText(content, true);

							String saveDirectory = request.getServletContext()
									.getRealPath("/resources/upload/om/ex-internal");

							for (MultipartFile upFileG : upFilesEI) {
								if (upFileG.isEmpty())
									continue;
								String renamedFilename = Utils.getRenamedFileNameEI(upFileG.getOriginalFilename());
								File destG = new File(saveDirectory, renamedFilename);
								upFileG.transferTo(destG);
								messageHelper.addAttachment(renamedFilename, destG);
							}
							// 외부로 발송하면서 동시에 발송인이 해당 메일을 중요 메일로 설정하는 경우
							if (goS != null) {
								om.setIsStarred(1);
								// 외부 발송하나 중요메일료 설정하지 않는 경우
							} else {
							}
							// 최종 외부 발송 처리 및 발송건수 수집
							omService.insertOME(om, sender);
							mailSender.send(message);
							resultReturn = 1;
						} catch (Exception e) {
							e.printStackTrace();
						}
						// 여기까지 외부로도 발송

						// 사내 메일 공통 분기
					} else {
						for (MultipartFile upFile : upFilesN) {

							List<Attachment> attachList = new ArrayList<>();
							String saveDirectory = request.getServletContext()
									.getRealPath("/resources/upload/om/internal");

							if (upFile.isEmpty())
								continue;
							String renamedFilename = Utils.getRenamedFileNameN(upFile.getOriginalFilename());
							File destI = new File(saveDirectory, renamedFilename);
							upFile.transferTo(destI);

							Attachment attach = new Attachment();
							attach.setOriginName(upFile.getOriginalFilename());
							attach.setReName(renamedFilename);
							attachList.add(attach);

							log.debug("attachList = {}", attachList);
							om.setAttachList(attachList);
							om.setName(name);

							// 사내 메일로만 발송하며 동시에 중요 메일로 설정한 경우
						}
						if (goS != null) {
							om.setIsStarred(1);
						}
						// 사내 메일로만 발송하며 중요 메일로 설정하지 않은 경우
						omService.insertOM(om, sender);
						resultReturn = 1;
						// 여기까지 사내메일로만 발송
					}
		if (resultReturn > 0) {
			redirectAttr.addFlashAttribute("msg", "성공적으로 회신하였습니다.");
		} else
			redirectAttr.addFlashAttribute("msg", "회신에 실패하였습니다.");
		return "redirect:/om/omList.do";
	}
	
// 여기서부터 수신인 추가 & jstree
	// 여기서부터 전사 부서 리스트 jstree로 노출
	@RequestMapping(value = "/omForm.do")
	public String writeForm(Model model) {

		List<Dept> dept = approvalService.deptList();
		List<Dept> child = approvalService.child();
		List<Dept> child2 = approvalService.child2();

		log.debug("dept = {}", dept);
		log.debug("child = {}", child);
		log.debug("child2 = {}", child2);

		model.addAttribute("dept", dept);
		model.addAttribute("child", child);
		model.addAttribute("child2", child2);

		return "om/omForm";
	}
	// 여기까지 전사 부서 리스트 jstree로 노출

	// 여기서부터 전사 사원 리스트 노출
	@RequestMapping(value = "/omReceivers.do")
	public String approvalSelect(@RequestParam("node") String node, Model model) {

		List<Member> memberList = approvalService.memberList(node);

		log.debug("node = {}", node);
		log.debug("memberList={}", memberList);

		model.addAttribute("memberList", memberList);

		return "jsonView";
	}
	// 여기까지 전사 사원 리스트 노출

	// 여기서부터 선택된 수신인 데이터 가져오기
	@RequestMapping(value = "/selectMember.do", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	@ResponseBody
	public Map<String, Object> selectMember(@RequestParam("param") String param, Model model) {
		log.debug("11");
		log.debug("param = {}", param);
		Map<String, Object> map = new HashMap<>();

		List<Member> selectMember = approvalService.selectMember(param);

		map.put("selectMember", selectMember);

		return map;
	}
	// 여기까지 선택된 수신인 데이터 가져오기

	// 여기서부터 사원명 검색
	@RequestMapping(value = "/searchName.do", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	@ResponseBody
	public Map<String, Object> joinMemberList(@RequestParam("param") String param) {

		log.debug("param ={}", param);
		Map<String, Object> map = new HashMap<>();
		List<Member> joinMemberList = approvalService.joinMemberlist(param);

		log.debug("joinMemberList = {}", joinMemberList);
		map.put("joinMemberList", joinMemberList);

		return map;
	}
	// 여기서부터 사원명 검색
	// 여기까지 수신인 추가 & jstree

	// 여기서부터 첨부파일 클릭시 다운로드 기능
	@RequestMapping(value = "/fileDownload.do")
	@ResponseBody
	public Resource fileDownload(@RequestParam("key") int key, @RequestHeader("user-agent") String userAgent,
			HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {

		Attachment attach = omService.selectOneAttachment(key);

		String saveDirectory = request.getServletContext().getRealPath("/resources/upload/om");
		File downFile = new File(saveDirectory, attach.getReName());
		Resource resource = resourceLoader.getResource("file:" + downFile);
		log.debug("resource = {}", resource);

		boolean isMSIE = userAgent.indexOf("MSIE") != -1 || userAgent.indexOf("Trident") != -1;
		String originalFilename = attach.getOriginName();
		if (isMSIE) {
			originalFilename = URLEncoder.encode(originalFilename, "UTF-8")// %EC%B7%A8+%EC%97%85+%ED%8A%B9+%EA%B0%95.txt
					.replaceAll("\\+", "%20");
		} else {
			originalFilename = new String(originalFilename.getBytes("UTF-8"), "ISO-8859-1");
		}

		response.setContentType("application/octet-stream; charset=utf-8");
		response.addHeader("Content-Disposition", "attachment; filename=\"" + originalFilename + "\"");

		return resource;
	}
	// 여기까지 첨부파일 클릭시 다운로드 기능

	// 여기서부터 메일 삭제 기능
	@RequestMapping("/omfrmDelete.do")
	public String omfrmDelete(@RequestParam("key") int key, Attachment attachment, HttpServletRequest request,
			RedirectAttributes redirectAttr) {

		String renamedFileName = attachment.getReName();
		omService.omFileDelete(key);
		omService.omfrmDelete(key);

		if (renamedFileName != null) {
			String saveDirectory = request.getServletContext().getRealPath("/resources/upload/om");
			File delFile = new File(saveDirectory, renamedFileName);
			delFile.delete();
		}
		return "redirect:/om/omList.do";
		// 여기까지 메일 삭제 기능
	}
	

/// DML 끝 ///
	
	@RequestMapping("/getCountNoReadMail")
	public ResponseEntity<?> getTodayCount(@RequestParam HashMap<Object,Object> params) {
		
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		System.out.println("params = " + params);
		
		int num = omService.getCountNoReadMail(params);
		
		System.out.println("num = " + num);

		return new ResponseEntity<>(num,HttpStatus.OK);		
	}

}