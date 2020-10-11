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
        
        <!-- jquery -->
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        
        <!-- jstree -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
        
        <!-- favicon -->
        <link rel="shortcut icon" href="${pageContext.request.contextPath }/resources/favicon.ico">
        <link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon/favicon.ico">
        
        <!-- fontawesome -->
        <link href="${pageContext.request.contextPath }/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        
        <!-- sb-admin-2 css -->
        <link href="${pageContext.request.contextPath }/resources/css/sb-admin-2.min.css" rel="stylesheet">
        
       	<!-- bootstrap -->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
        
        <!-- dataTables -->
        <link href="${pageContext.request.contextPath }/resources/css/dataTables.bootstrap4.min.css" rel="stylesheet">
		<script src="${pageContext.request.contextPath }/resources/vendor/jquery-easing/jquery.easing.min.js"></script>
		<script src="${pageContext.request.contextPath }/resources/js/sb-admin-2.min.js"></script>
        
        <!-- custom css -->
        <link href="${pageContext.request.contextPath }/resources/css/custom.css" rel="stylesheet">
        
        <!-- addFlashAttribute message -->
        <c:if test="${ not empty msg }">
            <script>
                alert("${ msg }");
            </script>
        </c:if>
    
    </head>
    <body>