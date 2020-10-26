package com.lemon.lemonbiz.approval.model.service;

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
import com.lemon.lemonbiz.approval.model.vo.Approval;
import com.lemon.lemonbiz.approval.model.vo.DocType;
import com.lemon.lemonbiz.common.vo.Attachment;
import com.lemon.lemonbiz.member.model.vo.Dept;
import com.lemon.lemonbiz.member.model.vo.Member;

@Transactional(propagation = Propagation.REQUIRED, 
				isolation = Isolation.READ_COMMITTED,
				rollbackFor = Exception.class)

@Service
public class ApprovalServiceImpl implements ApprovalService {
	
	@Autowired
	private ApprovalDAO approvalDAO;

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
		System.out.println(apprck1.getSeqNum());
		
	
		ApprCheck apprck2 = appr.getApprck2();
		result = approvalDAO.insertSaveApprck2(apprck2);
		System.out.println(apprck2.getSeqNum());
		
	
		ApprCheck apprck3 = appr.getApprck3();
		result = approvalDAO.insertSaveApprck3(apprck3);
		System.out.println(apprck3.getSeqNum());
		
		
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
		System.out.println(apprck1.getSeqNum());
		
	
		ApprCheck apprck2 = appr.getApprck2();
		result = approvalDAO.updateApprck2(apprck2);
		System.out.println(apprck2.getSeqNum());
		
	
		ApprCheck apprck3 = appr.getApprck3();
		result = approvalDAO.updateApprck3(apprck3);
		System.out.println(apprck3.getSeqNum());
		
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
		System.out.println(apprck1.getSeqNum());
		
	
		ApprCheck apprck2 = appr.getApprck2();
		result = approvalDAO.insertSaveApprck2(apprck2);
		System.out.println(apprck2.getSeqNum());
		
	
		ApprCheck apprck3 = appr.getApprck3();
		result = approvalDAO.insertSaveApprck3(apprck3);
		System.out.println(apprck3.getSeqNum());
		
		//3. attachment insert
		if(appr.getAttachment() != null) {
			Attachment attach = appr.getAttachment();
			result = approvalDAO.insertSaveAttachment(attach);
		}
		
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
	public int changeApprck(int key) {
		return approvalDAO.changeApprck(key);
	}

	@Override
	public int backApprck(int key) {
		return approvalDAO.backApprck(key);
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



}
