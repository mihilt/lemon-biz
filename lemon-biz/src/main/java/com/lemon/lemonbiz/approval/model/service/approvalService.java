package com.lemon.lemonbiz.approval.model.service;

import java.util.List;

import org.springframework.stereotype.Service;


import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.approval.model.vo.appr;
import com.lemon.lemonbiz.approval.model.vo.apprCheck;
import com.lemon.lemonbiz.approval.model.vo.approval;
import com.lemon.lemonbiz.common.vo.Attachment;
import com.lemon.lemonbiz.member.model.vo.Dept;



public interface approvalService {

	List<Dept> deptList();

	List<Dept> child();

	List<Dept> child2();

	List<Member> memberList(String node);

	List<Member> selectMember(String param);

	List<Member> joinMemberlist(String param);

	String SeqApprKey();

	int insertSaveApproval(appr appr);

	List<appr> ApprovalList(String memberId);

	appr reWriteAppr(String key);

	List<apprCheck> reWriteApprck(String key);

	Attachment reWriteAttach(String key);

	


	
}
