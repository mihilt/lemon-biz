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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lemon.lemonbiz.approval.model.service.ApprovalService;
import com.lemon.lemonbiz.approval.model.vo.Appr;
import com.lemon.lemonbiz.approval.model.vo.ApprCheck;
import com.lemon.lemonbiz.common.Utils;
import com.lemon.lemonbiz.common.vo.Attachment;
import com.lemon.lemonbiz.common.vo.PagingInfo;
import com.lemon.lemonbiz.member.model.vo.Dept;
import com.lemon.lemonbiz.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("/approval")
@SessionAttributes({"loginMember"})
public class ApprovalController {
	
	@Autowired
	private ApprovalService approvalService;
	
	@Autowired
	private ResourceLoader resourceLoader;
	
	
	@RequestMapping(value="/requestApprovalList")
	public String requestApprovalList(@ModelAttribute("loginMember") Member loginMember,
									  @RequestParam(value="page") int page,
									  Model model) {
		
		
		List<Appr> apprList = new ArrayList<>();
		apprList = approvalService.apprAndCkList(loginMember);
		
		model.addAttribute("apvList",apprList);
		model.addAttribute("auth", 0);
		model.addAttribute("pageInfo",paging(page,apprList));
		model.addAttribute("toSearch", "approval/requestApprovalList");
		
		return "approval/requestApprovalList";
	}
	
	
	@RequestMapping(value="/myApprovalList")
	public String myApprovalList(@ModelAttribute("loginMember") Member loginMember,
								 @RequestParam(value="page") int page,
								 
								 Model model) {
		List<Appr> apprList = new ArrayList<>();
		apprList = approvalService.myApprovalList(loginMember.getMemberId());
		
		
		
		model.addAttribute("apvList",apprList);
		model.addAttribute("auth", 0);
		model.addAttribute("pageInfo",paging(page,apprList));
		model.addAttribute("toSearch", "approval/myApprovalList");
		
		
		return "approval/myApprovalList";
	}
	
	
	@RequestMapping(value="/myApvList")
	public String myApvList(HttpServletRequest req, 
							Model model,
							@ModelAttribute("loginMember") Member loginMember,
							@RequestParam(value="page") int page) {
		
		HttpSession session = req.getSession(); 
		
		List<Appr> apprList = new ArrayList<>();
		try {
			apprList = approvalService.ApprovalList(loginMember.getMemberId());
			
			model.addAttribute("apvList",apprList);
			model.addAttribute("auth", 0);
			model.addAttribute("pageInfo",paging(page,apprList));
			model.addAttribute("toSearch", "approval/myApvList");
			
		} catch(Exception e) {
			
		}
		
		return "approval/myApvList";
	}
	
	@RequestMapping(value="/writeForm.do")
	public String writeForm(Model model) {
		

		List<Dept> dept = approvalService.deptList();
		List<Dept> child = approvalService.child();
		List<Dept> child2 = approvalService.child2();

		log.debug("dept = {}",dept);
		log.debug("child = {}",child);
		log.debug("child2 = {}",child2);
		
		model.addAttribute("dept",dept);
		model.addAttribute("child",child);
		model.addAttribute("child2",child2);

		
		
		
		return "approval/writeForm";
	}
	
