package com.lemon.lemonbiz.manager.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lemon.lemonbiz.approval.model.vo.DocType;
import com.lemon.lemonbiz.attend.model.service.AttendService;
import com.lemon.lemonbiz.attend.model.vo.Attend;
import com.lemon.lemonbiz.manager.model.service.ManagerService;
import com.lemon.lemonbiz.member.model.service.MemberService;
import com.lemon.lemonbiz.member.model.vo.Dept;
import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.member.model.vo.Rank;
import com.lemon.lemonbiz.notice.model.service.NoticeService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/manager")
@SessionAttributes({"loginMember"})
public class ManagerController {
	
	@Autowired
	private MemberService memberService;

	@Autowired
	private AttendService attendService;
	
	@Autowired
	private ManagerService managerService;

	//사원 추가
	@RequestMapping(value = "/insertMember.do", method = RequestMethod.GET)
	public void insertMember(Model model) {
		
		try {
			
			List<Dept> deptList = memberService.selectDeptList();
			List<Rank> rankList = memberService.selectRankList();
			
			model.addAttribute("deptList", deptList);
			model.addAttribute("rankList", rankList);
			
		} catch(Exception e) {
			log.error("부서, 직급 리스트 조회 오류", e);
			throw e;
		}

		
	}

	//부서 관리 화면요청
	@RequestMapping(value = "/manageDept.do", method = RequestMethod.GET)
	public void manageDept(Model model) {

		try {
		
			List<Dept> deptList = memberService.selectDeptList();
			model.addAttribute("deptList", deptList);
		
		} catch(Exception e) {
			
			log.error("부서 리스트 조회 오류", e);
			throw e;
			
		}
		
	}

	//부서 추가 화면요청
	@RequestMapping(value = "/insertDept.do", method = RequestMethod.GET)
	public void insertDeptGet(Model model) {
		
		try {
			
			List<Dept> deptList = memberService.selectDeptList();
			model.addAttribute("deptList", deptList);
		
		} catch(Exception e) {
			
			log.error("부서 리스트 조회 오류", e);
			throw e;
			
		}

	}
	
	//부서 추가
	@RequestMapping(value = "/insertDept.do", method = RequestMethod.POST)
	public String insertDeptPost(Dept dept, RedirectAttributes redirectAttr) {
		
		try {
			
			Dept dept1 = managerService.selectOneDept(dept);
			Dept dept2 = managerService.selectOneRefDept(dept);
			
			if(dept1 == null) {
				
				if(dept2 == null) {
					
					redirectAttr.addFlashAttribute("msg", "존재하는 상위 부서가 없습니다.");
					
					return "redirect:/manager/insertDept.do";
					
				}
				
				int result = managerService.insertDept(dept);
				redirectAttr.addFlashAttribute("msg", "생성을 완료하였습니다.");
				
			} else {
				
				redirectAttr.addFlashAttribute("msg", "이미 존재하는 부서 번호 입니다.");
				
			}
		
		} catch(Exception e) {
			
			log.error("부서 조회 오류", e);
			throw e;
			
		}

		
		return "redirect:/manager/insertDept.do";
		
	}
	
	//직급 관리 화면요청
	@RequestMapping(value = "/manageRank.do", method = RequestMethod.GET)
	public void manageRank(Model model) {
		
		List<Rank> rankList = null;
		
		try{
			rankList = memberService.selectRankList();
		}catch(Exception e) {
			log.error("직급 리스트 조회 오류", e);
			throw e;
		}
		model.addAttribute("rankList", rankList);
		
	}
	
	//직급 업데이트
	@RequestMapping(value = "/manageRank/update.do", method = RequestMethod.GET)
	public String updateRank(Rank rank, RedirectAttributes redirectAttr) {
	
	int result = 0;
		
	try {	
		result = managerService.updateRank(rank);
	}catch(Exception e) {
		log.error("직급 업데이트 오류", e);
		throw e;
	}
		redirectAttr.addFlashAttribute("msg", (result > 0) ? "직급 수정을 완료하였습니다." : "직급 수정에 오류가 발생했습니다.");
		
		return "redirect:/manager/manageRank.do";
	}
	
	//직급 삭제
	@RequestMapping(value = "/manageRank/delete.do", method = RequestMethod.GET)
	public String deleteRank(Rank rank, RedirectAttributes redirectAttr) {
		
		int result = 0;
		
		try {
			result = managerService.deleteRank(rank);
		}catch(Exception e) {
			log.error("직급 삭제 오류", e);
			throw e;
		}
		
		redirectAttr.addFlashAttribute("msg", (result > 0) ? "직급 삭제를 완료하였습니다." : "직급 삭제에 오류가 발생했습니다.");
		
		return "redirect:/manager/manageRank.do";
	}
	
