package com.lemon.lemonbiz.manager.model.service;

import java.util.List;

import com.lemon.lemonbiz.approval.model.vo.DocType;
import com.lemon.lemonbiz.member.model.vo.Dept;
import com.lemon.lemonbiz.member.model.vo.Rank;

public interface ManagerService {

	int insertRank(Rank rank);

	int updateRank(Rank rank);

	int deleteRank(Rank rank);

	Dept selectOneDept(Dept dept);

	Dept selectOneRefDept(Dept dept);

	int insertDept(Dept dept);

	int deleteDept(Dept dept);

	int updateDept(Dept dept);

	int insertApprovalDoc(DocType docType);

	List<DocType> selectDocTypeList();

	DocType selectOneDocType(DocType docType);

	int updateApprovalDoc(DocType docType);

	int deleteApprovalDoc(DocType docType);

}