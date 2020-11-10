package com.lemon.lemonbiz.approval.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import org.springframework.web.servlet.ModelAndView;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.lemon.lemonbiz.approval.model.service.ApprovalService;
import com.lemon.lemonbiz.approval.model.vo.Appr;
import com.lemon.lemonbiz.approval.model.vo.ApprCheck;
import com.lemon.lemonbiz.approval.model.vo.DocType;
import com.lemon.lemonbiz.common.Utils;
import com.lemon.lemonbiz.common.vo.Attachment;
import com.lemon.lemonbiz.common.vo.PagingInfo;
import com.lemon.lemonbiz.manager.model.service.ManagerService;
import com.lemon.lemonbiz.member.model.vo.Dept;
import com.lemon.lemonbiz.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("/approval")
@SessionAttributes({"loginMember"})
public class ApprovalController {
	
	@Autowired
	private ManagerService managerService;
	
	@Autowired
	private ApprovalService approvalService;
	
	@Autowired
	private ResourceLoader resourceLoader;
	
	
	
	
	//===================================================writeFrom(전자결재문서 작성페이지)===============================================
	
	// 결재문서작성 시 필요한 요소들 model객체에 저장(Tree에 사용될 부서정보(dept -> child -> child2), 문서종류) 
	@RequestMapping(value="/writeForm.do")
	public String writeForm(Model model,
							@RequestParam(value="approval_id" , required=false) String key) {
		
		if(key!=null) {
		Appr appr = approvalService.reWriteAppr(key);

		List<ApprCheck> apprchList = approvalService.reWriteApprck(key);
		try {
		Attachment attach = approvalService.reWriteAttach(key);
		model.addAttribute("attach",attach);
		} catch(Exception e) {
		}

		
		ApprCheck apprck1 = new ApprCheck();
		ApprCheck apprck2 = new ApprCheck();
		ApprCheck apprck3 = new ApprCheck();
	
		apprck1 = apprchList.get(0);
		apprck2 = apprchList.get(1);
		apprck3 = apprchList.get(2);
		
		
		model.addAttribute("appr",appr);
		model.addAttribute("apprck1",apprck1);
		model.addAttribute("apprck2",apprck2);
		model.addAttribute("apprck3",apprck3);
		
		}
		
		
		
		//트리에 부서정보 나열하기 위해 상위부서를 기준으로 model객체에 저장
		List<Dept> dept = approvalService.deptList();
		List<Dept> child = approvalService.child();
		List<Dept> child2 = approvalService.child2();
		log.debug("dept = {}",dept);
		log.debug("child = {}",child);
		log.debug("child2 = {}",child2);
		
		model.addAttribute("dept",dept);
		model.addAttribute("child",child);
		model.addAttribute("child2",child2);
		
		//문서종류 리스트로 model에 저장
		List<DocType> docTypeList = approvalService.selectDocTypeTitleList();
		model.addAttribute("docTypeList", docTypeList);
		
		
		return "approval/writeForm";
		
	}
	
	
	//---------------결제라인추가
	//결제라인추가-부서선택시 해당부서직원List 출력
	@RequestMapping(value="/deptSelect.do")
	public String approvalSelect(@RequestParam("node") String node,
								 Model model) {
		
		List<Member> memberList = approvalService.memberList(node);

		log.debug("node = {}",node);
		log.debug("memberList={}",memberList);
		
		model.addAttribute("memberList",memberList);
		
		
		return "jsonView";
	}
	//결제라인추가-직원선택시 결제자순번영역으로 이동
	@RequestMapping(value="/selectMember.do",
					method=RequestMethod.POST,
					produces = "application/json; charset=utf8")
	@ResponseBody
	public Map<String, Object> selectMember(@RequestParam("param") String param,
							   Model model) {
		log.debug("11");
		log.debug("param = {}",param);
		Map<String, Object> map = new HashMap<>();
		
		List<Member> selectMember = approvalService.selectMember(param);
		
		map.put("selectMember",selectMember);
		
		return map;
	}
	
	// ajax결제자선택 -> 이름 검색 | json으로 검색한 이름에 대한 결제자정보 map에 담아 넘김
	@RequestMapping(value="/searchName.do",
			method=RequestMethod.POST,
			produces="application/json; charset=utf8")
	@ResponseBody
	public Map<String, Object> joinMemberList(@RequestParam("param") String param) {
	
		log.debug("param ={}", param);
		Map<String, Object> map = new HashMap<>();
		List<Member> joinMemberList = approvalService.joinMemberlist(param);
		
		map.put("joinMemberList", joinMemberList);
	
		return map;
	}
	//---------------결제라인추가 end
	
