<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/sbHeader.jsp" />

<h1>사원 등록</h1>
<h6 class="text-danger">*생성한 사원의 초기 비밀번호는 사원번호와 동일합니다</h6>
<form method="post"
	action="${pageContext.request.contextPath}/member/memberEnroll.do">
	<div>
		<input type="text" id="memberId" name="memberId" placeholder="사원 번호">
		<button class="btn bg-warning text-white font-weight-bold" type="submit">사원 등록</button>
	</div>
</form>

<jsp:include page="/WEB-INF/views/common/sbFooter.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
