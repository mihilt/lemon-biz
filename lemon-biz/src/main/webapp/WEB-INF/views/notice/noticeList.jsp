<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/sbHeader.jsp" />

<script>
$(document).ready(function() {
    $('#noticeDataTable').DataTable( {
        "order": [[ 0, "desc" ]]
    } );
} );
</script>

<div class="container">
	<div class="card">
		<h4 id="m-title" class="card-header">
			<strong>알림 리스트</strong>
		</h4>

		<div class="m-5">
			<table class="table table-bordered" id="noticeDataTable" width="100%"
				cellspacing="0">
				<thead>
					<tr>
						<th scope="col">날짜</th>
						<th scope="col">내용</th>
						<th scope="col"></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${ noticeList }" var="notice">
						<tr>
							<td><fmt:formatDate value="${ notice.noticeDate }"
									pattern="yyyy.MM.dd HH:mm:ss" /></td>
							<td><i class="fas ${ notice.icon } text-${notice.color}"></i>
								<a href="${pageContext.request.contextPath}${ notice.address }">${ notice.content }</a>
							</td>
							<td style="width: 8%"><a type="button"
								class="btn btn-outline-danger"
								onclick="return confirm('정말 삭제 하시겠습니까 ?')"
								href="${pageContext.request.contextPath}/notice/noticeList/delete.do?key=${ notice.key }">
									삭제 </a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/sbFooter.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
