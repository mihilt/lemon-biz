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
			<strong>직급 정보</strong>
		</h4>
		<div class="container-inner card-body">
				<table class="table w-50 m-auto">
					<thead>
						<tr>
							<th scope="col">직급명</th>
							<th class="text-right" scope="col">수정 / 삭제</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${ rankList }" var="rank">
							<form method="get"
								  action="${pageContext.request.contextPath}/manager/manageRank/update.do">
								<input name="key" class="form-control" type="hidden" value="${ rank.key }">
								<tr>
									<td>
										<input name="name" class="form-control" value="${ rank.name }">
									</td>
	
									<td class="text-right">
										<button type="submit"
										   class="btn btn-outline-secondary">
											수정
										</button>
										<a type="button" 
										   class="btn btn-outline-danger"
										   onclick="return confirm('정말 삭제 하시겠습니까 ?')"
										   href="${pageContext.request.contextPath}/manager/manageRank/delete.do?key=${ rank.key }">
										   삭제
										</a>
									</td>
								</tr>
							</form>
						</c:forEach>
					</tbody>
				</table>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/sbFooter.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
