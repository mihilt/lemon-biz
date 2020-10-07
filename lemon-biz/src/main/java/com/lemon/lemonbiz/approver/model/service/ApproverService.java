package com.lemon.lemonbiz.approver.model.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.lemon.lemonbiz.approver.model.vo.dept;


public interface ApproverService {

	List<dept> deptList();

	List<dept> child();

	List<dept> child2();

	
}
