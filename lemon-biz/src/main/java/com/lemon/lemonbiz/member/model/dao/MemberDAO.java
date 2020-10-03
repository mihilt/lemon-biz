package com.lemon.lemonbiz.member.model.dao;

import com.lemon.lemonbiz.member.model.vo.Member;

public interface MemberDAO {

	Member selectOneMember(String memberId);

	int insertMember(String memberId);

}