	//결제문서양식 불러오기
	@RequestMapping(value="selectOneDocTypeAjax.do", method=RequestMethod.GET)
	public void selectOneDocTypeAjax(DocType docType, HttpServletResponse response) {
		
		DocType oneDocType = approvalService.selectOneDocTypeAjax(docType);
		

		response.setContentType("application/json; charset=utf-8");

		Gson gson = new Gson();
		try {
			gson.toJson(oneDocType, response.getWriter());
		} catch (JsonIOException | IOException e) {
			e.printStackTrace();
		}
	}
	
	//--------임시저장
	@RequestMapping(value="applovalSave.do", method=RequestMethod.POST)
	public String updateApproval(HttpServletRequest req,
								Model model,
								Appr appr,
								@RequestParam (value="updatdAuthId1", required=true) String authId1,
								@RequestParam (value="updatdAuthId2", required=true) String authId2,
								@RequestParam (value="updatdAuthId3", required=true) String authId3
								)
								throws IOException, Exception, IllegalStateException {
		
		
		HttpSession session = req.getSession();

		
		//======================================공통 속성들====================================
		
		//사원번호 : 전자결재에 대한 사원번호 받기
		String memId = ((Member)session.getAttribute("loginMember")).getMemberId();
		appr.setMemId(memId);
		
		//상태 : 전자결재에 대한 상태받기(status) --> 임시저장이므로 t
		ApprCheck apprck1 = new ApprCheck();
		ApprCheck apprck2 = new ApprCheck();
		ApprCheck apprck3 = new ApprCheck();
		
		//apprCheck 객체 생성
		//1번 결재자
		apprck1.setSeqNum(1);
		apprck1.setMemId(authId1);
		
		//2번결재자
		apprck2.setSeqNum(2);
		apprck2.setMemId(authId2);
		
		//3번결재자
		apprck3.setSeqNum(3);
		apprck3.setMemId(authId3);
		
		//======================================공통 속성들 end====================================
		
		//문서번호 : 처음 제출 시 문서번호 받기위한 시퀸스 생성 후 insert, key(seq)생성 필수(행이 존재하지 않기때문에 새로 만들어야함)
		//approvalKey(임시저장에서 넘어온 key값, key값이 존재하면 행이 존재한다는것임) 
		
		if(appr.getKey().equals("")) {
			
			String seqApprKey = approvalService.SeqApprKey();
			appr.setKey(seqApprKey);
			apprck1.setApprovalKey(appr.getKey());
			apprck2.setApprovalKey(appr.getKey());
			apprck3.setApprovalKey(appr.getKey());
			
			//이미 행이 있을 경우 appr_check 에 대한 key값 이 이미 있기때문에 분기에서 없으면 설정해주지 않고 appr에 바로 set함 
			appr.setApprck1(apprck1);
			appr.setApprck2(apprck2);
			appr.setApprck3(apprck3);
			
			//appr(전자결재), apprch(전자결재승인) attachment(파일) 객체 db에 저장
			int result = approvalService.insertApproval(appr);
			
		}else {
			//임시저장 후 제출의 경우 문서번호가 이미 존재하기 때문에 update
			//appr_check 도 행이 이미 존재하기 때문에 jsp에서 apprCheck.key값을 받아와서 update처리.
			
			List<ApprCheck> apprchList = approvalService.reWriteApprck(appr.getKey()); 
						
			apprck1.setKey(apprchList.get(0).getKey());
			apprck2.setKey(apprchList.get(1).getKey());
			apprck3.setKey(apprchList.get(2).getKey());
			
			appr.setApprck1(apprck1);
			appr.setApprck2(apprck2);
			appr.setApprck3(apprck3);
			
			// appr(전자결재), apprch(전자결재승인) attachment(파일) 객체 db에 저장
			int result = approvalService.updateApproval(appr);
			log.debug("result={}",result);
		}
		
		model.addAttribute("appr",appr);
		
		model.addAttribute("apprck1",apprck1);
		model.addAttribute("apprck2",apprck2);
		model.addAttribute("apprck3",apprck3);
		
		return "redirect:/approval/myApvList?page=1";
	}
	
