package com.lemon.lemonbiz.approval.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.approval.model.vo.Appr;
import com.lemon.lemonbiz.approval.model.vo.ApprCheck;
import com.lemon.lemonbiz.approval.model.vo.Approval;
import com.lemon.lemonbiz.approval.model.vo.DocType;
import com.lemon.lemonbiz.common.vo.Attachment;
import com.lemon.lemonbiz.member.model.vo.Dept;


@Repository
public class ApprovalDAOImpl implements ApprovalDAO {

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
	public int insertSaveApproval(Appr appr) {
		return sqlSession.insert("approval.insertSaveApproval",appr);
	}

	@Override
	public int insertSaveAttachment(Attachment attach) {
		return sqlSession.insert("approval.insertSavaAttachment",attach);
	}

	@Override
	public int insertSaveApprck1(ApprCheck apprck1) {
		return sqlSession.insert("approval.insertSaveApprck1",apprck1);
	}

	@Override
	public int insertSaveApprck2(ApprCheck apprck2) {
		return sqlSession.insert("approval.insertSaveApprck2",apprck2);
	}

	@Override
	public int insertSaveApprck3(ApprCheck apprck3) {
		return sqlSession.insert("approval.insertSaveApprck3",apprck3);
	}

	@Override
	public List<Appr> approvalList(String memberId) {
		return sqlSession.selectList("approval.approvalList",memberId);
	}

	@Override
	public Appr reWriteAppr(String key) {
		return sqlSession.selectOne("approval.reWriteAppr",key);
	}

	@Override
	public List<ApprCheck> reWriteApprck(String key) {
		return sqlSession.selectList("approval.reWriteApprck",key);
	}
	
	@Override
	public Attachment reWriteAttach(String key) {
		return sqlSession.selectOne("approval.reWriteAttach",key);
	}
	

	@Override
	public int insertApproval(Appr appr) {
		return sqlSession.insert("approval.insertApproval",appr);
	}
	
	@Override
	public int updateApproval(Appr appr) {
		return sqlSession.update("approval.updateApproval",appr);
	}

	@Override
	public int updateApprck1(ApprCheck apprck1) {
		return sqlSession.update("approval.updateApprck1",apprck1);
	}

	@Override
	public int updateApprck2(ApprCheck apprck2) {
		return sqlSession.update("approval.updateApprck2",apprck2);
	}

	@Override
	public int updateApprck3(ApprCheck apprck3) {
		return sqlSession.update("approval.updateApprck3",apprck3);
	}

	@Override
	public List<ApprCheck> apprckList(String memberId) {
		return sqlSession.selectList("approval.apprckList",memberId);
	}

	@Override
	public List<Appr> apprAndCkList(Member loginMember) {
		return sqlSession.selectList("approval.apprAndCkList",loginMember);
	}

	@Override
	public Appr apprckDetail(int ckKey) {
		return sqlSession.selectOne("approval.apprckDetail",ckKey);
	}

	@Override
	public Attachment selectOneAttachment(String key) {
		return sqlSession.selectOne("approval.selectOneAttachment",key);
	}

	@Override
	public ApprCheck selectcApprck(Map<String, String> map) {
		return sqlSession.selectOne("approval.selectcApprck",map);
	}

	@Override
	public int changeApprck(int key) {
		return sqlSession.update("approval.changeApprck",key);
	}

	@Override
	public int backApprck(int key) {
		return sqlSession.update("approval.backApprck",key);
	}

	@Override
	public List<Appr> myApprovalList(String memberId) {
		return sqlSession.selectList("approval.myApprovalList",memberId);
	}

	@Override
	public DocType selectOneDocTypeAjax(DocType docType) {
		return sqlSession.selectOne("approval.selectOneDocTypeAjax",docType);
	}

	@Override
	public List<DocType> selectDocTypeTitleList() {
		return sqlSession.selectList("approval.selectDocTypeTitleList");
	}

	@Override
	public int selectOneApprCheckKey(Map<String, Object> map) {
		return sqlSession.selectOne("approval.selectOneApprCheckKey", map);
	}

	
	
	
	
	
	
	
}
