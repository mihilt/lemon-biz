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
			<strong><a
				href="${ pageContext.request.contextPath }/manager/manageDept.do">부서
					정보</a> / 부서 수정</strong>
		</h4>
		<form class="p-4 mx-auto w-75"
			action="${ pageContext.request.contextPath }/manager/manageDept/update.do"
			method="post">
			<div class="mb-1 row mx-5">
				<input name="key" value="${ dept.key }" placeholder="부서 번호"
					class="col form-control" type="text" required>
			</div>

			<div class="mb-1 row mx-5 mb-4">
				<input name="name" value="${ dept.name }" placeholder="부서명"
					class="col form-control" type="text" required>
			</div>
			<div class="mb-2 row mx-5">
				<div class="col-3 pt-2 text-right">상위 부서 :</div>
				<select name="ref" class="col-9 form-control" id="deptKey">
					<c:forEach items="${ deptList }" var="deptElement">
						<option value="${ deptElement.key }"
							<c:if test="${ dept.ref eq deptElement.key }">
							selected
						</c:if>>
							${ deptElement.name }(${ deptElement.key })</option>

					</c:forEach>
				</select>
			</div>
			<div class="text-center">
				<button
					class="btn bg-warning text-white font-weight-bold float-right mt-4 mr-5"
					type="submit">수정하기</button>
			</div>
		</form>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/sbFooter.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
