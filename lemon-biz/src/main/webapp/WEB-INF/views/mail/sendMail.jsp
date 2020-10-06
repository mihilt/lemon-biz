<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<fmt:requestEncoding value="utf-8" /> <!-- 한글깨짐 방지  -->
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/sbHeader.jsp"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 
<!-- Bootstrap -->
<link href='<c:url value="/css/bootstrap.min.css" />' rel="stylesheet">
<link href='<c:url value="/css/kfonts2.css" />' rel="stylesheet">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src='<c:url value="/jquery/jquery-1.11.3.min.js" />'></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src='<c:url value="/js/bootstrap.min.js"  />'></script>
<title>업무 메일 작성</title>

</head>

<body>
<div class="container">
  <h5>메일 작성</h5>
  <form action="${pageContext.request.contextPath}/mail/mailSend" method="post">
   <div align="center"><!-- 받는 사람 이메일 -->
      <input type="text" name="mFrom" size="120" style="width:100%" placeholder="내 이메일" class="form-control" >
    </div>   
    <div align="center"><!-- 받는 사람 이메일 -->
      <input type="text" name="mTo" size="120" style="width:100%" placeholder="상대의 이메일" class="form-control" >
    </div>     
    <div align="center"><!-- 제목 -->
      <input type="text" name="title" size="120" style="width:100%" placeholder="제목을 입력해주세요" class="form-control" >
    </div>
    <p>
    <div align="center"><!-- 내용 --> 
      <textarea id="summernote" class="summer-content" name="content" cols="120" rows="12" 
      			style="width:100%; height: 50em; resize:none" placeholder="내용" class="form-control"></textarea>
    </div>
    <p>
    <div align="center">
      <input type="submit" value="메일 보내기" class="btn btn-warning">
    </div>
  </form>
</div>
</body>
<script>
$(document).ready(function() { 
	$('#summernote').summernote(); 
	});
</script>
</html> 


<jsp:include page="/WEB-INF/views/common/sbFooter.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>