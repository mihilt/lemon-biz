package com.lemon.lemonbiz.manager.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lemon.lemonbiz.approval.model.vo.DocType;
import com.lemon.lemonbiz.manager.model.dao.ManagerDAO;
import com.lemon.lemonbiz.member.model.vo.Dept;
import com.lemon.lemonbiz.member.model.vo.Rank;

@Service
public class ManagerServiceImpl implements ManagerService{

	@Autowired
	private ManagerDAO managerDAO;
	
	@Override
	public int insertRank(Rank rank) {
		return managerDAO.insertRank(rank);
	}

	@Override
	public int updateRank(Rank rank) {
		return managerDAO.updateRank(rank);
	}

	@Override
	public int deleteRank(Rank rank) {
		return managerDAO.deleteRank(rank);
	}

	@Override
	public Dept selectOneDept(Dept dept) {
		return managerDAO.selectOneDept(dept);
	}

	@Override
	public Dept selectOneRefDept(Dept dept) {
		return managerDAO.selectOneRefDept(dept);
	}

	@Override
	public int insertDept(Dept dept) {
		return managerDAO.insertDept(dept);
	}

	@Override
	public int deleteDept(Dept dept) {
		return managerDAO.deleteDept(dept);
	}

	@Override
	public int updateDept(Dept dept) {
		return managerDAO.updateDept(dept);
	}

	@Override
	public int insertApprovalDoc(DocType docType) {
		return managerDAO.insertApprovalDoc(docType);
	}

	@Override
	public List<DocType> selectDocTypeList() {
		return managerDAO.selectDocTypeList();
	}

	@Override
	public DocType selectOneDocType(DocType docType) {
		return managerDAO.selectOneDocType(docType);
	}

	@Override
	public int updateApprovalDoc(DocType docType) {
		return managerDAO.updateApprovalDoc(docType);
	}

	@Override
	public int deleteApprovalDoc(DocType docType) {
		return managerDAO.deleteApprovalDoc(docType);
	}

}