	@RequestMapping(value="/approvalSelect.do")
	public String approvalSelect(@RequestParam("node") String node,
								 Model model) {
		
		List<Member> memberList = approvalService.memberList(node);

		log.debug("node = {}",node);
		log.debug("memberList={}",memberList);
		
		model.addAttribute("memberList",memberList);
		
		return "jsonView";
	}
	
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
	//updateApproval.do
	@RequestMapping(value="applovalSave.do", method=RequestMethod.POST)
	public String updateApproval(HttpServletRequest req,
								Model model,
								Appr appr,
								@RequestParam (value="updateTitle", required=true) String title,
								@RequestParam (value="updateContent", required=true) String semmernote,
								@RequestParam (value="updateStatus", required=true) String status,
								@RequestParam (value="updatdAuthId1", required=true) String authId1,
								@RequestParam (value="updatdAuthId2", required=true) String authId2,
								@RequestParam (value="updatdAuthId3", required=true) String authId3,
								@RequestParam (value="updateProcessNum1", required=true) int processNum1,
								@RequestParam (value="updateProcessNum2", required=true) int processNum2,
								@RequestParam (value="updateProcessNum3", required=true) int processNum3,
								@RequestParam (value="updateApprovalKey", required=true) String approvalKey
								)
								throws IOException, Exception, IllegalStateException {
		
		
		HttpSession session = req.getSession();
//		int updateApprckKey11 = Integer.valueOf(updateApprckKey1); 
//		int updateApprckKey22 = Integer.valueOf(updateApprckKey2); 
//		int updateApprckKey33 = Integer.valueOf(updateApprckKey3); 
		
		//======================================공통 속성들====================================
		
		//2. 문서종류
		
		//3. 사원번호 : 전자결제에 대한 사원번호 받기
		String memId = ((Member)session.getAttribute("loginMember")).getMemberId();
		appr.setMemId(memId);
		
		//4. 제목 : 전자결제에 대한 제목받기(title)
		appr.setTitle(title);
		
		//5. 내용 : 전자결제에 대한 제목받기(semmernote)
		log.debug("semmernote={}", semmernote);
		appr.setContent(semmernote);
		
		//6. 기안일자 : 전자결제에 대한 작성일자 받기(디비에서 default)
		
		//7. 상태 : 전자결제에 대한 상태받기(status)
		log.debug("status={}", status);
		appr.setStatus(status);
		
		ApprCheck apprck1 = new ApprCheck();
		ApprCheck apprck2 = new ApprCheck();
		ApprCheck apprck3 = new ApprCheck();
		
		//8. apprCheck 객체 생성
		//1번 결제자
		log.debug("authId1={}",authId1);
		log.debug("authId2={}",authId2);
		log.debug("authId3={}",authId3);
		apprck1.setSeqNum(1);
		log.debug("apprck1={}",apprck1.getSeqNum());
		apprck1.setMemId(authId1);
		apprck1.setStatus(status);
		//2번결제자
		apprck2.setSeqNum(2);
		log.debug("apprck2={}",apprck2.getSeqNum());
		apprck2.setMemId(authId2);
		apprck2.setStatus(status);
		//3번결제자
		apprck3.setSeqNum(3);
		apprck3.setMemId(authId3);
		apprck3.setStatus(status);	
		
		
		
		//======================================공통 속성들 end====================================
		
		
		
		//문서번호 : 처음 제출 시 문서번호 받기위한 시퀸스 생성 후 insert, key(seq)생성 필수(행이 존재하지 않기때문에 새로 만들어야함)
		//approvalKey(임시저장에서 넘어온 key값, key값이 존재하면 행이 존재한다는것임) 
		log.debug("approvalKey={}",approvalKey);
		if(approvalKey.equals("")) {
			
			String seqApprKey = approvalService.SeqApprKey();
			appr.setKey(seqApprKey);
			apprck1.setApprovalKey(appr.getKey());
			apprck2.setApprovalKey(appr.getKey());
			apprck3.setApprovalKey(appr.getKey());
			
			//이미 행이 있을 경우 appr_check 에 대한 key값 이 이미 있기때문에 분기에서 없으면 설정해주지 않고 appr에 바로 set함 
			appr.setApprck1(apprck1);
			appr.setApprck2(apprck2);
			appr.setApprck3(apprck3);
			
			//appr(전자결제), apprch(전자결제승인) attachment(파일) 객체 db에 저장
			int result = approvalService.insertApproval(appr);
			log.debug("result={}",result);
			
		}else {
			//임시저장 후 제출의 경우 문서번호가 이미 존재하기 때문에 update
			appr.setKey(approvalKey);
			
			log.debug("approvalKey={}",approvalKey);
			
			//appr_check 도 행이 이미 존재하기 때문에 jsp에서 apprCheck.key값을 받아와서 update처리.
			
			List<ApprCheck> apprchList = approvalService.reWriteApprck(approvalKey); 
			
			log.debug("approvalchange={}",apprchList.get(0).getKey());
			log.debug("approvalchange={}",apprchList.get(1).getKey());
			log.debug("approvalchange={}",apprchList.get(2).getKey());
			log.debug("apprchmemid={}",apprck1.getMemId());
			log.debug("apprchmemid={}",apprck2.getMemId());
			log.debug("apprchmemid={}",apprck3.getMemId());
			log.debug("apprchSeqNum={}",apprck1.getSeqNum());
			log.debug("apprchSeqNum={}",apprck2.getSeqNum());
			log.debug("apprchSeqNum={}",apprck3.getSeqNum());
			
			
			apprck1.setKey(apprchList.get(0).getKey());
			apprck2.setKey(apprchList.get(1).getKey());
			apprck3.setKey(apprchList.get(2).getKey());
			
			appr.setApprck1(apprck1);
			appr.setApprck2(apprck2);
			appr.setApprck3(apprck3);
			
			// appr(전자결제), apprch(전자결제승인) attachment(파일) 객체 db에 저장
			int result = approvalService.updateApproval(appr);
			log.debug("result={}",result);
		}
		
		
		model.addAttribute("appr",appr);
		
		model.addAttribute("apprck1",apprck1);
		model.addAttribute("apprck2",apprck2);
		model.addAttribute("apprck3",apprck3);
		
		
		return "redirect:/approval/myApvList?page=1";
	}
	
	
	/*
	 * appr appr, apprCheck apprck, docType docType,  applovalSave.do
	 */
	@RequestMapping(value="updateApproval.do", method=RequestMethod.POST)
	public String approvalWrite(HttpServletRequest req,
								Model model,
								Appr appr,
								@RequestParam (value="approval_title", required=true) String title,
								@RequestParam (value="approval_content", required=true) String semmernote,
								@RequestParam (value="status", required=true) String status,
								@RequestParam (value="approval_mem1", required=true) String authId1,
								@RequestParam (value="approval_mem2", required=true) String authId2,
								@RequestParam (value="approval_mem3", required=true) String authId3,
								@RequestParam (value="upFile", required=false) MultipartFile upFile,
								@RequestParam (value="process_num1", required=true) int processNum1,
								@RequestParam (value="process_num2", required=true) int processNum2,
								@RequestParam (value="process_num3", required=true) int processNum3,
								@RequestParam (value="updateApprovalKey", required=true) String approvalKey
								)
								throws IOException, Exception, IllegalStateException {
		
		
		
		HttpSession session = req.getSession();
		
		ApprCheck apprck1 = new ApprCheck();
		ApprCheck apprck2 = new ApprCheck();
		ApprCheck apprck3 = new ApprCheck();
		
		
		
		//-----------------------전자결제에 대한 속성저장
		
		
		//2. 문서종류번호
		
		//3. 사원번호 : 전자결제에 대한 사원번호 받기 
		String memId = ((Member)session.getAttribute("loginMember")).getMemberId();
		appr.setMemId(memId);
		
		//4. 제목 : 전자결제에 대한 제목받기(title)
		log.debug("title={}",title);
		appr.setTitle(title);
		
		//5. 내용 : 전자결제에 대한 제목받기(semmernote)
		log.debug("semmernote={}", semmernote);
		appr.setContent(semmernote);
		
		//6. 기안일자 : 전자결제에 대한 작성일자 받기(디비에서 default)
		
		//7. 상태 : 전자결제에 대한 상태받기(status)
		log.debug("status={}", status);
		appr.setStatus(status);
		
		//8. apprCheck 객체 생성
		//1번 결제자
		log.debug("authId1={}",authId1);
		log.debug("authId2={}",authId2);
		log.debug("authId3={}",authId3);
		apprck1.setSeqNum(1);
		apprck1.setMemId(authId1);
		apprck1.setStatus(status);
		//2번결제자
		apprck2.setSeqNum(2);
		apprck2.setMemId(authId2);
		apprck2.setStatus(status);
		//3번결제자
		apprck3.setSeqNum(3);
		apprck3.setMemId(authId3);
		apprck3.setStatus(status);
		
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
			
			log.debug("appr={}",appr);
		}
		
		
		//2. appr(전자결제), apprch(전자결제승인) 객체 db에 저장
		
