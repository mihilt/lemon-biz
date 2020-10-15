package com.lemon.lemonbiz.manager.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lemon.lemonbiz.approval.model.vo.DocType;
import com.lemon.lemonbiz.member.model.vo.Dept;
import com.lemon.lemonbiz.member.model.vo.Rank;

@Repository
public class ManagerDAOImpl implements ManagerDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int insertRank(Rank rank) {
		return sqlSession.insert("manager.insertRank", rank);
	}

	@Override
	public int updateRank(Rank rank) {
		return sqlSession.update("manager.updateRank", rank);
	}

	@Override
	public int deleteRank(Rank rank) {
		return sqlSession.delete("manager.deleteRank", rank);
	}

	@Override
	public Dept selectOneDept(Dept dept) {
		return sqlSession.selectOne("manager.selectOneDept", dept);
	}

	@Override
	public Dept selectOneRefDept(Dept dept) {
		return sqlSession.selectOne("manager.selectOneRefDept", dept);
	}

	@Override
	public int insertDept(Dept dept) {
		return sqlSession.insert("manager.insertDept", dept);
	}

	@Override
	public int deleteDept(Dept dept) {
		return sqlSession.delete("manager.deleteDept", dept);
	}

	@Override
	public int updateDept(Dept dept) {
		return sqlSession.update("manager.updateDept", dept);
	}

	@Override
	public int insertApprovalDoc(DocType docType) {
		return sqlSession.update("manager.insertApprovalDoc", docType);
	}

	@Override
	public List<DocType> selectDocTypeList() {
		return sqlSession.selectList("manager.selectDocTypeList");
	}

	@Override
	public DocType selectOneDocType(DocType docType) {
		return sqlSession.selectOne("manager.selectOneDocType",docType);
	}

	@Override
	public int updateApprovalDoc(DocType docType) {
		return sqlSession.update("manager.updateApprovalDoc",docType);
	}

	@Override
	public int deleteApprovalDoc(DocType docType) {
		return sqlSession.delete("manager.deleteApprovalDoc",docType);
	}
	
}