package com.lemon.lemonbiz.approval.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lemon.lemonbiz.approval.model.dao.ApprovalDAO;
import com.lemon.lemonbiz.approval.model.vo.Appr;
import com.lemon.lemonbiz.approval.model.vo.ApprCheck;
import com.lemon.lemonbiz.approval.model.vo.DocType;
import com.lemon.lemonbiz.common.vo.Attachment;
import com.lemon.lemonbiz.member.model.vo.Dept;
import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.notice.model.service.NoticeService;
import com.lemon.lemonbiz.notice.model.vo.Notice;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional(propagation = Propagation.REQUIRED, 
				isolation = Isolation.READ_COMMITTED,
				rollbackFor = Exception.class)

@Service
public class ApprovalServiceImpl implements ApprovalService {
	
	@Autowired
	private ApprovalDAO approvalDAO;
	
	@Autowired
	private NoticeService noticeService;

	@Override
	public List<Dept> deptList() {
		
		return approvalDAO.deptList();
	}

	@Override
	public List<Dept> child() {
		
		return approvalDAO.child();
	}

	@Override
	public List<Dept> child2() {
		return approvalDAO.child2();
	}

	@Override
	public List<Member> memberList(String node) {
		return approvalDAO.memberList(node);
	}

	@Override
	public List<Member> selectMember(String param) {
		return approvalDAO.selectMember(param);
	}

	@Override
	public List<Member> joinMemberlist(String param) {
		return approvalDAO.joinMemberList(param);
	}

	@Override
	public String SeqApprKey() {
		return approvalDAO.SeqApprKey();
	}

	@Override
	public int insertSaveApproval(Appr appr) {
		int result = 0;
		//1. approval insert
		result = approvalDAO.insertSaveApproval(appr);
		
		//2. attachment insert	
		ApprCheck apprck1 = appr.getApprck1();
		result = approvalDAO.insertSaveApprck1(apprck1);
		
	
		ApprCheck apprck2 = appr.getApprck2();
		result = approvalDAO.insertSaveApprck2(apprck2);
		
	
		ApprCheck apprck3 = appr.getApprck3();
		result = approvalDAO.insertSaveApprck3(apprck3);
		
		
		return result;
	}

	@Override
	public List<Appr> ApprovalList(String memberId) {
		return approvalDAO.approvalList(memberId);
	}

	@Override
	public Appr reWriteAppr(String key) {
		return approvalDAO.reWriteAppr(key);
	}

	@Override
	public List<ApprCheck> reWriteApprck(String key) {
		return approvalDAO.reWriteApprck(key);
	}

	@Override
	public Attachment reWriteAttach(String key) {
		return approvalDAO.reWriteAttach(key);
	}

	@Override
	public int updateApproval(Appr appr) {
		
		int result = 0;
		result = approvalDAO.updateApproval(appr);
		
		ApprCheck apprck1 = appr.getApprck1();
		result = approvalDAO.updateApprck1(apprck1);
	
		ApprCheck apprck2 = appr.getApprck2();
		result = approvalDAO.updateApprck2(apprck2);
	
		ApprCheck apprck3 = appr.getApprck3();
		result = approvalDAO.updateApprck3(apprck3);
		
		//3. attachment insert
		if(appr.getAttachment() != null) {
			Attachment attach = appr.getAttachment();
			result = approvalDAO.insertSaveAttachment(attach);
		}
		
		return result;
	}

	@Override
	public int insertApproval(Appr appr) {
		
		int result = 0;
		//1. approval insert
		result = approvalDAO.insertApproval(appr);
		
		//2. apprckeck insert
		ApprCheck apprck1 = appr.getApprck1();
		result = approvalDAO.insertSaveApprck1(apprck1);
	
		ApprCheck apprck2 = appr.getApprck2();
		result = approvalDAO.insertSaveApprck2(apprck2);
	
		ApprCheck apprck3 = appr.getApprck3();
		result = approvalDAO.insertSaveApprck3(apprck3);

		//3. attachment insert
		if(appr.getAttachment() != null) {
			Attachment attach = appr.getAttachment();
			result = approvalDAO.insertSaveAttachment(attach);
		}
		
		//1차 결재자 알림
		Notice notice = new Notice();
		notice.setContent("새로운 결재 요청 \"" + appr.getTitle() + "\" 있습니다.");
//		notice.setAddress("/approval/requestApprovalList?page=1");
		notice.setIcon("fa-file");
		notice.setColor("success");

		//1차 결재자 appr_check 키값 알아오기
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("approval_key", appr.getKey());
		map.put("mem_id", apprck1.getMemId());
		int noticeKey = approvalDAO.selectOneApprCheckKey(map);
		
		notice.setMemId(apprck1.getMemId());
		notice.setAddress("/approval/reauestApprovalDetail.do?apprKey=" + appr.getKey() + "&ckKey=" + noticeKey);
		noticeService.insertNotice(notice);
		
		//2,3차는 1,2차 결재 승인일 경우에, 현재 컨트롤러 3차 승인이 반려처리 되어있어 수정사항 있을 것임, 완료가 되면 추가 
		
		return result;
		
	}

