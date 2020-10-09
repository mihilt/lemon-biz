package com.lemon.lemonbiz.approval.model.dao;

import java.util.List;


import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.member.model.vo.Dept1;


public interface approvalDAO {

	List<Dept1> deptList();

	List<Dept1> child();

	List<Dept1> child2();

	List<Member> memberList(String node);

}
