package com.lemon.lemonbiz.member.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lemon.lemonbiz.member.model.vo.Dept;
import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.member.model.vo.Rank;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int insertMember(Member member) {
		return sqlSession.insert("member.insertMember", member);
	}

	@Override
	public Member selectOneMember(String memberId) {
		return sqlSession.selectOne("member.selectOneMember", memberId);
	}
	
	@Override
	public List<Dept> selectDeptList() {
		return sqlSession.selectList("member.selectDeptList");
	}

	@Override
	public List<Rank> selectRankList() {
		return sqlSession.selectList("member.selectRankList");
	}

	@Override
	public int updateMember(Member member) {
		return sqlSession.update("member.updateMember", member);
	}

	@Override
	public int updatePassword(Member loginMember) {
		return sqlSession.update("member.updatePassword", loginMember);
	}

	@Override
	public List<Member> selectMemberList() {
		return sqlSession.selectList("member.selectMemberList");
	}

	@Override
	public int deleteMember(Member member) {
		return sqlSession.delete("member.deleteMember", member);
	}

	@Override
	public List<Member> selectMemberListWithDeptKey(int deptKey) {
		return sqlSession.selectList("member.selectMemberListWithDeptKey", deptKey);
	}

}
