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
		<form class="p-4"
			action="${ pageContext.request.contextPath }/member/memberUpdate.do"
			method="get">
			<div class="mb-1 row mx-5">
				<div class="col-2 pt-2 text-right">사번 :</div>
				<div class="col-10 form-control bg-gray-200">${ loginMember.memberId }</div>
				<input type="hidden" name="memberId"
					value="${ loginMember.memberId }" />
			</div>
			<div class="mb-1 row mx-5">
				<div class="col-2 pt-2 text-right">이름 :</div>
				<input name="name" class="col-10 form-control" type="text"
					value=${ loginMember.name }>
			</div>
			<div class="mb-1 row mx-5">
				<div class="col-2 pt-2 text-right">부서 :</div>
				<select name="deptKey" class="col-10 form-control"
					id="exampleFormControlSelect1">
					<c:forEach items="${ deptList }" var="dept">
						<option value="${ dept.key }"
							<c:if test="${ loginMember.deptKey eq dept.key }">
							selected
						</c:if>>
							${ dept.name }(${ dept.key })</option>

					</c:forEach>
				</select>
			</div>
			<div class="mb-1 row mx-5">
				<div class="col-2 pt-2 text-right">직급 :</div>
				<select name="rankKey" class="col-10 form-control"
					id="exampleFormControlSelect1">
					<c:forEach items="${ rankList }" var="rank">
						<option value="${ rank.key }"
							<c:if test="${ loginMember.rankKey eq rank.key }">
							selected
						</c:if>>${ rank.name }</option>

					</c:forEach>
				</select>
			</div>
			<br />
			<div class="mb-1 row mx-5">
				<div class="col-2 pt-2 text-right">전화번호 :</div>
				<input name="telNum" class="col-10 form-control" type="text"
					value=${ loginMember.telNum }>
			</div>
			<div class="mb-1 row mx-5">
				<div class="col-2 pt-2 text-right">주소 :</div>
				<input name="address" class="col-10 form-control" type="text"
					value=${ loginMember.address }>
			</div>
			<div>
				<button
					class="btn bg-warning text-white font-weight-bold float-right mt-3 mr-5"
					type="submit">수정하기</button>
				<button
					class="btn bg-danger text-white font-weight-bold float-right mt-3 mr-2"
					type="button" onclick = "location.href = '${pageContext.request.contextPath}/member/updatePassword.do'">비빌번호 변경</button>
			</div>
		</form>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/sbFooter.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />