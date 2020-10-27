package com.lemon.lemonbiz.om.model.dao;

import java.util.List;
import java.util.Map;

import com.lemon.lemonbiz.common.vo.Attachment;
import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.om.model.vo.OM;
import com.lemon.lemonbiz.om.model.vo.OMComment;

public interface OMDAO {

	List<Map<String, Object>> selectOMMapList(int cPage, int numPerPage, Map<String, Object> map, String myId);

	List<Map<String, Object>> selectMyOMMapList(int cPage, int numPerPage, Map<String, Object> map, String myId);

	List<Map<String, Object>> selectSelfOMMapList(int cPage, int numPerPage, Map<String, Object> map, String myId);

	int insertOM(OM om);

	int insertAttachment(Attachment attach);

	OM selectOneOMCollection(int key);

	OM selectOneOM(int key);

	List<Attachment> selectAttachList(int key);

	Attachment selectOneAttachment(int key);

	int increaseReadConut(int key);

	List<OM> selectOMList(Map<String, Object> map);

	int countOM();

	void omInsert(OMComment omComment);

	void omfrmDelete(int key);

	void omFileDelete(int key);

	List<Map<String, Object>> selectTeamOMMapList(Member loginMember);

	int insertTeamOM(OM om);

	List<Member> omSearch(String searchType, String searchKeyword, Map<String, Object> map);

	int insertMaOM(OM om);

	List<OM> omtitleSearch(String searchKeyword);

	List<OM> omTeamSearch(Member loginMember);

	List<OM> omMSearch(String searchKeyword);

	int countOM3();

	String selectTeamName(Member loginMember);

}