	//부서 삭제
	@RequestMapping(value = "manageDept/delete.do", method = RequestMethod.GET)
	public String deleteDept(Dept dept, RedirectAttributes redirectAttr) {
		
		int result = 0;
		
		try {
			result = managerService.deleteDept(dept);
		}catch(Exception e) {
			log.error("부서 삭제 오류", e);
			throw e;
		}
		
		redirectAttr.addFlashAttribute("msg", (result > 0) ? "부서 삭제를 완료하였습니다." : "부서 삭제에 오류가 발생했습니다.");
		
		return "redirect:/manager/manageDept.do";
	}
	
	//직급 삽입 화면요청
	@RequestMapping(value = "/insertRank.do", method = RequestMethod.GET)
	public void insertRankGet() {
		
	}
	//직급 삽입	
	@RequestMapping(value = "/insertRank.do", method = RequestMethod.POST)
	public String insertRankPost(Rank rank, RedirectAttributes redirectAttr) {
		
		int result = 0;
		
		try {
			result = managerService.insertRank(rank);
		}catch(Exception e) {
			log.error("직급 삽입 오류", e);
			throw e;
		}
		redirectAttr.addFlashAttribute("msg", (result > 0) ? "직급 생성을 완료하였습니다." : "직급 생성에 오류가 발생했습니다.");
		
		return "redirect:insertRank.do";
	}
	
	//사원관리 화면요청
	@RequestMapping(value = "/manageMember.do", method = RequestMethod.GET)
	public void manageMember(Model model) {
		
		List<Member> memberList = null;
		
		try {
			memberList = memberService.selectMemberList();
		}catch(Exception e) {
			log.error("사원 리스트 조회 오류", e);
			throw e;
		}
		model.addAttribute("memberList", memberList);
		
	}
	
	//사원 관리 상세보기
	@RequestMapping(value = "/manageMember/detail.do", method = RequestMethod.GET)
	public String manageMemberDetail(Model model, Member getMember) {
		
		Member member = null;
		List<Dept> deptList = null;
		List<Rank> rankList = null;
		
		try {
			member = memberService.selectOneMember(getMember.getMemberId());
		}catch(Exception e) {
			log.error("사원 selectOne 조회 오류", e);
			throw e;
		}
		
		try {
			deptList = memberService.selectDeptList();
		}catch(Exception e) {
			log.error("부서 리스트 조회 오류", e);
			throw e;
		}
		
		try {
			rankList = memberService.selectRankList();
		}catch(Exception e) {
			log.error("직급 리스트 조회 오류", e);
			throw e;
		}
		
		model.addAttribute("deptList", deptList);
		model.addAttribute("rankList", rankList);
		model.addAttribute("member", member);
		
		return "forward:/WEB-INF/views/manager/memberDetail.jsp";
		
	}
	
	//사원 정보 업데이트
	@RequestMapping(value = "/manageMember/detail/update.do", method = RequestMethod.GET)
	public String manageMemberDetailUpdate(Model model, 
										   Member member, 
										   RedirectAttributes redirectAttr,
										   @SessionAttribute("loginMember") Member loginMember) {
		
		int result = 0;
		
		try {
			result = managerService.updateMember(member);
		}catch(Exception e) {
			log.error("사원 업데이트 오류", e);
			throw e;
		}
		
		redirectAttr.addFlashAttribute("msg", (result > 0) ? "수정을 완료하였습니다." : "수정에 오류가 발생했습니다.");
		
		if(member.getMemberId().equals(loginMember.getMemberId())) {
			loginMember = memberService.selectOneMember(member.getMemberId());
			model.addAttribute("loginMember", loginMember);
		}
		
		return "redirect:/manager/manageMember/detail.do?memberId="+member.getMemberId();
		
	}
	
	//사원 삭제
	@RequestMapping(value = "/manageMember/delete.do", method = RequestMethod.GET)
	public String manageMemberLeave(Model model, Member member, RedirectAttributes redirectAttr) {
		
		int result = 0;

		try {
			result = memberService.deleteMember(member);
		}catch(Exception e) {
			log.error("사원  삭제 오류" + e);
		}
		
		redirectAttr.addFlashAttribute("msg", (result > 0) ? "퇴사 처리를 완료하였습니다." : "오류가 발생했습니다.");
		
		return "redirect:/manager/manageMember.do";
	}
	
