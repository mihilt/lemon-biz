package com.lemon.lemonbiz.approval.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lemon.lemonbiz.approval.model.dao.approvalDAO;
import com.lemon.lemonbiz.dept.model.vo.dept;

@Service
public class approvalServiceImpl implements approvalService {
	
	@Autowired
	private approvalDAO approvalDAO;

	@Override
	public List<dept> deptList() {
		
		return approvalDAO.deptList();
	}

	@Override
	public List<dept> child() {
		
		return approvalDAO.child();
	}

	@Override
	public List<dept> child2() {
		return approvalDAO.child2();
	}
}
