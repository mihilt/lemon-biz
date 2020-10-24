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
        
    	<!-- sb-admin-2 css -->
		<link href="${pageContext.request.contextPath }/resources/css/sb-admin-2.min.css" rel="stylesheet">
		
        
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
        
        
       	<!-- bootstrap -->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
        
        
		<!-- dataTables -->
        <link href="${pageContext.request.contextPath }/resources/css/dataTables.bootstrap4.min.css" rel="stylesheet">
		<script src="${pageContext.request.contextPath }/resources/js/jquery.dataTables.min.js"></script>
		<script src="${pageContext.request.contextPath }/resources/js/dataTables.bootstrap4.min.js"></script>
		<script src="${pageContext.request.contextPath }/resources/js/datatables-demo.js"></script>

        <!-- custom css -->
        <link href="${pageContext.request.contextPath }/resources/css/custom.css" rel="stylesheet">
        
        <!-- calendar -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/css/fullcalendar.min.css" />
		<link rel="stylesheet" href='${pageContext.request.contextPath}/resources/vendor/css/select2.min.css' />
        <link rel="stylesheet" href='${pageContext.request.contextPath}/resources/vendor/css/bootstrap-datetimepicker.min.css' />
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:400,500,600">
		<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
		<script src="${pageContext.request.contextPath}/resources/vendor/js/moment.min.js"></script>
		<script src="${pageContext.request.contextPath}/resources/vendor/js/fullcalendar.min.js"></script>
		<script src="${pageContext.request.contextPath}/resources/vendor/js/ko.js"></script>
		<script src="${pageContext.request.contextPath}/resources/vendor/js/select2.min.js"></script>
		<script src="${pageContext.request.contextPath}/resources/vendor/js/bootstrap-datetimepicker.min.js"></script>	
		<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
		
		<!-- chart -->
		<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	
        <!-- addFlashAttribute message -->
        <c:if test="${ not empty msg }">
            <script>
                alert("${ msg }");
            </script>
        </c:if>
    
    </head>
    <body id="body">