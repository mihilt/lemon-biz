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
	public List<Map<String, Object>> selectMyOMMapListEX(int cPage, int numPerPage, Map<String, Object> map,
			String myId) {
		int startRnum = (cPage - 1) * numPerPage + 1;
		int endRnum = cPage * numPerPage;
		map.put("cPage", cPage);
		map.put("numPerPage", numPerPage);
		map.put("startRnum", startRnum);
		map.put("endRnum", endRnum);
		map.put("myId", myId);
		return sqlSession.selectList("om.selectMyOMMapListEX", map);
	}
	@Override
	public List<Map<String, Object>> selectMyOMMapListIN(int cPage, int numPerPage, Map<String, Object> map,
			String myId) {
		int startRnum = (cPage - 1) * numPerPage + 1;
		int endRnum = cPage * numPerPage;
		map.put("cPage", cPage);
		map.put("numPerPage", numPerPage);
		map.put("startRnum", startRnum);
		map.put("endRnum", endRnum);
		map.put("myId", myId);
		return sqlSession.selectList("om.selectMyOMMapListIN", map);
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
	public List<Map<String, Object>> selectTeamOMMapList(int cPage, int numPerPage, Map<String, Object> map, Member loginMember) {
		String myId = loginMember.getMemberId();
		String deptKey = Integer.toString(loginMember.getDeptKey());
		int startRnum = (cPage - 1) * numPerPage + 1;
		int endRnum = cPage * numPerPage;
		map.put("cPage", cPage);
		map.put("numPerPage", numPerPage);
		map.put("startRnum", startRnum);
		map.put("endRnum", endRnum);
		map.put("myId", myId);
		map.put("deptKey", deptKey);
		return sqlSession.selectList("om.selectTeamOMMapList", map);
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
	public int insertOME(OM om, String omrId) {
		om.setOmrId(omrId);
		return sqlSession.insert("om.insertOME", om);
	}
	
	@Override
	public int insertOMES(OM om, String omrId) {
		om.setOmrId(omrId);
		return sqlSession.insert("om.insertOMES", om);
	}
	
	@Override
	public int insertOMT(OM om, String omrId) {
		om.setOmrId(omrId);
		return sqlSession.insert("om.insertOMT", om);
	}
	
	@Override
	public int insertOMS(OM om, String omrId) {
		om.setOmrId(omrId);
		return sqlSession.insert("om.insertOMS", om);
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
	public int insertTeamOM(OM om) {
		return sqlSession.insert("om.insertTeamOM", om);
	}

	@Override
	public List<Member> omSearch(String searchType, String searchKeyword, Map<String, Object> map) {
		map.put("searchType", searchType);
		map.put("searchKeyword", searchKeyword);
		return sqlSession.selectList("om.omSearch", map);
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

	@Override
	public int countAll(String myId) {
		return sqlSession.selectOne("om.countAll", myId);
	}

	@Override
	public int countTeam(String myId, String myDeptKey, Map<String, Object> mapTeam) {
		mapTeam.put("myId", myId);
		mapTeam.put("myDeptKey", myDeptKey);
		return sqlSession.selectOne("om.countTeam", mapTeam);
	}

	@Override
	public int countAtt(String myId) {
		return sqlSession.selectOne("om.countAtt", myId);
	}

	@Override
	public int countSelf(String myId) {
		return sqlSession.selectOne("om.countSelf", myId);
	}

	@Override
	public int countMy(String myId) {
		return sqlSession.selectOne("om.countMy", myId);
	}

	@Override
	public int countMyEx(String myId) {
		return sqlSession.selectOne("om.countMyEx", myId);
	}

	@Override
	public int countMyIn(String myId) {
		return sqlSession.selectOne("om.countMyIn", myId);
	}

}
