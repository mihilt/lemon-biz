package com.lemon.lemonbiz.approval.model.service;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lemon.lemonbiz.approval.model.dao.approvalDAO;
import com.lemon.lemonbiz.approval.model.vo.appr;
import com.lemon.lemonbiz.approval.model.vo.apprCheck;
import com.lemon.lemonbiz.common.vo.Attachment;
import com.lemon.lemonbiz.member.model.vo.Dept;
import com.lemon.lemonbiz.member.model.vo.Member;


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
	public int insertSaveApproval(appr appr) {
		int result = 0;
		//1. approval insert
		result = approvalDAO.insertSaveApproval(appr);
		
		//2. attachment insert
		if(appr.getAttachment() != null) {
			Attachment attach = appr.getAttachment();
			result = approvalDAO.insertSaveAttachment(attach);
		}
			
			apprCheck apprck1 = appr.getApprck1();
			result = approvalDAO.insertSaveApprck1(apprck1);
			System.out.println(apprck1.getSeqNum());
			System.out.println(apprck1.getSeqNum());
			System.out.println(apprck1.getSeqNum());
			System.out.println(apprck1.getSeqNum());
			System.out.println(apprck1.getSeqNum());
		
			apprCheck apprck2 = appr.getApprck2();
			result = approvalDAO.insertSaveApprck2(apprck2);
			System.out.println(apprck2.getSeqNum());
			System.out.println(apprck2.getSeqNum());
			System.out.println(apprck2.getSeqNum());
			System.out.println(apprck2.getSeqNum());
			System.out.println(apprck2.getSeqNum());
			System.out.println(apprck2.getSeqNum());
		
			apprCheck apprck3 = appr.getApprck3();
			result = approvalDAO.insertSaveApprck3(apprck3);
		
		
		return result;
	}




}
