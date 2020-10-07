package com.lemon.lemonbiz.approver.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lemon.lemonbiz.approver.model.dao.ApproverDAO;
import com.lemon.lemonbiz.approver.model.vo.dept;

@Service
public class ApproverServiceImpl implements ApproverService {
	
	@Autowired
	private ApproverDAO approverDAO;

	@Override
	public List<dept> deptList() {
		
		return approverDAO.deptList();
	}

	@Override
	public List<dept> child() {
		
		return approverDAO.child();
	}

	@Override
	public List<dept> child2() {
		return approverDAO.child2();
	}
}
