
package com.lemon.lemonbiz.om.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lemon.lemonbiz.common.vo.Attachment;
import com.lemon.lemonbiz.member.model.service.MemberService;
import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.notice.model.service.NoticeService;
import com.lemon.lemonbiz.notice.model.vo.Notice;
import com.lemon.lemonbiz.om.model.dao.OMDAO;
import com.lemon.lemonbiz.om.model.vo.OM;

@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = Exception.class)
@Service
public class OMServiceImpl implements OMService {

	@Autowired
	private OMDAO omDAO;

	@Autowired
	private MemberService memberService;

	@Autowired
	private NoticeService noticeService;

	@Override
	public List<Map<String, Object>> selectOMMapList(int cPage, int numPerPage, Map<String, Object> map, String myId) {
		return omDAO.selectOMMapList(cPage, numPerPage, map, myId);
	}

	@Override
	public List<Map<String, Object>> selectMyOMMapList(int cPage, int numPerPage, Map<String, Object> map,
			String myId) {
		return omDAO.selectMyOMMapList(cPage, numPerPage, map, myId);
	}

	@Override
	public List<Map<String, Object>> selectSelfOMMapList(int cPage, int numPerPage, Map<String, Object> map,
			String myId) {
		return omDAO.selectSelfOMMapList(cPage, numPerPage, map, myId);
	}

	@Override
	public List<OM> selectOMList(Map<String, Object> map) {
		return omDAO.selectOMList(map);
	}

	@Override
	public int insertOM(OM om, String omrId) {
		int result = 0;
		// 1. om insert
		result = omDAO.insertOM(om, omrId);

		// 2. attachment insert
		if (om.getAttachList() != null) {

			for (Attachment attach : om.getAttachList()) {
				// 생성된 omNo값 대입하기
				attach.setMailKey(om.getKey());
				result = omDAO.insertAttachment(attach);
			}

		}
		return result;
	}

	@Transactional(readOnly = true)
	@Override
	public OM selectOneOM(int key) {
		// 1. om테이블 조회
		OM om = omDAO.selectOneOM(key);

		// 2. attachment 테이블 조회
		List<Attachment> attachList = omDAO.selectAttachList(key);
		om.setAttachList(attachList);

		return om;
	}

	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public OM selectOneOMCollection(int key) {
		int result = omDAO.increaseReadConut(key);
		return omDAO.selectOneOMCollection(key);
	}

	@Override
	public Attachment selectOneAttachment(int key) {
		return omDAO.selectOneAttachment(key);
	}

	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public OM selectOneOMCollection(int key, boolean hasRead) {

		if (hasRead == false) {
			int result = omDAO.increaseReadConut(key);
		}
		return omDAO.selectOneOMCollection(key);
	}

	@Override
	public int countOM() {
		return omDAO.countOM();
	}

	@Override
	public void omfrmDelete(int key) {
		omDAO.omfrmDelete(key);
	}

	@Override
	public void omFileDelete(int key) {
		omDAO.omFileDelete(key);

	}

	@Override
	public List<Map<String, Object>> selectTeamOMMapList(Member loginMember) {
		return omDAO.selectTeamOMMapList(loginMember);
	}

	@Override
	public int insertTeamOM(OM om) {

		int result = 0;
		// 1. om insert
		result = omDAO.insertTeamOM(om);

		// 2. attachment insert
		if (om.getAttachList() != null) {

			for (Attachment attach : om.getAttachList()) {
				// 생성된 omNo값 대입하기
				attach.setMailKey(om.getKey());
				result = omDAO.insertAttachment(attach);
			}

		}
		return result;
	}

	@Override
	public List<Member> omSearch(String searchType, String searchKeyword, Map<String, Object> map) {
		return omDAO.omSearch(searchType, searchKeyword, map);
	}

	@Override
	public int insertMaOM(OM om) {

		int result = 0;
		// 1. om insert
		result = omDAO.insertMaOM(om);

		// 2. attachment insert
		if (om.getAttachList() != null) {

			for (Attachment attach : om.getAttachList()) {
				// 생성된 omNo값 대입하기
				attach.setMailKey(om.getKey());
				result = omDAO.insertAttachment(attach);
			}

		}

		// 전체 회원 단체 알림 등록
		List<Member> memberList = memberService.selectMemberList();
		List<Notice> groupNoticeList = new ArrayList<Notice>();

		for (Member sameDeptMember : memberList) {
			Notice groupNotice = new Notice();
			groupNotice.setContent("새로운 공지사항 " + "\"" + om.getTitle() + "\"" + " 등록되었습니다.");
			groupNotice.setAddress("/om/omMaList.do");
			groupNotice.setIcon("fa-exclamation");
			groupNotice.setColor("danger");
			groupNotice.setMemId(sameDeptMember.getMemberId());

			groupNoticeList.add(groupNotice);
		}

		noticeService.insertNoticeList(groupNoticeList);

		return result;
	}

	@Override
	public List<OM> omtitleSearch(String searchKeyword) {
		return omDAO.omtitleSearch(searchKeyword);
	}

	@Override
	public List<OM> omMSearch(String searchKeyword) {
		return omDAO.omMSearch(searchKeyword);
	}

	@Override
	public int countOM3() {
		return omDAO.countOM3();
	}

	@Override
	public String selectTeamName(Member loginMember) {
		return omDAO.selectTeamName(loginMember);
	}
	
	@Override
	public int getCountNoReadMail(HashMap<Object, Object> params) {
		
		return omDAO.getCountNoReadMail(params);
	}

}
