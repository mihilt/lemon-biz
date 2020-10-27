package com.lemon.lemonbiz.approval.model.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.approval.model.vo.appr;
import com.lemon.lemonbiz.approval.model.vo.apprCheck;
import com.lemon.lemonbiz.approval.model.vo.approval;
import com.lemon.lemonbiz.common.vo.Attachment;
import com.lemon.lemonbiz.member.model.vo.Dept;


@Repository
public class approvalDAOImpl implements approvalDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<Dept> deptList() {
		return sqlSession.selectList("approval.selectDeptList");
	}

	@Override
	public List<Dept> child() {
		return sqlSession.selectList("approval.selectChild");
	}

	@Override
	public List<Dept> child2() {
		return sqlSession.selectList("approval.selectChild2");
	}

	@Override
	public List<Member> memberList(String node) {
		return sqlSession.selectList("approval.memberList",node);
	}

	@Override
	public List<Member> selectMember(String param) {
		return sqlSession.selectList("approval.selectMember",param);
	}

	@Override
	public List<Member> joinMemberList(String param) {
		return sqlSession.selectList("approval.joinMemberList",param);
	}

	@Override
	public String SeqApprKey() {
		return sqlSession.selectOne("approval.SeqApprKey");
	}

	@Override
	public int insertSaveApproval(appr appr) {
		return sqlSession.insert("approval.insertSaveApproval",appr);
	}

	@Override
	public int insertSaveAttachment(Attachment attach) {
		return sqlSession.insert("approval.insertSavaAttachment",attach);
	}

	@Override
	public int insertSaveApprck1(apprCheck apprck1) {
		return sqlSession.insert("approval.insertSaveApprck1",apprck1);
	}

	@Override
	public int insertSaveApprck2(apprCheck apprck2) {
		return sqlSession.insert("approval.insertSaveApprck2",apprck2);
	}

	@Override
	public int insertSaveApprck3(apprCheck apprck3) {
		return sqlSession.insert("approval.insertSaveApprck3",apprck3);
	}

	@Override
	public List<appr> approvalList(String memberId) {
		return sqlSession.selectList("approval.approvalList",memberId);
	}

	@Override
	public appr reWriteAppr(String key) {
		return sqlSession.selectOne("approval.reWriteAppr",key);
	}

	@Override
	public List<apprCheck> reWriteApprck(String key) {
		return sqlSession.selectList("approval.reWriteApprck",key);
	}

	@Override
	public Attachment reWriteAttach(String key) {
		return sqlSession.selectOne("approval.reWriteAttach",key);
	}

	@Override
	public int getCountApproval(HashMap<Object, Object> params) {
		
		return sqlSession.selectOne("approval.getCountApproval",params);
	}


	

	
	
	
}
