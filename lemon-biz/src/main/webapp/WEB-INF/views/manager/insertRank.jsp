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
			<strong>직급 생성</strong>
		</h4>
		<form class="p-4 mx-auto w-75"
			action="${ pageContext.request.contextPath }/manager/insertRank.do"
			method="post"
			>
			<div class="mb-1 row mx-5">
				<input name="name" placeholder="직급 이름" class="col form-control" type="text" value="" required>
			</div>
			<div class="text-center">
				<button
					class="btn bg-warning text-white font-weight-bold float-right mt-4 mr-5"
					type="submit">생성하기</button>
			</div>
		</form>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/sbFooter.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
