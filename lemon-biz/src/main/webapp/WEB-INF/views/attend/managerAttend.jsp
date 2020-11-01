<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/sbHeader.jsp" />

<div class="container">
	<div class="card">
		<h4 id="m-title" class="card-header">
			<strong>근태 정보</strong>
		</h4>
		<div class="m-5">
			<table class="table table-bordered" id="dataTable" width="100%"
				cellspacing="0">
				<thead>
					<tr>
						<th scope="col">일자</th>
						<th scope="col">요일</th>
						<th scope="col">사번</th>
						<th scope="col">이름</th>
						<th scope="col">출근</th>
						<th scope="col">퇴근</th>
						<th scope="col">근무시간</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${ attendList }" var="attend">
				<td><fmt:formatDate value="${ attend.arrive }" pattern="yyyy/MM/dd"/></td>
				<td><fmt:formatDate value="${ attend.arrive }" pattern="E"/></td>
				<td>${attend.memId }</td>
				<td>${attend.name }</td>
				<td><fmt:formatDate value="${ attend.arrive }" pattern="HH:mm"/></td>
				<td><fmt:formatDate value="${ attend.leave }" pattern="HH:mm"/></td>
				<td>${ attend.time }</td>
			</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
<script>
$('#dataTable').DataTable( {
    "order": [[ 0, "desc" ]]
} );
</script>

<jsp:include page="/WEB-INF/views/common/sbFooter.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
