<%@page import="com.lemon.lemonbiz.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:useBean id="now" class="java.util.Date" />
<fmt:requestEncoding value="utf-8" /> <!-- 한글깨짐 방지  -->
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/sbHeader.jsp"/>


<div class="container-fluid">
<h2>결제완료문서</h2>
    			
<table class="table table-hover text-center">
<colgroup>
			<col width='8%' />
			<col width='*%' />
			<col width='15%' />
			<col width='15%' />
			<col width='10%' />
			<col width='10%' />
		</colgroup>
		<thead>
	<tr>
	
	<th>문서번호</th>
	<th>제목</th>
	<th>상태</th>
	<th>작성일</th>
	
	
	</tr>
	</thead>
	
	<c:if test="${ pageInfo.totalCount != 0 }">
	<c:forEach var="item" items="${ apvList }" begin="${ pageInfo.startNum }" end="${ pageInfo.endNum }">
	<c:if test="${ item.status == 'a'}">
		<tr onclick="compliteDetail(${ item.key })" style="cursor: pointer;">
			<td>${ item.key }</td>
			<td><a >${ item.title }</a></td>
			<td> 승인완료 </td>
			<td><fmt:formatDate value="${ item.writeDate }"  pattern="yyyy-MM-dd HH:mm:ss"/></td>
			
		</tr>
	</c:if>
	</c:forEach>
	</c:if>
	
	</table>
	</div>
	<div>
			
			<ul class="pagination justify-content-center">	
				<c:if test="${pageInfo.page != 1}">	
					<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/${toSearch}?page=1"><i class="fas fa-angle-double-left"></i></a></li>					
				</c:if>
				<c:if test="${pageInfo.page >= 11}">	
					<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/${toSearch}?page=${pageInfo.page-1}"><i class="fas fa-angle-left"></i></a></li>			
				</c:if>
										
				<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
					<c:if test="${i eq pageInfo.page }">
						<li class="page-item active"><a class="page-link" href="#">${i}</a></li>					
					</c:if>					
					<c:if test="${i != pageInfo.page }">					
						<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/${toSearch}?page=${i}">${i}</a></li>					
					</c:if>
				</c:forEach>
			
				<c:if test="${ pageInfo.endPage != pageInfo.totalPage }">					
					<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/${toSearch}?page=${pageInfo.endPage+1}"><i class="fas fa-angle-right"></i></a></li>
					<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/${toSearch}?page=${pageInfo.endPage+1}"><i class="fas fa-angle-double-right"></i></a></li>	
				</c:if>
				
			</ul> <!-- Paging end -->

<div align="center">
	<form id="goSearch" method="POST" action="${ pageContext.request.contextPath }/apvList/search"> </form>
		
		
		
		<div class="group" style="align:center;">
		<select class="btn btn-outline-primary dropdown-toggle" id="condition">
			<option value="title">제목</option>
			<option value="writer">제출자</option>
			<option value="apvNum">문서번호</option>
		</select>
		   
	<input class="btn btn-outline-primary" id="word" type="text" placeholder="검색어 입력" aria-label="Search" aria-describedby="basic-addon2">
	<button class="btn btn-outline-primary" id="search" onclick="search()"><i class="fas fa-search fa-sm"></i></button>
	<!-- <button onclick="resetSc()">검색 초기화</button> --> </div>
	
	
	</div>
	
	</div>
	<form id="compliteApprovalDetail" action="${pageContext.request.contextPath}/approval/compliteApprovalDetail.do" method="GET">
		
	</form>



<script>

function compliteDetail(j) {

	$('<input></input>').attr('type','hidden').attr('value',j).attr('name','apprKey').appendTo('#compliteApprovalDetail');
	$('#compliteApprovalDetail').submit();		
	
}

</script>





<jsp:include page="/WEB-INF/views/common/sbFooter.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>