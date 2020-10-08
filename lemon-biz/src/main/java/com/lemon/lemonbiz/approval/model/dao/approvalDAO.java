package com.lemon.lemonbiz.approval.model.dao;

import java.util.List;

import com.lemon.lemonbiz.dept.model.vo.dept;

public interface approvalDAO {

	List<dept> deptList();

	List<dept> child();

	List<dept> child2();

}
