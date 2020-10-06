<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html lang="ko">
	<head>
		<meta charset="UTF-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<title>Lemon Biz</title>
		
		<!-- favicon -->
		<link rel="shortcut icon" href="${pageContext.request.contextPath }/resources/favicon.ico">
		<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon/favicon.ico">
		
		<!-- fontawesome -->
		<link href="${pageContext.request.contextPath }/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
		
		<!-- sb-admin-2 css -->
		<link href="${pageContext.request.contextPath }/resources/css/sb-admin-2.min.css" rel="stylesheet">

		<!-- addFlashAttribute message -->
		<c:if test="${ not empty msg }">
			<script>
				alert("${ msg }");
			</script>
		</c:if>
	
	</head>
	<body>