	@Override
	public List<ApprCheck> apprckList(String memberId) {
		return approvalDAO.apprckList(memberId);
	}

	@Override
	public List<Appr> apprAndCkList(Member loginMember) {
		return approvalDAO.apprAndCkList(loginMember);
	}

	@Override
	public Appr apprckDetail(int ckKey) {
		return approvalDAO.apprckDetail(ckKey);
	}

	@Override
	public Attachment selectOneAttachment(String key) {
		return approvalDAO.selectOneAttachment(key);
	}

	@Override
	public ApprCheck selectcApprck(Map<String, String> map) {
		return approvalDAO.selectcApprck(map);
	}

	@Override
	public int changeApprck(int key, Appr appr) {
		//1,2차 승인시 2,3차 결재자 알림

		//다음 결재자 아이디 조회
		String nextMemberId = approvalDAO.selectNextMemberId(key);
		
		Notice notice = new Notice();
		notice.setMemId(nextMemberId);
		notice.setContent("새로운 결재 요청 \"" + appr.getTitle() + "\" 있습니다.");
		notice.setIcon("fa-file");
		notice.setColor("success");
		notice.setAddress("/approval/reauestApprovalDetail.do?apprKey=" + appr.getKey() + "&ckKey=" + key);
		noticeService.insertNotice(notice);
		
		return approvalDAO.changeApprck(key);
	}

	
	//마지막 3차 승인
	@Override
	public int backApprck(int key, String apprKey, Appr appr) {
		//기안자에게 최종 승인 알림
		Notice notice = new Notice();
		notice.setMemId(appr.getMemId());
		notice.setContent("결재 \"" + appr.getTitle() + "\" 최종적으로 승인 되었습니다.");
		notice.setIcon("fa-file");
		notice.setColor("success");
		notice.setAddress("/approval/compliteApprovalDetail.do?apprKey=" + appr.getKey());
		noticeService.insertNotice(notice);
		
		
		int result = 0;
		
		
		result = approvalDAO.backApprck(key);
		
		result = approvalDAO.backAppr(apprKey);
		
		return result;
	}

	@Override
	public List<Appr> myApprovalList(String memberId) {
		return approvalDAO.myApprovalList(memberId);
	}

	@Override
	public DocType selectOneDocTypeAjax(DocType docType) {
		return approvalDAO.selectOneDocTypeAjax(docType);
	}

	@Override
	public List<DocType> selectDocTypeTitleList() {
		return approvalDAO.selectDocTypeTitleList();
	}

	@Override
	public List<Appr> compliteApprList(String memberId) {
		return approvalDAO.compliteApprList(memberId);
	}

	@Override
	public List<Appr> returnApprList(String memberId) {	
		return approvalDAO.returnApprList(memberId);
	}

	@Override
	public Appr returnApprovalDetail(String key) {

		
		return approvalDAO.returnApprovalDetail(key);
	}

	@Override
	public Appr compliteApprDetail(String key) {
		return approvalDAO.compliteApprDetail(key);
	}

	@Override
	public int returnApproval(Map<String, String> map, Appr appr) {
		//기안자에게 최종 반려 알림
		Notice notice = new Notice();
		notice.setMemId(appr.getMemId());
		notice.setContent("결재 \"" + appr.getTitle() + "\" 최종적으로 반려 되었습니다.");
		notice.setIcon("fa-file");
		notice.setColor("warning");
		notice.setAddress("/approval/returnApprovalDetail.do?apprKey=" + appr.getKey());
		noticeService.insertNotice(notice);
		
		int result = 0;
		
		result = approvalDAO.returnApprck(map);
		
		result = approvalDAO.returnApproval(map);
		
		return result;
	}

	@Override
	public int getCountApproval(HashMap<Object, Object> params) {
		return approvalDAO.getCountApproval(params);
	}




}
