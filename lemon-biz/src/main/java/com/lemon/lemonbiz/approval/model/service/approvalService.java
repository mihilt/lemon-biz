package com.lemon.lemonbiz.approval.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;


import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.approval.model.vo.Appr;
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

	int insertSaveApproval(Appr appr);

	List<Appr> ApprovalList(String memberId);

	Appr reWriteAppr(String key);

	List<apprCheck> reWriteApprck(String key);

	Attachment reWriteAttach(String key);

	int updateApproval(Appr appr);

	int insertApproval(Appr appr);

	List<apprCheck> apprckList(String memberId);

	List<Appr> apprAndCkList(String memberId);

	Appr apprckDetail(int ckKey);

	Attachment selectOneAttachment(String key);

	apprCheck selectcApprck(Map<String, String> map);

	int changeApprck(int key);

	int backApprck(int key, String apprKey);

	List<Appr> myApprovalList(String memberId);

	int returnApprove(Map<String, String> map);

	List<Appr> returnApprList(String memberId);

	Appr returnApprovalDetail(String key);

	List<Appr> compliteApprList(String memberId);

	Appr compliteApprDetail(String key);

	

	


	
}