	//----------------임시저장함
	@RequestMapping(value="/myApvList")
	public String myApvList(HttpServletRequest req, 
							Model model,
							@ModelAttribute("loginMember") Member loginMember,
							@RequestParam(value="page") int page) { 
		
		List<Appr> apprList = new ArrayList<>();
		try {
			apprList = approvalService.ApprovalList(loginMember.getMemberId());
			
			model.addAttribute("apvList",apprList);
			model.addAttribute("pageInfo",paging(page,apprList));
			model.addAttribute("toSearch", "approval/myApvList");
		} catch(Exception e) {
			
		}
		
		return "approval/myApvList";
	}
	
	//----------------제출하기(요청보내기)
	@RequestMapping(value="updateApproval.do", method=RequestMethod.POST)
	public String approvalWrite(HttpServletRequest req,
								Model model,
								Appr appr,
								@RequestParam (value="approval_mem1", required=true) String authId1,
								@RequestParam (value="approval_mem2", required=true) String authId2,
								@RequestParam (value="approval_mem3", required=true) String authId3,
								@RequestParam (value="upFile", required=false) MultipartFile upFile
								)
								throws IOException, Exception, IllegalStateException {
		
		HttpSession session = req.getSession();
		
		ApprCheck apprck1 = new ApprCheck();
		ApprCheck apprck2 = new ApprCheck();
		ApprCheck apprck3 = new ApprCheck();
		
		//사원번호 : 전자결재에 대한 사원번호 받기 
		String memId = ((Member)session.getAttribute("loginMember")).getMemberId();
		appr.setMemId(memId);
		
		//-----------------------전자결재에 대한 속성저장
		//1번 결재자
		apprck1.setSeqNum(1);
		apprck1.setMemId(authId1);
		//2번결재자
		apprck2.setSeqNum(2);
		apprck2.setMemId(authId2);
		//3번결재자
		apprck3.setSeqNum(3);
		apprck3.setMemId(authId3);
		
		//9. attachment객체 생성
		Attachment attach = new Attachment();
		//파일이 있는지 없는지 확인후 객체에 속성값 저장
		
		if(!upFile.isEmpty()) {
			
			//8-1.파일 : 저장할 파일이 존재할 경우 attachment에 속성저장하기 (upfile)
			// 서버컴퓨터에 업로드한 파일 저장 확인
			log.debug("upFile.name={}", upFile.getOriginalFilename());
			log.debug("upFile.size={}", upFile.getSize());
			
			//1. 서버컴퓨터에 저장
			
			//저장경로
			String saveDirectory = req.getServletContext().getRealPath("/resources/upload/approval");
			//파일을 선택하지 않고 전송한 경우
			log.debug("upFile={}", upFile.getOriginalFilename());
				
			//1. 파일명(renameFilename)생성
			String renamedFilename = Utils.getRenamedFileName(upFile.getOriginalFilename());
			//2. 메모리의 파일 -> 서버컴퓨터 디렉토리 저장 tranferTo
			File dest = new File(saveDirectory, renamedFilename);
			upFile.transferTo(dest);
			//3. attachment객체 생성
			
			attach.setOriginName(upFile.getOriginalFilename());
			attach.setReName(renamedFilename);
			
			attach.setMemId(appr.getMemId());
		}
		
		//2. appr(전자결재), apprch(전자결재승인) 객체 db에 저장
		if(appr.getKey().equals("")) {
			
			String seqApprKey = approvalService.SeqApprKey();
			appr.setKey(seqApprKey);
			apprck1.setApprovalKey(appr.getKey());
			apprck2.setApprovalKey(appr.getKey());
			apprck3.setApprovalKey(appr.getKey());
			attach.setApprovalkey(appr.getKey());
			appr.setAttachment(attach);
			
			//이미 행이 있을 경우 appr_check 에 대한 key값 이 이미 있기때문에 분기에서 없으면 설정해주지 않고 appr에 바로 set함 
			appr.setApprck1(apprck1);
			appr.setApprck2(apprck2);
			appr.setApprck3(apprck3);
			
			//appr(전자결재), apprch(전자결재승인) attachment(파일) 객체 db에 저장
			int result = approvalService.insertApproval(appr);
			log.debug("result={}",result);
			
		}else{
			//임시저장 후 임시저장의 경우 문서번호가 이미 존재하기 때문에 update
			//appr_check 도 행이 이미 존재하기 때문에 jsp에서 apprCheck.key값을 받아와서 update처리.
			List<ApprCheck> apprchList = approvalService.reWriteApprck(appr.getKey()); 
			
			apprck1.setKey(apprchList.get(0).getKey());
			apprck2.setKey(apprchList.get(1).getKey());
			apprck3.setKey(apprchList.get(2).getKey());
			attach.setApprovalkey(appr.getKey());
			appr.setAttachment(attach);
			
			appr.setApprck1(apprck1);
			appr.setApprck2(apprck2);
			appr.setApprck3(apprck3);
			
			// appr(전자결재), apprch(전자결재승인) attachment(파일) 객체 db에 저장
			int result = approvalService.updateApproval(appr);
			log.debug("result={}",result);
		}
		
		model.addAttribute("appr",appr);
		model.addAttribute("apprck1",apprck1);
		model.addAttribute("apprck2",apprck2);
		model.addAttribute("apprck3",apprck3);
		model.addAttribute("attach",attach);
		
		return "redirect:/approval/myApprovalList?page=1";
	}
	
	
	
