package com.lemon.lemonbiz.approver.model.dao;

import java.util.List;

import com.lemon.lemonbiz.approver.model.vo.dept;

public interface ApproverDAO {

	List<dept> deptList();

	List<dept> child();

	List<dept> child2();

}
