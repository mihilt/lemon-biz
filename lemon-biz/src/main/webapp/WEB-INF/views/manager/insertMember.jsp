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
			<strong>사원 등록</strong>
		</h4>
		<div class="container-inner card-body">
			<h6 class="text-danger">*등록한 사원의 초기 비밀번호는 사원번호와 동일합니다</h6>
			<form method="post"
				action="${pageContext.request.contextPath}/member/memberEnroll.do">
				<div class="form-inline">
					<input class = "form-control mr-2" type="text" id="memberId" name="memberId"
						placeholder="사원 번호">
					<button class="btn bg-warning text-white font-weight-bold"
						type="submit">사원 등록</button>
				</div>
			</form>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/sbFooter.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
