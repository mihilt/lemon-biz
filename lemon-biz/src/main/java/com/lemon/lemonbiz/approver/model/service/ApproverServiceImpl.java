package com.lemon.lemonbiz.approver.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lemon.lemonbiz.approver.model.dao.ApproverDAO;

@Service
public class ApproverServiceImpl implements ApproverService {
	
	@Autowired
	private ApproverDAO approverDAO;
}
