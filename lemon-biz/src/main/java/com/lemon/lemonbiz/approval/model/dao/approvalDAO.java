package com.lemon.lemonbiz.approval.model.dao;

import java.util.List;

import com.lemon.lemonbiz.dept.model.vo.dept;
import com.lemon.lemonbiz.member.model.vo.Member;

public interface approvalDAO {

	List<dept> deptList();

	List<dept> child();

	List<dept> child2();

	List<Member> memberList(String node);

}
