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
						<div class="col-lg-6 d-none d-lg-block bg-gray-900",
							 style="background-image: url('${pageContext.request.contextPath }/resources/images/favicon/lemonBiz.jpg');
							 		background-size: 480px 420px;"></div>
						<div class="col-lg-6">
							<div class="p-5">
								<div class="text-center">
									<h1 class="h4 text-gray-900 mb-4">Lemon Biz</h1>
								</div>
								<form class="user" method="post"
									action="${pageContext.request.contextPath}/member/memberLogin.do">

									<div class="form-group">
										<input type="text" name="memberId"
											class="form-control form-control-user" placeholder="사원 번호" required>
									</div>

									<div class="form-group">
										<input type="password" name="password"
											class="form-control form-control-user" placeholder="비밀번호" required>
									</div>
									<hr>
									<button type="submit"
										class="btn btn-primary btn-user btn-block">로그인</button>
									<hr>
									<a href="${pageContext.request.contextPath}/member/memberForgotPassword.do" class="text-white btn btn-danger btn-user btn-block"> 비밀번호 찾기 </a>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

</body>
</html>