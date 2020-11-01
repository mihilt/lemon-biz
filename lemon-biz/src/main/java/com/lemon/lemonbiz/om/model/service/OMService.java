package com.lemon.lemonbiz.om.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.lemon.lemonbiz.common.vo.Attachment;
import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.om.model.vo.OM;

public interface OMService {

	List<Map<String, Object>> selectOMMapList(int cPage, int numPerPage, Map<String, Object> map, String myId);

	List<Map<String, Object>> selectMyOMMapList(int cPage, int numPerPage, Map<String, Object> map, String myId);
	List<Map<String, Object>> selectMyOMMapListEX(int cPage, int numPerPage, Map<String, Object> map, String myId);
	List<Map<String, Object>> selectMyOMMapListIN(int cPage, int numPerPage, Map<String, Object> map, String myId);
	List<Map<String, Object>> selectTeamOMMapList(int cPage, int numPerPage, Map<String, Object> map, Member loginMember);

	List<Map<String, Object>> selectSelfOMMapList(int cPage, int numPerPage, Map<String, Object> map, String myId);

	// 사내메일로만 발송하는 경우
	int insertOM(OM om, String omrId);
	
	// 외부 메일로도 발송하는 경우
	int insertOME(OM om, String omrId);
	
	// 임시 저장하는 경우
	int insertOMT(OM om, String omrId);
	
	// 중요 메일로 발송하는 경우
	int insertOMS(OM om, String omrId);
	
	// 외부 메일로 발송하며 동시에 중요 메일로 설정하는 경우
	int insertOMES(OM om, String omrId);

	OM selectOneOMCollection(int key);

	OM selectOneOM(int key);

	Attachment selectOneAttachment(int key);

	OM selectOneOMCollection(int key, boolean hasRead);

	int countAll(String myId);
	int countTeam(String myId, String myDeptKey, Map<String, Object> mapTeam);
	int countAtt(String myId);
	int countSelf(String myId);
	int countMy(String myId);
	int countMyEx(String myId);
	int countMyIn(String myId);

	List<OM> selectOMList(Map<String, Object> map);

	void omfrmDelete(int key);

	void omFileDelete(int key);


	int insertTeamOM(OM om);

	String selectTeamName(Member loginMember);

	int getCountNoReadMail(HashMap<Object, Object> params);

}