		log.debug("approvalKey={}",approvalKey);
		log.debug("approvalKey={}",approvalKey);
		log.debug("approvalKey={}",approvalKey);
		log.debug("approvalKey={}",approvalKey);
		log.debug("approvalKey={}",approvalKey);
		log.debug("approvalKey={}",approvalKey);
		System.out.println("머지이거=["+approvalKey+"];;"); //머지이거=[];; 이렇게 나오는데 왜 else로 빠지는거야 시;발
		if(approvalKey.equals("")) {
			System.out.println("------------------------------");
			
			log.debug("approvalKey={}",approvalKey);
			log.debug("approvalKey={}",approvalKey);
			log.debug("approvalKey={}",approvalKey);
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
			
			//appr(전자결제), apprch(전자결제승인) attachment(파일) 객체 db에 저장
			int result = approvalService.insertApproval(appr);
			log.debug("result={}",result);
			
		}else{
			//임시저장 후 임시저장의 경우 문서번호가 이미 존재하기 때문에 update
			appr.setKey(approvalKey);
			
			log.debug("approvalKey={}",approvalKey);
			
			//appr_check 도 행이 이미 존재하기 때문에 jsp에서 apprCheck.key값을 받아와서 update처리.
			
			List<ApprCheck> apprchList = approvalService.reWriteApprck(approvalKey); 
			
			
			apprck1.setKey(apprchList.get(0).getKey());
			apprck2.setKey(apprchList.get(1).getKey());
			apprck3.setKey(apprchList.get(2).getKey());
			attach.setApprovalkey(appr.getKey());
			appr.setAttachment(attach);
			
			appr.setApprck1(apprck1);
			appr.setApprck2(apprck2);
			appr.setApprck3(apprck3);
			
			// appr(전자결제), apprch(전자결제승인) attachment(파일) 객체 db에 저장
			int result = approvalService.updateApproval(appr);
			log.debug("result={}",result);
		}
		
		
		//처리결과 msg 전달
		