	//===========================================myApproval(내문서, 내문서디테일)=======================================
	//-----------내문서함(제출하기 시 이동 페이지) 
	@RequestMapping(value="/myApprovalList")
	public String myApprovalList(@ModelAttribute("loginMember") Member loginMember,
								 @RequestParam(value="page") int page,
								 
								 Model model) {
		List<Appr> apprList = new ArrayList<>();
		apprList = approvalService.myApprovalList(loginMember.getMemberId());
		
		model.addAttribute("apvList",apprList);
		model.addAttribute("pageInfo",paging(page,apprList));
		model.addAttribute("toSearch", "approval/myApprovalList");
		
		
		return "approval/myApprovalList";
	}
	
	//------------내문서 클릭시 상세페이지
	@RequestMapping(value="/myApprovalDetail", method=RequestMethod.GET)
	public String myApprovalDetail(Model model,
								   @RequestParam(value="apprKey") String key) {
		
		Appr appr = approvalService.reWriteAppr(key);
		Attachment attach = approvalService.reWriteAttach(key);
		
		List<ApprCheck> apprchList = approvalService.reWriteApprck(key);
		ApprCheck apprck1 = new ApprCheck();
		ApprCheck apprck2 = new ApprCheck();
		ApprCheck apprck3 = new ApprCheck();
		apprck1 = apprchList.get(0);
		apprck2 = apprchList.get(1);
		apprck3 = apprchList.get(2);
		
		model.addAttribute("appr",appr);
		model.addAttribute("attach",attach);
		model.addAttribute("apprck1",apprck1);
		model.addAttribute("apprck2",apprck2);
		model.addAttribute("apprck3",apprck3);
		
		return "approval/myApprovalDetail";
	}
	
	//==========================================requestApproval(결제자-결제요청문서)===========================================
	//-----------결제요청문서함
	@RequestMapping(value="/requestApprovalList")
	public String requestApprovalList(@ModelAttribute("loginMember") Member loginMember,
									  @RequestParam(value="page") int page,
									  Model model) {
		
		List<Appr> apprList = new ArrayList<>();
		apprList = approvalService.apprAndCkList(loginMember);
		
		model.addAttribute("apvList",apprList);
		model.addAttribute("pageInfo",paging(page,apprList));
		model.addAttribute("toSearch", "approval/requestApprovalList");
		
		return "approval/requestApprovalList";
	}
	
	//----------결제요청문서 디테일
	@RequestMapping(value="/reauestApprovalDetail.do")
	public String requestApprovalDetail(Model model,
								   @RequestParam(value="apprKey") String key,
								   @RequestParam(value="ckKey") int ckKey) {
			
		List<ApprCheck> apprchList = approvalService.reWriteApprck(key); //이건 항상 공통되는것같은데...?
		try {
		Attachment attach = approvalService.reWriteAttach(key);
		model.addAttribute("attach",attach);
		}catch(Exception e) {
		}
		Appr appr = approvalService.apprckDetail(ckKey);
		
		ApprCheck apprck1 = new ApprCheck();
		ApprCheck apprck2 = new ApprCheck();
		ApprCheck apprck3 = new ApprCheck();
		apprck1 = apprchList.get(0);
		apprck2 = apprchList.get(1);
		apprck3 = apprchList.get(2);
		
		model.addAttribute("appr",appr);
		model.addAttribute("apprck1",apprck1);
		model.addAttribute("apprck2",apprck2);
		model.addAttribute("apprck3",apprck3);
		
		return "approval/reauestApprovalDetail";
	}
	
