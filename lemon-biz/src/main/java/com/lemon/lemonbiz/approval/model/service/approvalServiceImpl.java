package com.lemon.lemonbiz.approval.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lemon.lemonbiz.approval.model.dao.approvalDAO;
import com.lemon.lemonbiz.approval.model.vo.Appr;
import com.lemon.lemonbiz.approval.model.vo.apprCheck;
import com.lemon.lemonbiz.approval.model.vo.approval;
import com.lemon.lemonbiz.common.vo.Attachment;
import com.lemon.lemonbiz.member.model.vo.Dept;
import com.lemon.lemonbiz.member.model.vo.Member;

@Transactional(propagation = Propagation.REQUIRED, 
				isolation = Isolation.READ_COMMITTED,
				rollbackFor = Exception.class)

@Service
public class approvalServiceImpl implements approvalService {
	
	@Autowired
	private approvalDAO approvalDAO;

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
		apprCheck apprck1 = appr.getApprck1();
		result = approvalDAO.insertSaveApprck1(apprck1);
		System.out.println(apprck1.getSeqNum());
		
	
		apprCheck apprck2 = appr.getApprck2();
		result = approvalDAO.insertSaveApprck2(apprck2);
		System.out.println(apprck2.getSeqNum());
		
	
		apprCheck apprck3 = appr.getApprck3();
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
	public List<apprCheck> reWriteApprck(String key) {
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
		
		apprCheck apprck1 = appr.getApprck1();
		result = approvalDAO.updateApprck1(apprck1);
		System.out.println(apprck1.getSeqNum());
		
	
		apprCheck apprck2 = appr.getApprck2();
		result = approvalDAO.updateApprck2(apprck2);
		System.out.println(apprck2.getSeqNum());
		
	
		apprCheck apprck3 = appr.getApprck3();
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
		apprCheck apprck1 = appr.getApprck1();
		result = approvalDAO.insertSaveApprck1(apprck1);
		System.out.println(apprck1.getSeqNum());
		
	
		apprCheck apprck2 = appr.getApprck2();
		result = approvalDAO.insertSaveApprck2(apprck2);
		System.out.println(apprck2.getSeqNum());
		
	
		apprCheck apprck3 = appr.getApprck3();
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
	public List<apprCheck> apprckList(String memberId) {
		return approvalDAO.apprckList(memberId);
	}

	@Override
	public List<Appr> apprAndCkList(String memberId) {
		return approvalDAO.apprAndCkList(memberId);
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
	public apprCheck selectcApprck(Map<String, String> map) {
		return approvalDAO.selectcApprck(map);
	}

	@Override
	public int changeApprck(int key) {
		return approvalDAO.changeApprck(key);
	}

	@Override
	public int backApprck(int key, String apprKey) {
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
	public int returnApprove(Map<String, String> map) {
		int result = 0;
		
		result = approvalDAO.returnApprck(map);
		
		result = approvalDAO.returnApproval(map);
		
		return result;
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
	public List<Appr> compliteApprList(String memberId) {
		return approvalDAO.compliteApprList(memberId);
	}







}
