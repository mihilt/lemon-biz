package com.lemon.lemonbiz.approvel.model.dao;

import java.util.List;

import com.lemon.lemonbiz.dept.model.vo.dept;

public interface ApprovelDAO {

	List<dept> deptList();

	List<dept> child();

	List<dept> child2();

}