	//------------결제요청승인
	@RequestMapping(value="approve.do", method=RequestMethod.POST)
	public String approve(Model model,
						  Appr appr,
						  RedirectAttributes red,
						  @ModelAttribute("loginMember") Member loginMember,
						  @RequestParam("apprckKey1") int apprckKey1,
						  @RequestParam("apprckKey2") int apprckKey2,
						  @RequestParam("apprckKey3") int apprckKey3
						  ) {
		
		String apprKey = appr.getKey();
		String memberId = loginMember.getMemberId();
		Map<String, String> map = new HashMap<>();
		map.put("apprKey",apprKey);
		map.put("memberId",memberId);
		
		ApprCheck apprck = approvalService.selectcApprck(map);
		if(apprck.getSeqNum() == 1 || apprck.getSeqNum() == 2) {
			int result = approvalService.changeApprck(apprck.getKey(),appr);
		}
		else {
			//3차결제자가 승인하면 최종결제완료
			int result = approvalService.compliteApprck(apprck.getKey(),apprKey,appr);
		}
		red.addFlashAttribute("msg", "승인이 완료되었습니다.");
		return "redirect:/approval/requestApprovalList?page=1";
		
	}
	
	//-------------결제요청반려
	@RequestMapping(value="/returnApprove.do", method=RequestMethod.POST)
	public String returnApprove(@ModelAttribute("loginMember") Member loginMember,
								Model model,
								Appr appr,
								ApprCheck apprCheck,
								RedirectAttributes red) {
		
		String memberId = loginMember.getMemberId();
		Map<String, String> map = new HashMap<>();
		map.put("key",appr.getKey());
		map.put("opinion",apprCheck.getOpinion());
		map.put("memberId",memberId);
		
		int result = approvalService.returnApproval(map, appr);
		
		red.addFlashAttribute("msg", "반려되었습니다.");
		
		return "redirect:/approval/requestApprovalList?page=1";
	}
	
	//========================================returnApproval(기안자-반려된 문서)==========================================
	//-------------반려문서함
	@RequestMapping(value="/returnApprovalList")
	public String returnApprovalList(@ModelAttribute("loginMember") Member loginMember,
									 @RequestParam(value="page") int page,
									 Model model) {
		
		List<Appr> apprList = new ArrayList<>();
		apprList = approvalService.returnApprList(loginMember.getMemberId());
		
		model.addAttribute("apvList",apprList);
		model.addAttribute("pageInfo",paging(page,apprList));
		model.addAttribute("toSearch", "approval/returnApprovalList");
		
		return "approval/returnApprovalList";
	}
	
	//--------------반려문서 디테일
	@RequestMapping(value="/returnApprovalDetail.do", method=RequestMethod.GET)
	public String returnApprovalDetail(Model model,
						  @RequestParam(value="apprKey") String key) {
		
		List<ApprCheck> apprchList = approvalService.reWriteApprck(key);
		try {
		Attachment attach = approvalService.reWriteAttach(key);
		model.addAttribute("attach",attach);
		}catch(Exception e) {	
		}
		Appr appr = approvalService.returnApprovalDetail(key);
		
		ApprCheck apprck1 = new ApprCheck();
		ApprCheck apprck2 = new ApprCheck();
		ApprCheck apprck3 = new ApprCheck();
		
		apprck1 = apprchList.get(0);
		apprck2 = apprchList.get(1);
		apprck3 = apprchList.get(2);
		
		model.addAttribute("appr",appr);
		model.addAttribute("apprck1",apprck1);
		model.addAttribute("apprck2",apprck2);
		model.addAttribute("apprck3",apprck3);

		return "approval/returnApprovalDetail";
	}
	
	//========================================compliteApproval(기안자-결제완료문서)==========================================
	//--------결제완료문서함
	@RequestMapping(value="/compliteApprovalList")
	public String compliteApprovalList(@ModelAttribute("loginMember") Member loginMember,
									   @RequestParam(value="page") int page,
									   Model model) {
		
		List<Appr> apprList = new ArrayList<>();
		apprList = approvalService.compliteApprList(loginMember.getMemberId());
		
		model.addAttribute("apvList",apprList);
		model.addAttribute("auth", 0);
		model.addAttribute("pageInfo",paging(page,apprList));
		model.addAttribute("toSearch", "approval/compliteApprovalList");
		
		return "approval/compliteApprovalList";
	}
	//--------결제완료문서 디테일
	@RequestMapping(value="/compliteApprovalDetail.do")
	public String compliteApprovalDetail(Model model,
								   @RequestParam(value="apprKey") String key) {
			
		List<ApprCheck> apprchList = approvalService.reWriteApprck(key);
		try {
		Attachment attach = approvalService.reWriteAttach(key);
		model.addAttribute("attach",attach);
		}catch(Exception e) {
		}
		Appr appr = approvalService.compliteApprDetail(key);
		
		ApprCheck apprck1 = new ApprCheck();
		ApprCheck apprck2 = new ApprCheck();
		ApprCheck apprck3 = new ApprCheck();
		
		apprck1 = apprchList.get(0);
		apprck2 = apprchList.get(1);
		apprck3 = apprchList.get(2);
		
		model.addAttribute("appr",appr);
		
		model.addAttribute("apprck1",apprck1);
		model.addAttribute("apprck2",apprck2);
		model.addAttribute("apprck3",apprck3);
		
		
		return "approval/compliteApprovalDetail";
	}
	
