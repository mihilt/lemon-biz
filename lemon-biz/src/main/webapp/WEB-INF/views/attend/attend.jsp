<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/sbHeader.jsp"/>
<style>
/*글쓰기버튼*/
button#btn-Leave{float:right; margin:0 15px;}
button#btn-arrive{float:right; margin: 0 0 15px;}
div#attendInfo{width: 100%; height: 100px; text-align: center;  margin-top: 20px;}
div.infoVal{display:inline-block; width: 24%; height: 85%;color:#fff; margin: 8px; background-color: #FB0; border-radius: 35px 35px 35px 0px;"}
tr[data-no]{cursor: pointer;}
</style>

<section id="attend-container" class="container">
	<div id="attendInfo">
		<div class="infoVal ">
			<h4 class="h4Info ">총근무일</h4>
			<p>${attendInfo.totalDay }</p>
		</div>
		<div class="infoVal">
			<h4 class="h4Info">총시간</h4>
			<p>${attendInfo.totalTime }</p>
		</div>
		<div class="infoVal">
			<h4 class="h4Info">평균시간</h4>
			<p>${attendInfo.totalAvg }</p>
		</div>
	</div>
	
	<div>
		<c:if test="${ loginMember.isManager eq 1 }">			
		<button id="btn-cal" class="btn btn-outline-warning" type="button" 
				onclick="location.href='${pageContext.request.contextPath}/manager/manageAttend.do' ">근태 조회</button>
		</c:if>
		<button id="btn-cal" class="btn btn-outline-warning" type="button" 
			onclick="location.href='${pageContext.request.contextPath}/attend/attendCal.do' ">월별 근태</button>
		<button id="btn-Leave" class="btn btn-outline-warning" type="button" onclick="attendLeave();">퇴근</button>
	 	<button id="btn-arrive" class="btn btn-outline-warning" type="button" onclick="attendArrive();">출근</button>
	</div>
	<table id="tbl-attend" class="table ">
	<thead class="bg-warning">
		<tr>
			<th>요일</th>
			<th>일자</th>
			<th>출근시간</th>
			<th>퇴근시간</th>
			<th>근무시간</th>
		</tr>
			</thead>
		<c:forEach items="${ list }" var="attend">

		<c:if test="${attend.leave ne null}">
		<thead class="alert-warning">
		</c:if>
		<c:if test="${attend.leave eq null}">
		<thead class="alert-danger">
		</c:if>
		<tr data-no="${ attend.key }">
			<td><fmt:formatDate value="${ attend.arrive }" pattern="E"/></td>
			<td><fmt:formatDate value="${ attend.arrive }" pattern="yyyy/MM/dd"/></td>
			<td><fmt:formatDate value="${ attend.arrive }" pattern="HH:mm"/></td>
			<td><fmt:formatDate value="${ attend.leave }" pattern="HH:mm"/></td>
			<td>${ attend.time }</td>
		</tr>
		</c:forEach>
	</table>
	<div class="text-center">	
				<ul style="justify-content: center;" class="pagination">${pagebar}</ul>
		</div>
</section>
<script>

//출근
function attendArrive(){
	var today = new Date();
	var month = today.getMonth()+1;
	var todate = today.getDate();
	if(month < 10) {month ="0"+month;}
	if(todate < 10) {todate ="0"+todate;}
	today=today.getFullYear()+""+month+""+todate;
		location.href = "${pageContext.request.contextPath}/attend/attendArrive.do?today="+today;
	}
	//퇴근
	function attendLeave() {
		var today = new Date();
		var month = today.getMonth() + 1;
		var todate = today.getDate();
		if (month < 10) {
			month = "0" + month;}
		if (todate < 10) {
			todate = "0" + todate;}
		today = today.getFullYear() + "" + month + "" + todate;
		time = new Date().getHours();
		time += 24;		
		today +=time; 
		location.href = "${pageContext.request.contextPath}/attend/attendLeave.do?today="+today;
	}
</script>
<jsp:include page="/WEB-INF/views/common/sbFooter.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
