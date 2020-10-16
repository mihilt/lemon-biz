package com.lemon.lemonbiz.approval.model.dao;

import java.util.List;


import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.approval.model.vo.appr;
import com.lemon.lemonbiz.approval.model.vo.apprCheck;
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

	int insertSaveApproval(appr appr);

	int insertSaveAttachment(Attachment attach);

	int insertSaveApprck1(apprCheck apprck1);

	int insertSaveApprck2(apprCheck apprck2);

	int insertSaveApprck3(apprCheck apprck3);


	


}
