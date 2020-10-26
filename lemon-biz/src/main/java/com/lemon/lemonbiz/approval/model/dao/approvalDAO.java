package com.lemon.lemonbiz.approval.model.dao;

import java.util.List;
import java.util.Map;

import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.approval.model.vo.Appr;
import com.lemon.lemonbiz.approval.model.vo.apprCheck;
import com.lemon.lemonbiz.approval.model.vo.approval;
import com.lemon.lemonbiz.common.vo.Attachment;
import com.lemon.lemonbiz.member.model.vo.Dept;


public interface approvalDAO {

	List<Dept> deptList();

	List<Dept> child();

	List<Dept> child2();

	List<Member> memberList(String node);

	List<Member> selectMember(String param);

	List<Member> joinMemberList(String param);

	String SeqApprKey();

	int insertSaveApproval(Appr appr);

	int insertSaveAttachment(Attachment attach);

	int insertSaveApprck1(apprCheck apprck1);

	int insertSaveApprck2(apprCheck apprck2);

	int insertSaveApprck3(apprCheck apprck3);

	List<Appr> approvalList(String memberId);

	Appr reWriteAppr(String key);

	List<apprCheck> reWriteApprck(String key);

	Attachment reWriteAttach(String key);

	int updateApproval(Appr appr);

	int insertApproval(Appr appr);

	int updateApprck1(apprCheck apprck1);

	int updateApprck2(apprCheck apprck2);

	int updateApprck3(apprCheck apprck3);

	List<apprCheck> apprckList(String memberId);

	List<Appr> apprAndCkList(String memberId);

	Appr apprckDetail(int ckKey);

	Attachment selectOneAttachment(String key);

	apprCheck selectcApprck(Map<String, String> map);

	int changeApprck(int key);

	int backApprck(int key);

	List<Appr> myApprovalList(String memberId);

	



	


}
