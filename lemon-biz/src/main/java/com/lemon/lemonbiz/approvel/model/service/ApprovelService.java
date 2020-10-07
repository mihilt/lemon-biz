package com.lemon.lemonbiz.approvel.model.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.lemon.lemonbiz.dept.model.vo.dept;


public interface ApprovelService {

	List<dept> deptList();

	List<dept> child();

	List<dept> child2();

	
}
