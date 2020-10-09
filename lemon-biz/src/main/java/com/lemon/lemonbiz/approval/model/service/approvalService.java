package com.lemon.lemonbiz.approval.model.service;

import java.util.List;

import org.springframework.stereotype.Service;


import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.member.model.vo.Dept1;



public interface approvalService {

	List<Dept1> deptList();

	List<Dept1> child();

	List<Dept1> child2();

	List<Member> memberList(String node);

	
}