	//==================================================그 외 기능들================================================
	//---------파일다운로드 메소드
	@RequestMapping(value="/fileDownload.do")
	@ResponseBody
	public Resource fileDownload(@RequestParam("key") String key,
								 @RequestHeader("user-agent") String userAgent,
								 HttpServletRequest request,
								 HttpServletResponse response) throws UnsupportedEncodingException {
		
		Attachment attach = approvalService.selectOneAttachment(key);
		
		String saveDirectory = request.getServletContext()	
				  .getRealPath("/resources/upload/approval");
		File downFile = new File(saveDirectory, attach.getReName());
		Resource resource = resourceLoader.getResource("file:" + downFile);
		log.debug("resource = {}", resource);
		
		boolean isMSIE = userAgent.indexOf("MSIE") != -1 
          	  || userAgent.indexOf("Trident") != -1;
		String originalFilename = attach.getOriginName();
		
		if(isMSIE){
	        //ie 구버젼을 위해 퍼센트인코딩을 명시적으로 처리. 
	    	//퍼센트인코딩(URLEncoder.encode)이후 공백을 의미하는 +를 %20로 다시 치환.
	        originalFilename = URLEncoder.encode(originalFilename, "UTF-8")//%EC%B7%A8+%EC%97%85+%ED%8A%B9+%EA%B0%95.txt
	        							 .replaceAll("\\+", "%20");
	    } 
	    else {
	        originalFilename = new String(originalFilename.getBytes("UTF-8"),"ISO-8859-1");
	    }
		
		response.setContentType("application/octet-stream; charset=utf-8");
		response.addHeader("Content-Disposition", "attachment; filename=\"" + originalFilename + "\"");//쌍따옴표 사용하지 말것.
		
		
		return resource;
	}
	
	
	//--------------------------페이징처리 메소드
	public PagingInfo paging(int page, List<Appr> appr) {
		
		int countList = 10; //페이지당 게시물 수
		int countPage = 20; //페이지 수
		int totalCount = 0;
		try {
			totalCount = appr.size(); // 총 게시물 수
		}catch(Exception e) {
			System.out.println("게시물 없음");
		}
		int totalPage = totalCount / countList; // 총 페이지 수;
		if(totalCount%countList>0) { totalPage++; }
		if(totalPage < page) { page = totalPage; }
		
		int startPage = ((page-1)  / countPage ) * countPage + 1; 
		int endPage = startPage + countPage - 1;
		if (endPage > totalPage) { endPage = totalPage; }
		
		//==========================================================
		
		int startNum = (page-1) * countList +1;
		int endNum = page * countList;
		
		//ArrayList<BoardBean> boardList = boardListService.getboardlist(startNum , endNum);
		
		PagingInfo pageInfo = new PagingInfo();
		pageInfo.setPage(page);
		pageInfo.setStartPage(startPage);
		pageInfo.setEndPage(endPage);
		pageInfo.setTotalPage(totalPage);
		pageInfo.setCountList(countList);
		if(totalCount != 0) {
			startNum--;
			endNum--;
		}
		pageInfo.setStartNum(startNum);
		pageInfo.setEndNum(endNum);
		pageInfo.setTotalCount(totalCount);
		
		return pageInfo;
		
	}
	
	//-----------------메인홈 알림기능추가
	@RequestMapping("/getCountApproval")
	public ResponseEntity<?> getTodayCount(@RequestParam HashMap<Object,Object> params) {
		
		int num = approvalService.getCountApproval(params);
		
		System.out.println("num = " + num);

		return new ResponseEntity<>(num,HttpStatus.OK);		
	}

}
