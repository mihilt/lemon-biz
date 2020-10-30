package com.lemon.lemonbiz.om.model.service;

import java.util.List;
import java.util.Map;

import com.lemon.lemonbiz.common.vo.Attachment;
import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.om.model.vo.OM;

public interface OMService {

	List<Map<String, Object>> selectOMMapList(int cPage, int numPerPage, Map<String, Object> map, String myId);

	List<Map<String, Object>> selectMyOMMapList(int cPage, int numPerPage, Map<String, Object> map, String myId);

	List<Map<String, Object>> selectSelfOMMapList(int cPage, int numPerPage, Map<String, Object> map, String myId);

	// 사내메일로만 발송하는 경우
	int insertOM(OM om, String omrId);
	
	// 외부 메일로도 발송하는 경우
	int insertOME(OM om, String omrId);
	
	// 임시 저장하는 경우
	int insertOMT(OM om, String omrId);

	OM selectOneOMCollection(int key);

	OM selectOneOM(int key);

	Attachment selectOneAttachment(int key);

	OM selectOneOMCollection(int key, boolean hasRead);

	int countOM();

	List<OM> selectOMList(Map<String, Object> map);

	void omfrmDelete(int key);

	void omFileDelete(int key);

	List<Map<String, Object>> selectTeamOMMapList(Member loginMember);

	int insertTeamOM(OM om);

	List<Member> omSearch(String searchType, String searchKeyword, Map<String, Object> map);

	int insertMaOM(OM om);

	List<OM> omtitleSearch(String searchKeyword);

	List<OM> omMSearch(String searchKeyword);

	int countOM3();

	String selectTeamName(Member loginMember);

	

}
