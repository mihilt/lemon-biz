<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="title"/>
</jsp:include>
<style>
/*글쓰기버튼*/
button#btn-leabe{float:right; margin:0 15px;}
button#btn-arrive{float:right; margin: 0 0 15px;}
</style>

<section id="attend-container" class="container">
	<button id="btn-test" class="btn" type="button" onclick="attendtest();">테스트</button>
	 <form id="form1" class="form-inline" method="post"
		action="${pageContext.request.contextPath }/attend/attendLeabe.do" >
		<input type="hidden" value="${loginMember.memberId }" class="form-control col-sm-5" name="memberId" required/>&nbsp;
	 </form>
	 
	<div>
		<button id="btn-leabe" class="btn btn-outline-warning" type="button" onclick="attendLeabe();">퇴근</button>&nbsp;
	 	<button id="btn-arrive" class="btn btn-outline-warning" type="button" onclick="attendArrive();">출근</button>
	</div>


<!-- 	<input type="button" value="퇴근" id="btn-add" class="btn btn-outline-warning" onclick="attendLeabe();"/>
	<input type="button" value="출근" id="btn-add2" class="btn btn-outline-warning" onclick="attendArrive();"/> -->




	<table id="tbl-attend" class="table ">
	<thead class="bg-warning">

		<tr>
			<th>날짜</th>
			<th>출근시간</th>
			<th>퇴근시간</th>
			<th>근무시간</th>
			<th>확인용 </th>
		</tr>
			

		<c:forEach items="${ list }" var="attend">
		<c:if test="${ loginMember.memberId eq attend.memId  }"> 
		<thead class="alert-warning">
		<tr data-no="${ attend.key }">
		<td><fmt:formatDate value="${ attend.arrive }" pattern="yyyy/MM/dd일"/></td>
			<td><fmt:formatDate value="${ attend.arrive }" pattern="HH:mm"/></td>
			<td><fmt:formatDate value="${ attend.leave }" pattern="HH:mm"/></td>
			<td>${ attend.time }</td>
			<td>[${ attend.memId }] &nbsp; key=[${ attend.key }]</td>
		</tr>
			</thead>
		</c:if>
		</c:forEach>
	</table>
</section>
<script>

function attendtest(){
	$("#form1").attr("action","${pageContext.request.contextPath}/attend/attendtest.do")
	.attr("method", "POST")
	.submit();
}
//출근
function attendArrive(){
	$("#form1").attr("action","${pageContext.request.contextPath}/attend/attendArrive.do")
	.attr("method", "POST")
	.submit();
}

//퇴근
function attendLeabe(){
	$("#form1").attr("action","${pageContext.request.contextPath}/attend/attendLeabe.do")
	.attr("method", "POST")
	.submit();
	var a=new Date;
	alert(a);
}

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
