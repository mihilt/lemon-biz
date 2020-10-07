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
			<strong>부서 관리</strong>
		</h4>
		<div class="container-inner card-body">
			<table class="table">
				<thead>
					<tr>
						<th scope="col">부서 번호</th>
						<th scope="col">상위 부서</th>
						<th scope="col">부서명</th>
						<th scope="col">수정 /삭제</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${ deptList }" var="dept">
						<tr>
							<td>${ dept.key }</td>
							<td>${ dept.refName }<c:if test="${ dept.ref != null}">
									(${ dept.ref })
								</c:if>
							</td>
							<td>${ dept.name }</td>
							<td>
								<a type="button" class="btn btn-outline-secondary"
									href="${pageContext.request.contextPath}/manager/manageDept/update.do?key=${ dept.key }">수정</a>
								<a type="button" class="btn btn-outline-danger"
									href="${pageContext.request.contextPath}/manager/manageDept/delete.do?key=${ dept.key }">삭제</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/sbFooter.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
