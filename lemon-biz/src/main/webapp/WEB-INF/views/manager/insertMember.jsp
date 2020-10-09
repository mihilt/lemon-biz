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
		
			<h6 class="text-danger text-center mt-2 mb-4">*등록한 사원의 초기 비밀번호는 사원번호와 동일합니다</h6>

			<form class="mx-auto w-75" method="post"
				action="${pageContext.request.contextPath}/member/memberEnroll.do">
				<div class="mb-2 row mx-5">
					<div class="col-2 pt-2 text-right"></div>
					<input class="form-control col-10" type="text" id="memberId"
						name="memberId" placeholder="사원 번호" required>
				</div>
				
				<div class="mb-4 row mx-5">
					<div class="col-2 pt-2 text-right"></div>
					<input class="form-control col-10" type="text"
						name="name" placeholder="이름" required>
				</div>

				<div class="mb-2 row mx-5">
					<div class="col-2 pt-2 text-right">부서 :</div>
					<select name="deptKey" class="col-10 form-control"
						id="exampleFormControlSelect1">
						<c:forEach items="${ deptList }" var="dept">
							<option value="${ dept.key }">
								${ dept.name }(${ dept.key })
							</option>

						</c:forEach>
					</select>
				</div>
				<div class="row mx-5">
					<div class="col-2 pt-2 text-right">직급 :</div>
					<select name="rankKey" class="col-10 form-control"
						id="exampleFormControlSelect1">
						<c:forEach items="${ rankList }" var="rank">
							<option value="${ rank.key }">
								${ rank.name }
							</option>

						</c:forEach>
					</select>
				</div>


				<button
					class="btn bg-warning text-white font-weight-bold float-right mt-4 mr-5"
					type="submit">사원 등록</button>
			</form>



		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/sbFooter.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
