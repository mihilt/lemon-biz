package com.lemon.lemonbiz.approval.model.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.lemon.lemonbiz.dept.model.vo.dept;
import com.lemon.lemonbiz.member.model.vo.Member;


public interface approvalService {

	List<dept> deptList();

	List<dept> child();

	List<dept> child2();

	List<Member> memberList(String node);

	
}