	//부서 업데이트 화면요청
	@RequestMapping(value = "manageDept/update.do", method = RequestMethod.GET)
	public String updateDeptGet(Dept getDept, Model model) {
		
		Dept dept = null;
		
		try {
			dept = managerService.selectOneDept(getDept);
		}catch(Exception e) {
			log.error("부서 조회 오류", e);
			throw e;
		}
			
		List<Dept> deptList = null;
		
		try {
			deptList = memberService.selectDeptList();
		}catch(Exception e) {
			log.error("직급 리스트 조회 오류", e);
			throw e;
		}
		
		model.addAttribute("deptList", deptList);
		model.addAttribute("dept", dept);
		
		return "forward:/WEB-INF/views/manager/updateDept.jsp";
	}
	
	//부서 업데이트
	@RequestMapping(value = "manageDept/update.do", method = RequestMethod.POST)
	public String updateDeptPost(Dept dept, Model model, RedirectAttributes redirectAttr) {
		
		int result = 0;
		
		try {
			result = managerService.updateDept(dept);
		}catch(Exception e) {
			log.error("부서 업데이트 오류", e);
			throw e;
		}
		
		redirectAttr.addFlashAttribute("msg", (result > 0) ? "부서 수정을 완료하였습니다." : "부서 수정에 오류가 발생했습니다.");
		
		return "redirect:/manager/manageDept/update.do?key="+dept.getKey();
	}
	
	//결재문서 양식 추가 화면요청
	@RequestMapping(value = "/insertApprovalDoc.do", method = RequestMethod.GET)
	public void insertApprovalDocGet() {
		
	}
	//결재문서 양식 추가
	@RequestMapping(value = "/insertApprovalDoc.do", method = RequestMethod.POST)
	public String insertApprovalDocPost(DocType docType, RedirectAttributes redirectAttr) {
		
		int result = 0;
		
		try {
			result = managerService.insertApprovalDoc(docType);
		}catch(Exception e) {
			log.error("결재문서 양식 추가 오류", e);
			throw e;
		}
		redirectAttr.addFlashAttribute("msg", (result > 0) ? "전자결재 양식 생성을 완료했습니다." : "전자결재 양식 생성에 오류가 발생했습니다.");
		
		return "redirect:/manager/insertApprovalDoc.do";
	}

	//결재문서 양식 관리
	@RequestMapping(value = "/manageApprovalDoc.do", method = RequestMethod.GET)
	public void manageApprovalDoc(Model model) {
		
		List<DocType> docTypeList =  null;
		
		try {
			docTypeList = managerService.selectDocTypeList();
		}catch(Exception e) {
			log.error("결재문서 양식 리스트 조회 오류", e);
			throw e;
		}
		
		model.addAttribute("docTypeList", docTypeList);
		
	}
	
	//결재문서 양식 수정 화면요청
	@RequestMapping(value = "/manageApprovalDoc/update.do", method = RequestMethod.GET)
	public String manageApprovalDocUpdate(Model model, DocType docType) {
		
		DocType docType_ = null;
		
		try {
			docType_ = managerService.selectOneDocType(docType);
		}catch(Exception e) {
			log.error("결재문서 양식 추가 오류", e);
			throw e;
		}
		
		model.addAttribute("docType", docType_);
		
		return "forward:/WEB-INF/views/manager/updateApprovalDoc.jsp";
	}
	
	//결재문서 양식 수정
	@RequestMapping(value = "/updateApprovalDoc.do", method = RequestMethod.POST)
	public String updateApprovalDoc(DocType docType, RedirectAttributes redirectAttr) {

		int result = 0;
		
		try {
			result = managerService.updateApprovalDoc(docType);
		}catch(Exception e) {
			log.error("결재문서 양식 수정 오류", e);
			throw e;
		}
		
		redirectAttr.addFlashAttribute("msg", (result > 0) ? "전자결재 문서 수정을 완료했습니다." : "전자결재 문서 수정에 오류가 발생했습니다.");
		
		return "redirect:/manager/manageApprovalDoc.do";
	}
	
	//결재문서 양식 삭제
	@RequestMapping(value = "manageApprovalDoc/delete.do", method = RequestMethod.GET)
	public String manageApprovalDocDelete(DocType docType, RedirectAttributes redirectAttr) {
		
		try {
			managerService.deleteApprovalDoc(docType);
		}catch(Exception e) {
			log.error("결재문서 양식 삭제 오류", e);
			throw e;
		}
		
		return "redirect:/manager/manageApprovalDoc.do";
	}
	
	//근태관리
	@RequestMapping(value = "/manageAttend.do", method = RequestMethod.GET)
	public String attendMember(Model model) {
		
		List<Attend> attendList = null;
		
		try {
			attendList = attendService.selectAttendList();
		}catch(Exception e) {
			log.error("근태 리스트 조회 오류", e);
			throw e;
		}
	
		model.addAttribute("attendList",attendList);
		return "/attend/managerAttend";
	}
}
