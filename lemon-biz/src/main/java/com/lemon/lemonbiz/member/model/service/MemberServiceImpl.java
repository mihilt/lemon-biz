package com.lemon.lemonbiz.member.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lemon.lemonbiz.manager.model.dao.ManagerDAO;
import com.lemon.lemonbiz.member.model.dao.MemberDAO;
import com.lemon.lemonbiz.member.model.vo.Dept1;
import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.member.model.vo.Rank;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDAO memberDAO;
	
	@Override
	public int insertMember(Member member) {
		return memberDAO.insertMember(member);
	}

	@Override
	public Member selectOneMember(String memberId) {
		return memberDAO.selectOneMember(memberId);
	}

	@Override
	public List<Dept1> selectDeptList() {
		return memberDAO.selectDeptList();
	}

	@Override
	public List<Rank> selectRankList() {
		return memberDAO.selectRankList();
	}

	@Override
	public int updateMember(Member member) {
		return memberDAO.updateMember(member);
	}

	@Override
	public int updatePassword(Member loginMember) {
		return memberDAO.updatePassword(loginMember);
	}

}
