package com.lemon.lemonbiz.om.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.lemon.lemonbiz.common.vo.Attachment;
import com.lemon.lemonbiz.member.model.vo.Dept;
import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.om.model.vo.OM;

public interface OMDAO {

	List<Map<String, Object>> selectOMMapList(int cPage, int numPerPage, Map<String, Object> map, String myId);

	List<Map<String, Object>> selectMyOMMapList(int cPage, int numPerPage, Map<String, Object> map, String myId);
	List<Map<String, Object>> selectMyOMMapListEX(int cPage, int numPerPage, Map<String, Object> map, String myId);
	List<Map<String, Object>> selectMyOMMapListIN(int cPage, int numPerPage, Map<String, Object> map, String myId);

	List<Map<String, Object>> selectSelfOMMapList(int cPage, int numPerPage, Map<String, Object> map, String myId);

	int insertOM(OM om, String omrId);
	
	int insertOME(OM om, String omrId);
	
	int insertOMT(OM om, String omrId);
	
	int insertOMS(OM om, String omrId);

	int insertAttachment(Attachment attach);

	OM selectOneOMCollection(int key);

	OM selectOneOM(int key);

	List<Attachment> selectAttachList(int key);

	Attachment selectOneAttachment(int key);

	int increaseReadConut(int key);

	List<OM> selectOMList(Map<String, Object> map);

	int countOM();

	void omfrmDelete(int key);

	void omFileDelete(int key);

	List<Map<String, Object>> selectTeamOMMapList(Member loginMember);

	int insertTeamOM(OM om);

	List<Member> omSearch(String searchType, String searchKeyword, Map<String, Object> map);

	String selectTeamName(Member loginMember);
	
	// 여기서부터 jstree 관련
	List<Dept> deptList();

	List<Dept> child();

	List<Dept> child2();

	List<Member> memberList(String node);

	List<Member> selectMember(String param);

	List<Member> joinMemberList(String param);

	String SeqApprKey();

	int getCountNoReadMail(HashMap<Object, Object> params);

}
