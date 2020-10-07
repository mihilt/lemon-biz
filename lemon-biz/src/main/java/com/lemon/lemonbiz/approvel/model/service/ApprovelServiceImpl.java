package com.lemon.lemonbiz.approvel.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lemon.lemonbiz.approvel.model.dao.ApprovelDAO;
import com.lemon.lemonbiz.dept.model.vo.dept;

@Service
public class ApprovelServiceImpl implements ApprovelService {
	
	@Autowired
	private ApprovelDAO approverDAO;

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
