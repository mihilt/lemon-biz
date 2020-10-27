package com.lemon.lemonbiz.approval.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.approval.model.vo.Appr;
import com.lemon.lemonbiz.approval.model.vo.ApprCheck;
import com.lemon.lemonbiz.approval.model.vo.Approval;
import com.lemon.lemonbiz.approval.model.vo.DocType;
import com.lemon.lemonbiz.common.vo.Attachment;
import com.lemon.lemonbiz.member.model.vo.Dept;


public interface ApprovalDAO {

	List<Dept> deptList();

	List<Dept> child();

	List<Dept> child2();

	List<Member> memberList(String node);

	List<Member> selectMember(String param);

	List<Member> joinMemberList(String param);

	String SeqApprKey();

	int insertSaveApproval(Appr appr);

	int insertSaveAttachment(Attachment attach);

	int insertSaveApprck1(ApprCheck apprck1);

	int insertSaveApprck2(ApprCheck apprck2);

	int insertSaveApprck3(ApprCheck apprck3);

	List<Appr> approvalList(String memberId);

	Appr reWriteAppr(String key);

	List<ApprCheck> reWriteApprck(String key);

	Attachment reWriteAttach(String key);

	int updateApproval(Appr appr);

	int insertApproval(Appr appr);

	int updateApprck1(ApprCheck apprck1);

	int updateApprck2(ApprCheck apprck2);

	int updateApprck3(ApprCheck apprck3);

	List<ApprCheck> apprckList(String memberId);

	List<Appr> apprAndCkList(Member memberId);

	Appr apprckDetail(int ckKey);

	Attachment selectOneAttachment(String key);

	ApprCheck selectcApprck(Map<String, String> map);

	int changeApprck(int key);

	int backApprck(int key);

	List<Appr> myApprovalList(String memberId);

	DocType selectOneDocTypeAjax(DocType docType);

	List<DocType> selectDocTypeTitleList();

	int selectOneApprCheckKey(Map<String, Object> map);

	List<Appr> compliteApprList(String memberId);

	List<Appr> returnApprList(String memberId);

	Appr returnApprovalDetail(String key);

	Appr compliteApprDetail(String key);

	int returnApproval(Map<String, String> map);

	int backAppr(String apprKey);

	int returnApprck(Map<String, String> map);

	int getCountApproval(HashMap<Object, Object> params);

	



	


}