		model.addAttribute("appr",appr);
		model.addAttribute("apprck1",apprck1);
		model.addAttribute("apprck2",apprck2);
		model.addAttribute("apprck3",apprck3);
		model.addAttribute("attach",attach);
		
		
		
		
		return "redirect:/approval/myApprovalList?page=1";
	}
	
	
	
	
	
	@RequestMapping(value="/reWrite.do", method=RequestMethod.POST)
	public String reWrite(Model model,
						  @RequestParam(value="approval_id") String key) {
		
		
		Appr appr = approvalService.reWriteAppr(key);
		List<ApprCheck> apprchList = approvalService.reWriteApprck(key);
		Attachment attach = approvalService.reWriteAttach(key);
		
		ApprCheck apprck1 = new ApprCheck();
		ApprCheck apprck2 = new ApprCheck();
		ApprCheck apprck3 = new ApprCheck();
		
		apprck1 = apprchList.get(0);
		apprck2 = apprchList.get(1);
		apprck3 = apprchList.get(2);
		log.debug("apprchList={}",apprchList);
		log.debug("apprck1={}",apprck1);
		log.debug("apprck2={}",apprck2);
		log.debug("apprck3={}",apprck3);
		log.debug("appr={}",appr);
		
		List<Dept> dept = approvalService.deptList();
		List<Dept> child = approvalService.child();
		List<Dept> child2 = approvalService.child2();

		log.debug("dept = {}",dept);
		log.debug("child = {}",child);
		log.debug("child2 = {}",child2);
		
		model.addAttribute("dept",dept);
		model.addAttribute("child",child);
		model.addAttribute("child2",child2);
		
		
		model.addAttribute("appr",appr);
		
		
		model.addAttribute("apprck1",apprck1);
		model.addAttribute("apprck2",apprck2);
		model.addAttribute("apprck3",apprck3);
		
		model.addAttribute("attach",attach);
		
		
		
		return "approval/writeForm";
	}
	
	@RequestMapping(value="/myApprovalDetail", method=RequestMethod.GET)
	public String myApprovalDetail(Model model,
								   @RequestParam(value="apprKey") String key) {
		
		
		Appr appr = approvalService.reWriteAppr(key);
		List<ApprCheck> apprchList = approvalService.reWriteApprck(key);
		Attachment attach = approvalService.reWriteAttach(key);
		
		
		
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
		
		model.addAttribute("attach",attach);
		
		
		return "approval/myApprovalDetail";
	}
	
	@RequestMapping(value="/reauestApprovalDetail.do")
	
	public String requestApprovalDetail(Model model,
								   @RequestParam(value="apprKey") String key,
								   @RequestParam(value="ckKey") int ckKey) {
			
		List<ApprCheck> apprchList = approvalService.reWriteApprck(key);
		Attachment attach = approvalService.reWriteAttach(key);
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
		
		model.addAttribute("attach",attach);
		
		
		
		return "approval/reauestApprovalDetail";
	}
	
	
	
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
	
	@RequestMapping(value="approve.do", method=RequestMethod.POST)
	public String approve(@ModelAttribute("loginMember") Member loginMember,
						  Model model,
						  Appr appr,
						  @RequestParam("apprckKey1") int apprckKey1,
						  @RequestParam("apprckKey2") int apprckKey2,
						  @RequestParam("apprckKey3") int apprckKey3,
						  RedirectAttributes red) {
		
		log.debug("appr={}",appr);
		log.debug("apprckKey1={}",apprckKey1);
		log.debug("apprckKey2={}",apprckKey2);
		log.debug("apprckKey3={}",apprckKey3);
		
		String apprKey = appr.getKey();
		String memberId = loginMember.getMemberId();
		Map<String, String> map = new HashMap<>();
		map.put("apprKey",apprKey);
		map.put("memberId",memberId);
		ApprCheck apprck = approvalService.selectcApprck(map);
		
		log.debug("apprck={}",apprck);

		if(apprck.getSeqNum() == 1 || apprck.getSeqNum() == 2) {
			int result = approvalService.changeApprck(apprck.getKey());
		}
		else {
			int result = approvalService.backApprck(apprck.getKey());
		}
		
		red.addFlashAttribute("msg", "승인이 완료되었습니다.");
		return "redirect:/approval/requestApprovalList?page=1";
		
	}
	
	
	
	
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
	
	
	
	
}
