<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<!-- favicon -->
<link rel="shortcut icon" href="${pageContext.request.contextPath }/resources/favicon.ico">
<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon/favicon.ico">

<style>
*{
    transition: all 0.6s;
}

html {
    height: 100%;
}

body{
    font-family: 'Lato', sans-serif;
    color: #888;
    margin: 0;
}

#main{
    display: table;
    width: 100%;
    height: 100vh;
    text-align: center;
}

.fof{
	  display: table-cell;
	  vertical-align: middle;
}

.fof h1{
	  font-size: 50px;
	  display: inline-block;
	  padding-right: 12px;
	  animation: type .5s alternate infinite;
}

@keyframes type{
	  from{box-shadow: inset -3px 0px 0px #888;}
	  to{box-shadow: inset -3px 0px 0px transparent;}
}
</style>
<div id="main">
    	<div class="fof">
        		<h1>오류가 있는 페이지 입니다.</h1>
        		<br />
        		<div style="color:red; font-weight:bold; fontsize:25px; cursor:pointer;" onclick="location.href='${ pageContext.request.contextPath }';"><h2>돌아가기</h2></div>
    	</div>
</div>