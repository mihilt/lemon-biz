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
			<strong>내 정보 보기</strong>
		</h4>
		${ loginMember }
		<div class="p-4">
			<div class="mb-1 row mx-5 m-0">
				<div class="col-2 pt-2 text-right">사번 :</div>
				<div class="col-10 form-control bg-gray-200">${ loginMember.memberId }</div>
			</div>
			<div class="mb-1 row mx-5 m-0">
				<div class="col-2 pt-2 text-right">이름 :</div>
				<input class="col-10 form-control" type="text"
					value=${ loginMember.name }>
			</div>
			<div class="mb-1 row mx-5 m-0">
				<div class="col-2 pt-2 text-right">부서 :</div>
				<div class="col-10 form-control bg-gray-200">${ loginMember.deptKey }번
					부서인데 ㅠ</div>
			</div>
			<div class="mb-1 row mx-5 m-0">
				<div class="col-2 pt-2 text-right">직급 :</div>
				<div class="col-10 form-control bg-gray-200">${ loginMember.rankKey }번
					직급인데 ㅠ</div>
			</div>
			<br />
			<div class="mb-1 row mx-5 m-0">
				<div class="col-2 pt-2 text-right">전화번호 :</div>
				<input class="col-10 form-control" type="text"
					value=${ loginMember.telNum }>
			</div>
			<div class="mb-1 row mx-5 m-0">
				<div class="col-2 pt-2 text-right">주민번호? :</div>
				<input class="col-10 form-control" type="text"
					value=${ loginMember.idNum }>
			</div>
			<div class="mb-1 row mx-5 m-0">
				<div class="col-2 pt-2 text-right">주소 :</div>
				<input class="col-10 form-control" type="text"
					value=${ loginMember.address }>
			</div>
			<div>
				<a
					class="btn bg-warning text-white font-weight-bold float-right mt-3 mr-5"
					href="${ pageContext.request.contextPath }/member/수정가자">수정하기</a>
			</div>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/sbFooter.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />