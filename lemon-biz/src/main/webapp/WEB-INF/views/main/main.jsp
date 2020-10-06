<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/sbHeader.jsp"/>

<h6>----------------</h6>
<c:if test = "${ empty loginMember }">
	로그인 세션이 존재하지 않음
</c:if>

<c:if test = "${ not empty loginMember }">
	${ loginMember.memberId }번 사원 로그인
	<button type="button"
            onclick="location.href='${ pageContext.request.contextPath }/member/memberLogout.do';">로그아웃</button>
</c:if>
<h6>----------------</h6>

	<h1>로그인 후 보이는 페이지</h1>
	<h1>로그인 후 보이는 페이지</h1>
	<h1>로그인 후 보이는 페이지</h1>
	<h1>로그인 후 보이는 페이지</h1>
	<h1>로그인 후 보이는 페이지</h1>
	
<h1>사원 등록 테스트</h1>
<h6>입력한 사원번호는 비밀번호와 일치합니다</h6>
<form method="post"
	action="${pageContext.request.contextPath}/member/memberEnroll.do">
	<div>
		<label for="id">사원 번호</label> <input type="text" id="memberId"
			name="memberId" placeholder="사원 번호">
	</div>
	<button type="submit">사원 등록</button>
</form>
	
			 
			 
<h1>ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ</h1>


			 
			 
<jsp:include page="/WEB-INF/views/common/sbFooter.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
