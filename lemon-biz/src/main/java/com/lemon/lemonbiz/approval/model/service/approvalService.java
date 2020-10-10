package com.lemon.lemonbiz.approval.model.service;

import java.util.List;

import org.springframework.stereotype.Service;


import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.member.model.vo.Dept;



public interface approvalService {

	List<Dept> deptList();

	List<Dept> child();

	List<Dept> child2();

	List<Member> memberList(String node);

	List<Member> selectMember(String param);

	
}
