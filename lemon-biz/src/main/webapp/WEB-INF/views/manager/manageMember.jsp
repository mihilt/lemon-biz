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
			<strong>사원 정보</strong>
		</h4>
		
		
		
		<div class="m-5">
			<p class = "text-danger text-center">*그룹웨어 관리자 권한을 갖고있는 사원은 붉은색으로 표시</p>
			<table class="table table-bordered" id="dataTable" width="100%"
				cellspacing="0">
				<thead>
					<tr>
						<th scope="col">사원 번호</th>
						<th scope="col">이름</th>
						<th scope="col">직급</th>
						<th scope="col">부서</th>
						<th scope="col">상세보기</th>
						<th scope="col">퇴사</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${ memberList }" var="member">
						<tr
							<c:if test="${ member.isManager eq 1 }">
								class = "text-danger font-weight-bold"
							</c:if>						
						>
							<td>${ member.memberId }</td>
							<td>${ member.name }</td>
							<td>${ member.rankName }</td>
							<td>${ member.deptName }</td>
							<td>
								<a type="button" class="btn btn-outline-secondary"
									href="${pageContext.request.contextPath}/manager/manageMember/detail.do?memberId=${ member.memberId }">상세보기</a>
							</td>
							<td>		
								<a type="button" 
								   class="btn btn-outline-danger"
								   onclick="return confirm('정말 퇴사처리 하시겠습니까 ?')"
								   href="${pageContext.request.contextPath}/manager/manageMember/delete.do?memberId=${ member.memberId }">퇴사</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		
		
		
		
		
		
	</div>
</div>


  <!-- Page level plugins -->
  <script src="${pageContext.request.contextPath }/resources/js/jquery.dataTables.min.js"></script>
  <script src="${pageContext.request.contextPath }/resources/js/dataTables.bootstrap4.min.js"></script>
  <!-- Page level custom scripts -->
  <script src="${pageContext.request.contextPath }/resources/js/datatables-demo.js"></script>
  
  
<jsp:include page="/WEB-INF/views/common/sbFooter.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
