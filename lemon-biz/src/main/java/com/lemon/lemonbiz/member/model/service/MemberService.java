package com.lemon.lemonbiz.member.model.service;

import com.lemon.lemonbiz.member.model.vo.Member;

public interface MemberService {

	Member selectOneMember(String memberId);

	int insertMember(Member member);

}
