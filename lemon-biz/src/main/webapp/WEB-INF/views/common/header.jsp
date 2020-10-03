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

<h1>Header</h1>