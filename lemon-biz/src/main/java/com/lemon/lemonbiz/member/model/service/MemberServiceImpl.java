package com.lemon.lemonbiz.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lemon.lemonbiz.member.model.dao.MemberDAO;
import com.lemon.lemonbiz.member.model.vo.Member;


@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDAO memberDAO;

	
	
	@Override
	public int insertMember(String memberId) {
		return memberDAO.insertMember(memberId);
	}

	@Override
	public Member selectOneMember(String memberId) {
		return memberDAO.selectOneMember(memberId);
	}

	
}
