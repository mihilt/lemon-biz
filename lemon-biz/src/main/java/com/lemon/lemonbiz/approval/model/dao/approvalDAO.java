package com.lemon.lemonbiz.approval.model.dao;

import java.util.List;


import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.member.model.vo.Dept;


public interface approvalDAO {

	List<Dept> deptList();

	List<Dept> child();

	List<Dept> child2();

	List<Member> memberList(String node);

	List<Member> selectMember(String param);

}
