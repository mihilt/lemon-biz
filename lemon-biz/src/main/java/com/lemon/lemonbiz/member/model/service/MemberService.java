package com.lemon.lemonbiz.member.model.service;

import java.util.List;

import com.lemon.lemonbiz.member.model.vo.Dept;
import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.member.model.vo.Rank;

public interface MemberService {

	Member selectOneMember(String memberId);

	int insertMember(Member member);

	List<Dept> selectDeptList();

	List<Rank> selectRankList();

	int updateMember(Member member);

	int updatePassword(Member loginMember);

}
