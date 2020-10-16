<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/sbHeader.jsp"/>

<div class="container">
	<div class="card">
		<h4 id="m-title" class="card-header">
			<strong>전자결재 문서 조회</strong>
		</h4>
		<div class="container-inner card-body">
			<table class="table table-bordered" id="dataTable" width="100%"
				cellspacing="0">
				<thead>
					<tr>
						<th scope="col">문서명</th>
						<th scope="col"></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${ docTypeList }" var="docType">
							<tr>
								<td>
									${ docType.name }
								</td>

								<td>
									<a type="button" 
									   class="btn btn-outline-secondary"
									   href="${pageContext.request.contextPath}/manager/manageApprovalDoc/update.do?key=${ docType.key }">
									   수정
									</a>
									<a type="button" 
									   class="btn btn-outline-danger"
									   onclick="return confirm('정말 삭제 하시겠습니까 ?')"
									   href="${pageContext.request.contextPath}/manager/manageApprovalDoc/delete.do?key=${ docType.key }">
									   삭제
									</a>
								</td>
							</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
			 
<jsp:include page="/WEB-INF/views/common/sbFooter.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
