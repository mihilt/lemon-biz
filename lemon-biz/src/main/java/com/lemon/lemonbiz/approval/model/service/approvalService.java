package com.lemon.lemonbiz.approval.model.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.lemon.lemonbiz.dept.model.vo.dept;


public interface approvalService {

	List<dept> deptList();

	List<dept> child();

	List<dept> child2();

	
}
