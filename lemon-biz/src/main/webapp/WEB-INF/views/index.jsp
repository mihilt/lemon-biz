<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<h1>로그인 테스트</h1>
<form method="post" id="loginFrm"
	action="${pageContext.request.contextPath}/member/memberLogin.do">
	<div>
		<label for="id">사원 번호</label> <input type="text" id="memberId"
			name="memberId" placeholder="사원 번호"> <label for="password">비밀번호</label>
		<input type="password" id="password" name="password"
			placeholder="비밀 번호">
	</div>
	<button type="submit">로그인</button>
</form>

<h1>사원 등록 테스트</h1>
<h6>입력한 사원번호는 비밀번호와 일치합니다</h6>
<form method="post"
	action="${pageContext.request.contextPath}/member/memberEnroll.do">
	<div>
		<label for="id">사원 번호</label> <input type="text" id="memberId"
			name="memberId" placeholder="사원 번호">
	</div>
	<button type="submit">사원 등록</button>
</form>

<div class="container">
	<!-- Outer Row -->
	<div class="row justify-content-center">

		<div class="col-xl-10 col-lg-12 col-md-9">

			<div class="card o-hidden border-0 shadow-lg my-5">
				<div class="card-body p-0">
					<!-- Nested Row within Card Body -->
					<div class="row">
						<div class="col-lg-6 d-none d-lg-block bg-gray-900"></div>
						<div class="col-lg-6">
							<div class="p-5">
								<div class="text-center">
									<h1 class="h4 text-gray-900 mb-4">Lemon Biz</h1>
								</div>
								<form class="user" method="post"
									action="${pageContext.request.contextPath}/member/memberLogin.do">

									<div class="form-group">
										<input type="text" name="memberId"
											class="form-control form-control-user" placeholder="사원 번호">
									</div>

									<div class="form-group">
										<input type="password" name="password"
											class="form-control form-control-user" placeholder="비밀번호">
									</div>
									<hr>
									<button type="submit"
										class="btn btn-primary btn-user btn-block">로그인</button>
									<hr>
									<button class="btn btn-danger btn-user btn-block"> 비밀번호 찾기 </button>
								</form>
							</div>
							로그인 유효성검사 다시 알아봐서 잘 해보기
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>