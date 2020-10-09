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
			<strong>비밀번호 변경</strong>
		</h4>
		<form class="p-4 mx-auto w-75"
			action="${ pageContext.request.contextPath }/member/updatePassword.do"
			method="post"
			onsubmit="return checkFrm()"
			>
			<input type="hidden" name="memberId"
					value="${ loginMember.memberId }" />
			<div class="mb-4 row mx-5">
				<input name="password" placeholder="현재 비밀번호" class="col form-control" type="password" value="" required>
			</div>
			
			<div class="mb-1 row mx-5">
				<input id="change_pwd" placeholder="변경 비밀번호" name="change_pwd" class="col form-control" type="password" value="" required>
			</div>
			<div class="mb-1 row mx-5">
				<input id="change_pwd_check" placeholder="변경 비밀번호 확인" class="col form-control" type="password" value="" required>
			</div>
			<div class="text-center">
				<button
					class="btn bg-warning text-white font-weight-bold float-right mt-4 mr-5"
					type="submit">변경하기</button>
			</div>
		</form>
	</div>
</div>

<script>
function checkFrm(){
	const $change_pwd = $("#change_pwd");
	const $change_pwd_check = $("#change_pwd_check");
	
	if($change_pwd.val() != $change_pwd_check.val()){
		alert("변경 비밀번호와 변경 비밀번호 확인이 일치하지 않습니다.");
		return false;
	}
	return true;
}
</script>
<jsp:include page="/WEB-INF/views/common/sbFooter.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />