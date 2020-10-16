package com.lemon.lemonbiz.member.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.lemon.lemonbiz.member.model.dao.MemberDAO;
import com.lemon.lemonbiz.member.model.vo.Dept;
import com.lemon.lemonbiz.member.model.vo.Member;
import com.lemon.lemonbiz.member.model.vo.Rank;
import com.lemon.lemonbiz.notice.model.service.NoticeService;
import com.lemon.lemonbiz.notice.model.vo.Notice;

@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = Exception.class)

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDAO memberDAO;

	@Autowired
	private NoticeService noticeService;

	@Autowired
	private MemberService memberService;

	@Override
	public int insertMember(Member member) {
		int insertMemberResult = memberDAO.insertMember(member);

		// 개인 알림 등록
		Notice notice = new Notice();
		notice.setMemId(member.getMemberId());
		notice.setContent("입사를 환영합니다!<br>마이페이지에서 프로필 사진 업로드와, 추가 정보를 입력해주세요.");
		notice.setAddress("/member/myPage.do");
		notice.setIcon("fa-laugh-beam");
		notice.setColor("success");
		noticeService.insertNotice(notice);

		notice.setMemId(member.getMemberId());
		notice.setContent("입사를 환영합니다!<br>비밀번호를 변경 해주세요.");
		notice.setAddress("/member/updatePassword.do");
		noticeService.insertNotice(notice);

		// member deptName, rankName 불러오기
		member = memberService.selectOneMember(member.getMemberId());

		// 단체 알림 등록
		List<Member> memberList = memberService.selectMemberListWithDeptKey(member.getDeptKey());
		Notice groupNotice = new Notice();
		groupNotice.setContent(
				member.getDeptName() + " 부서에 " + member.getRankName() + " 직급의 " + member.getName() + " 사원이 추가되었습니다.");
		groupNotice.setAddress("/notice/noticeList.do");
		groupNotice.setIcon("fa-user-plus");
		groupNotice.setColor("info");
		for (Member sameDeptMember : memberList) {
			groupNotice.setMemId(sameDeptMember.getMemberId());
			noticeService.insertNotice(groupNotice);
		}

		return insertMemberResult;
	}

	@Override
	public Member selectOneMember(String memberId) {
		return memberDAO.selectOneMember(memberId);
	}

	@Override
	public List<Dept> selectDeptList() {
		return memberDAO.selectDeptList();
	}

	@Override
	public List<Rank> selectRankList() {
		return memberDAO.selectRankList();
	}

	@Override
	public int updateMember(Member member) {
		return memberDAO.updateMember(member);
	}

	@Override
	public int updatePassword(Member loginMember) {
		return memberDAO.updatePassword(loginMember);
	}

	@Override
	public List<Member> selectMemberList() {
		return memberDAO.selectMemberList();
	}

	@Override
	public int deleteMember(Member member) {
		return memberDAO.deleteMember(member);
	}

	@Override
	public List<Member> selectMemberListWithDeptKey(int deptKey) {
		return memberDAO.selectMemberListWithDeptKey(deptKey);
	}

}
