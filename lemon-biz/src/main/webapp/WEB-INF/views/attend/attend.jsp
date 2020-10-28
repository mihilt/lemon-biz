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
div.infoVal{display:inline-block; width: 24%; height: 85%;color:#fff; margin: 8px; background-color: #FB0; border-radius: 35px 35px 35px 0px;"}
tr[data-no]{cursor: pointer;}
</style>

<section id="attend-container" class="container">
	<div id="attendInfo">
		<div class="infoVal ">
			<h6 class="h6Info ">총근무일</h6>
			<p>&nbsp;${sumArr}일</p>
		</div>
		<div class="infoVal">
			<h6 class="h6Info">총시간</h6>
			<p>&nbsp;${sumTime}</p>
		</div>
		<div class="infoVal">
			<h6 class="h6Info">평균시간</h6>
			<p>&nbsp;${avgTime}</p>
		</div>
	</div>
 	 <form id="form1" class="form-inline" method="post"
		action="<%-- ${pageContext.request.contextPath }/attend/attendLeabe.do --%>" >
		<input type="hidden" value="전달할값1" class="form-control col-sm-5" name="value1" required/>&nbsp;
	 </form>
	 		<div id="lastarrive" style="display:none"><fmt:formatDate value="${ lastAttend.arrive }" pattern="yyyyMMdd"/></div>
	 		<div id="lastLeave" style="display:none"><fmt:formatDate value="${ lastAttend.arrive }" pattern="HH"/></div>
	<div>
		<c:if test="${ loginMember.isManager eq 1 }">			
		<button id="btn-cal" class="btn btn-outline-warning" type="button" onclick="location.href='${pageContext.request.contextPath}/attend/manageAttend.do' ">근태 조회</button>
		</c:if>
		<button id="btn-cal" class="btn btn-outline-warning" type="button" onclick="location.href='${pageContext.request.contextPath}/attend/attendCal.do' ">월별 근태</button>
		<button id="btn-leabe" class="btn btn-outline-warning" type="button" onclick="attendLeabe();">퇴근</button>
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
			<th>번호</th>
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
			<td>${ attend.key }</td>
		</tr>
		</c:forEach>
	</table>
	<div class="text-center">	
				<ul style="justify-content: center;" class="pagination">${pagebar}</ul>
		</div>
</section>
<script>
var lastarrive=$("#lastarrive").text();
var today = new Date();
var month = today.getMonth()+1;
if(month < 10) {month = "0"+month;}
today=today.getFullYear()+""+month+today.getDate();

//출근
function attendArrive(){
	if(lastarrive==today){
		alert("이미 출근되었습니다.");
	}else{
		$("#form1").attr("action","${pageContext.request.contextPath}/attend/attendArrive.do")
		.attr("method", "POST")
		.submit();
	}
}
//퇴근
function attendLeabe(){

	var lastLeave=$("#lastLeave").text();
	time = new Date().getHours();
	time+=24;
	var lastTime ='${lastAttend.time}';
	var last_1 =Number(lastarrive);
	
	 if(lastTime=='0.0'&& last_1==Number(today)){			//퇴근하지않았거나 오늘퇴근이라면
	 	$("#form1").attr("action","${pageContext.request.contextPath}/attend/attendLeabe.do")
		.attr("method", "POST")
		.submit();
	}else if(++last_1==Number(today)){				//야근일시 24시간전에 퇴근가능

		time=time-Number(lastLeave);
		if(time<=24){
		$("#form1").attr("action","${pageContext.request.contextPath}/attend/attendLeabe.do")
		.attr("method", "POST")
		.submit();
		}else{
			alert("퇴근시간이 지났습니다.");
		}
	}else{
		alert("출근후 퇴근이 가능합니다.");
	}   
}

</script>
<jsp:include page="/WEB-INF/views/common/sbFooter.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
