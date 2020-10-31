package com.lemon.lemonbiz.om.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lemon.lemonbiz.common.vo.Attachment;
import com.lemon.lemonbiz.member.model.vo.Dept;
import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.om.model.vo.OM;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Repository
public class OMDAOImpl implements OMDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<Map<String, Object>> selectOMMapList(int cPage, int numPerPage, Map<String, Object> map, String myId) {
		int startRnum = (cPage - 1) * numPerPage + 1;
		int endRnum = cPage * numPerPage;
		map.put("cPage", cPage);
		map.put("numPerPage", numPerPage);
		map.put("startRnum", startRnum);
		map.put("endRnum", endRnum);
		map.put("myId", myId);
		return sqlSession.selectList("om.selectOMMapList", map);
	}

	@Override
	public List<Map<String, Object>> selectMyOMMapList(int cPage, int numPerPage, Map<String, Object> map,
			String myId) {
		int startRnum = (cPage - 1) * numPerPage + 1;
		int endRnum = cPage * numPerPage;
		map.put("cPage", cPage);
		map.put("numPerPage", numPerPage);
		map.put("startRnum", startRnum);
		map.put("endRnum", endRnum);
		map.put("myId", myId);
		return sqlSession.selectList("om.selectMyOMMapList", map);
	}

	@Override
	public List<Map<String, Object>> selectSelfOMMapList(int cPage, int numPerPage, Map<String, Object> map,
			String myId) {
		int startRnum = (cPage - 1) * numPerPage + 1;
		int endRnum = cPage * numPerPage;
		map.put("cPage", cPage);
		map.put("numPerPage", numPerPage);
		map.put("startRnum", startRnum);
		map.put("endRnum", endRnum);
		map.put("myId", myId);
		return sqlSession.selectList("om.selectSelfOMMapList", map);
	}

	@Override
	public List<OM> selectOMList(Map<String, Object> map) {
		return sqlSession.selectList("om.selectOMList", map);
	}

	@Override
	public int insertOM(OM om, String omrId) {
		om.setOmrId(omrId);
		return sqlSession.insert("om.insertOM", om);
	}

	@Override
	public int insertAttachment(Attachment attach) {
		return sqlSession.insert("om.insertAttachment", attach);
	}

	@Override
	public OM selectOneOM(int key) {
		return sqlSession.selectOne("om.selectOneOM", key);
	}

	@Override
	public List<Attachment> selectAttachList(int key) {
		return sqlSession.selectList("om.selectAttachList", key);
	}

	@Override
	public OM selectOneOMCollection(int key) {
		return sqlSession.selectOne("om.selectOneOMCollection", key);
	}

	@Override
	public Attachment selectOneAttachment(int key) {
		return sqlSession.selectOne("om.selectOneAttachment", key);
	}

	@Override
	public int increaseReadConut(int key) {
		return sqlSession.update("om.increaseReadConut", key);
	}

	@Override
	public int countOM() {
		return sqlSession.selectOne("om.countOM");
	}

	@Override
	public void omfrmDelete(int key) {
		sqlSession.delete("om.omfrmDelete", key);
	}

	@Override
	public void omFileDelete(int key) {
		sqlSession.delete("om.omFileDelete", key);

	}

	@Override
	public List<Map<String, Object>> selectTeamOMMapList(Member loginMember) {
		return sqlSession.selectList("om.selectTeamOMMapList", loginMember);
	}

	@Override
	public int insertTeamOM(OM om) {
		return sqlSession.insert("om.insertTeamOM", om);
	}

	@Override
	public List<Member> omSearch(String searchType, String searchKeyword, Map<String, Object> map) {
		map.put("searchType", searchType);
		map.put("searchKeyword", searchKeyword);
		return sqlSession.selectList("om.omSearch", map);
	}

	/*
	 * @Override public List<Map<String, Object>> selectMaList(int cPage, int
	 * numPerPage, Map<String, Object> map) { int startRnum = (cPage - 1) *
	 * numPerPage + 1; int endRnum = cPage * numPerPage; map.put("cPage", cPage);
	 * map.put("numPerPage", numPerPage); map.put("startRnum", startRnum);
	 * map.put("endRnum", endRnum); return sqlSession.selectList("om.selectMaList",
	 * map); }
	 */

	@Override
	public int insertMaOM(OM om) {
		return sqlSession.insert("om.insertMaOM", om);
	}

	@Override
	public List<OM> omtitleSearch(String searchKeyword) {
		return sqlSession.selectList("om.omtitleSearch", searchKeyword);
	}

	@Override
	public List<OM> omTeamSearch(Member loginMember) {
		return sqlSession.selectList("om.omTeamSearch", loginMember);
	}

	@Override
	public List<OM> omMSearch(String searchKeyword) {
		return sqlSession.selectList("om.omMSearch", searchKeyword);
	}

	@Override
	public int countOM3() {
		return sqlSession.selectOne("om.countOM3");
	}

	@Override
	public String selectTeamName(Member loginMember) {
		return sqlSession.selectOne("om.selectTeamName", loginMember);
	}
	
	// 여기서부터 jstree 관련
	@Override
	public List<Dept> deptList() {
		return sqlSession.selectList("om.selectDeptList");
	}

	@Override
	public List<Dept> child() {
		return sqlSession.selectList("om.selectChild");
	}

	@Override
	public List<Dept> child2() {
		return sqlSession.selectList("om.selectChild2");
	}

	@Override
	public List<Member> memberList(String node) {
		return sqlSession.selectList("om.memberList",node);
	}

	@Override
	public List<Member> selectMember(String param) {
		return sqlSession.selectList("om.selectMember",param);
	}

	@Override
	public List<Member> joinMemberList(String param) {
		return sqlSession.selectList("om.joinMemberList",param);
	}

	@Override
	public String SeqApprKey() {
		return sqlSession.selectOne("om.SeqApprKey");
	}
	
	@Override
	public int getCountNoReadMail(HashMap<Object, Object> params) {
		
		return sqlSession.selectOne("om.getCountNoReadMail", params);
	}

}
