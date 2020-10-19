package com.lemon.lemonbiz.approval.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.lemon.lemonbiz.approval.model.service.approvalService;
import com.lemon.lemonbiz.approval.model.vo.appr;
import com.lemon.lemonbiz.approval.model.vo.apprCheck;
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
	private approvalService approvalService;
	
	@RequestMapping("/myApvList")
	public String myApvList(HttpServletRequest req, 
							Model model,
							@ModelAttribute("loginMember") Member loginMember,
							@RequestParam(value="page") int page) {
		
		HttpSession session = req.getSession(); 
		
		List<appr> apprList = new ArrayList<>();
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
	
	@RequestMapping("/writeForm.html")
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
	/*
	 * appr appr, apprCheck apprck, docType docType,
	 */
	@RequestMapping(value="applovalSave.do", method=RequestMethod.POST)
	public String approvalWrite(HttpServletRequest req,
								appr appr,
								Model model,
								@RequestParam (value="countVacat", required=false) String countVacat,
								@RequestParam (value="approval_title", required=true) String title,
								@RequestParam (value="approval_content", required=true) String semmernote,
								@RequestParam (value="status", required=true) String status,
								@RequestParam (value="upFile", required=false) MultipartFile upFile,
								@RequestParam (value="approval_mem1", required=true) String authId1,
								@RequestParam (value="approval_mem2", required=true) String authId2,
								@RequestParam (value="approval_mem3", required=true) String authId3,
								@RequestParam (value="process_num1", required=true) int processNum1,
								@RequestParam (value="process_num2", required=true) int processNum2,
								@RequestParam (value="process_num3", required=true) int processNum3
								)
								throws IOException, Exception, IllegalStateException {
		
		
		
		System.out.println(appr.getKey());
		System.out.println(appr.getKey());
		System.out.println(appr.getKey());
		System.out.println(appr.getKey());
		System.out.println(appr.getKey());
		System.out.println(appr.getKey());
		System.out.println(appr.getKey());
		System.out.println(appr.getKey());		
		System.out.println(status);
		System.out.println(status);
		System.out.println(status);
		System.out.println(status);
		System.out.println(status);
		
		HttpSession session = req.getSession();
		
		apprCheck apprck1 = new apprCheck();
		apprCheck apprck2 = new apprCheck();
		apprCheck apprck3 = new apprCheck();
		
		log.debug("appr={}",appr);
		
		
		//-----------------------전자결제에 대한 속성저장
		
		//1. 문서번호 : 문서번호 받기위한 시퀸스 생성(String으로 받을예정)
		String seqApprKey = approvalService.SeqApprKey();
		log.debug("seqApprKey={}",seqApprKey);
		appr.setKey(seqApprKey);
		
		//2. 문서종류번호
		
		//3. 사원번호 : 전자결제에 대한 사원번호 받기 
		String memId = ((Member)session.getAttribute("loginMember")).getMemberId();
		log.debug("memberId={}",((Member)session.getAttribute("loginMember")).getMemberId());
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
		
		//8. 파일 : 파일테이블에서 끌고올거임.(upfile) 이건 일단 셋팅이 아니라 보류함.
		
		
		
		//1. 서버컴퓨터에 업로드한 파일 저장하기
		log.debug("upFile.name={}", upFile.getOriginalFilename());
		log.debug("upFile.size={}", upFile.getSize());
		
		Attachment attach = new Attachment();
		//1. 서버컴퓨터에 저장
		if(upFile != null) {
			
			//저장경로
			String saveDirectory = req.getServletContext().getRealPath("/resources/upload/approval");
			//파일을 선택하지 않고 전송한 경우
			
				
			//1. 파일명(renameFilename)생성
			String renamedFilename = Utils.getRenamedFileName(upFile.getOriginalFilename());
			//2. 메모리의 파일 -> 서버컴퓨터 디렉토리 저장 tranferTo
			File dest = new File(saveDirectory, renamedFilename);
			upFile.transferTo(dest);
			//3. attachment객체 생성
			
			attach.setOriginName(upFile.getOriginalFilename());
			attach.setReName(renamedFilename);
			attach.setApprovalkey(appr.getKey());
			attach.setMemId(appr.getMemId());
			//4. apprCheck 객체 생성
			//1번 결제자
			log.debug("authId1={}",authId1);
			log.debug("authId2={}",authId2);
			log.debug("authId3={}",authId3);
			apprck1.setSeqNum(processNum1);
			log.debug("apprck1={}",apprck1.getSeqNum());
			apprck1.setMemId(authId1);
			apprck1.setApprovalKey(appr.getKey());
			apprck1.setStatus(status);
			//2번결제자
			apprck2.setSeqNum(processNum2);
			log.debug("apprck2={}",apprck2.getSeqNum());
			apprck2.setMemId(authId2);
			apprck2.setApprovalKey(appr.getKey());
			apprck2.setStatus(status);
			//3번결제자
			apprck3.setSeqNum(processNum3);
			apprck3.setMemId(authId3);
			apprck3.setApprovalKey(appr.getKey());
			apprck3.setStatus(status);
			
			appr.setApprck1(apprck1);
			appr.setApprck2(apprck2);
			appr.setApprck3(apprck3);
			log.debug("appr.getApprck1.SeqNum={}",appr.getApprck1().getSeqNum());
			log.debug("appr.getApprck2.SeqNum={}",appr.getApprck2().getSeqNum());
			log.debug("appr.getApprck3.SeqNum={}",appr.getApprck3().getSeqNum());
			appr.setAttachment(attach);
			log.debug("attach={}",attach);
			
		}
		
		//2. appr(전자결제), apprch(전자결제승인) attachment(파일) 객체 db에 저장
		
		int result = approvalService.insertSaveApproval(appr);
		log.debug("result={}",result);
		
		//처리결과 msg 전달
		
		model.addAttribute("appr",appr);
		model.addAttribute("apprck1",apprck1);
		model.addAttribute("apprck2",apprck2);
		model.addAttribute("apprck3",apprck3);
		model.addAttribute("attach",attach);
		
		
		return "redirect:/approval/myApvList?page=1";
	}
	
	
	
	
	
	@RequestMapping(value="/reWrite.do", method=RequestMethod.POST)
	public String reWrite(Model model,
						  @RequestParam(value="approval_id") String key) {
		
		
		appr appr = approvalService.reWriteAppr(key);
		List<apprCheck> apprchList = approvalService.reWriteApprck(key);
		Attachment attach = approvalService.reWriteAttach(key);
		
		apprCheck apprck1 = new apprCheck();
		apprCheck apprck2 = new apprCheck();
		apprCheck apprck3 = new apprCheck();
		
		apprck1 = apprchList.get(0);
		apprck2 = apprchList.get(1);
		apprck3 = apprchList.get(2);
		log.debug("apprchList={}",apprchList);
		log.debug("apprck1={}",apprck1);
		log.debug("apprck2={}",apprck2);
		log.debug("apprck3={}",apprck3);
		
		
		model.addAttribute("appr",appr);
		
		model.addAttribute("apprck1",apprck1);
		model.addAttribute("apprck2",apprck2);
		model.addAttribute("apprck3",apprck3);
		
		model.addAttribute("attach",attach);
		
		
		
		return "approval/writeForm";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	public PagingInfo paging(int page, List<appr> appr) {
		
		int countList = 10; //페이지당 게시물 수
		int countPage = 10; //페이지 수
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
