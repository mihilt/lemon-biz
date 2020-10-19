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
button#btn-leabe{float:right; margin:0 15px;}
button#btn-arrive{float:right; margin: 0 0 15px;}
div#attendInfo{width: 100%; height: 100px; text-align: center;  margin-top: 20px;}
div.infoVal{display:inline-block; width: 20%; height: 85%;color:#fff; margin: 8px; background-color: #FB0; border-radius: 35px 35px 35px 0px;"}
</style>

<section id="attend-container" class="container">
	<div id="attendInfo">
		<div class="infoVal ">
			<h6 class="h6Info ">총근무일</h6>
			<p>${sumArr}</p>
		</div>
		<div class="infoVal">
			<h6 class="h6Info">총시간</h6>
			<p>${sumTime}</p>
		</div>
		<div class="infoVal">
			<h6 class="h6Info">평균시간</h6>
			<p>${avgTime}</p>
		</div>
		<div class="infoVal">
			<h6 class="h6Info">빈공간</h6>
			<p>빈공간</p>
		</div>
	</div>
		
 	 <form id="form1" class="form-inline" method="post"
		action="<%-- ${pageContext.request.contextPath }/attend/attendLeabe.do --%>" >
		<input type="hidden" value="전달할값1" class="form-control col-sm-5" name="value1" required/>&nbsp;
	 </form>
	 		<div id="lastarrive" style="display:none"><fmt:formatDate value="${ lastAttend.arrive }" pattern="yyyyMMdd"/></div>
	<div>
		<button id="btn-cal" class="btn btn-outline-warning" type="button" onclick="attendtest();">월별 근태기록</button>
		<button id="btn-leabe" class="btn btn-outline-warning" type="button" onclick="attendLeabe();">퇴근</button>&nbsp;
	 	<button id="btn-arrive" class="btn btn-outline-warning" type="button" onclick="attendArrive();">출근</button>
	</div>

	<table id="tbl-attend" class="table ">
	<thead class="bg-warning">

		<tr>
			<th>날짜</th>
			<th>출근시간</th>
			<th>퇴근시간</th>
			<th>근무시간</th>
			<th>확인용 </th>
		</tr>
			</thead>
		<c:forEach items="${ list }" var="attend">

		<thead class="alert-warning">
		<tr data-no="${ attend.key }">
		<td><fmt:formatDate value="${ attend.arrive }" pattern="yyyy/MM/dd"/></td>
			<td><fmt:formatDate value="${ attend.arrive }" pattern="HH:mm"/></td>
			<td><fmt:formatDate value="${ attend.leave }" pattern="HH:mm"/></td>
			<td>${ attend.time }</td>
			<td>[${ attend.memId }] &nbsp; key=[${ attend.key }]</td>
		</tr>
			</thead>

		</c:forEach>
	</table>
</section>
<script>
var lastarrive=$("#lastarrive").text();
today = new Date();
month = today.getMonth()+1;
if(month < 10){month = "0"+month;}
/* var todayTime =today.getHours()+"";
console.log(todayTime); */
today=today.getFullYear()+""+month+today.getDate();

//출근
function attendArrive(){
	if(lastarrive==today){
		alert("이미 출근상태입니다.");
	}else{
	$("#form1").attr("action","${pageContext.request.contextPath}/attend/attendArrive.do")
	.attr("method", "POST")
	.submit();
	}
}

//퇴근
function attendLeabe(){
	var lastTime ='${lastAttend.time}';
	if(lastTime=='0.0' && false){
	console.log('퇴근가능');
	}else{
		console.log("꼼수 노 노");
	}
/* 	$("#form1").attr("action","${pageContext.request.contextPath}/attend/attendLeabe.do")
	.attr("method", "POST")
	.submit();
	console.log(); */
}

//test
function attendtest(){
	$("#form1").attr("action","${pageContext.request.contextPath}/attend/attendtest.do")
	.attr("method", "POST")
	.submit(); 
}
</script>
<jsp:include page="/WEB-INF/views/common/sbFooter.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
