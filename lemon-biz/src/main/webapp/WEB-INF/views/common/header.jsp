<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8" />
	<title>Lemon Biz</title>
	
	<!-- favicon -->
	<link rel="shortcut icon" href="${pageContext.request.contextPath }/resources/favicon.ico">
	<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon/favicon.ico">
	
	<!-- addFlashAttribute message -->
	<c:if test="${ not empty msg }">
		<script>
			alert("${ msg }");
		</script>
	</c:if>

</head>
<body>

<h6>-----Header-----</h6>
<c:if test = "${ empty loginMember }">
	로그인 세션이 존재하지 않음
</c:if>

<c:if test = "${ not empty loginMember }">
	${ loginMember.memberId }번 사원 로그인
	<button type="button"
            onclick="location.href='${ pageContext.request.contextPath }/member/memberLogout.do';">로그아웃</button>
</c:if>
<h6>----------------</h6>