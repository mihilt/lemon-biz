<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

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
									<h1 class="h4 text-gray-900 mb-2">비밀번호를 잊으셨나요?</h1>
									<p class="mb-4">사원 번호와, 등록했던 이메일 주소를 입력해주세요.</p>
								</div>
								<form class="user" method="post"
									action="${pageContext.request.contextPath}/member/memberForgotPassword.do">
									<div class="form-group">
										<input type="text" name="memberId" class="mb-2 form-control form-control-user"
											id="exampleInputEmail" aria-describedby="emailHelp"
											placeholder="사원 번호" required> 
										<input type="email"
											class="form-control form-control-user" name="email"  id="exampleInputEmail"
											aria-describedby="emailHelp" placeholder="이메일 주소" required>
									</div>
									<button type="submit" href="login.html" class="btn btn-primary btn-user btn-block">
										비밀번호 초기화 </button>
								</form>
								<hr>
								<div class="text-center">
									<a class="small" href="${pageContext.request.contextPath}/member/memberLogin.do">로그인 화면으로 돌아가기</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>

	</div>

</div>
