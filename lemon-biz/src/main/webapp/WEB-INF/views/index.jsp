<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<h1>로그인 테스트</h1>
<form method="post" id="loginFrm" action="${pageContext.request.contextPath}/member/memberLogin.do">
  <div>
    <label for="id">사원 번호</label>
    <input type="text" id="memberId" name="memberId" placeholder="사원 번호" >
    <label for="password">비밀번호</label>
    <input type="password" id="password" name="password" placeholder="비밀 번호" >
  </div>
  <button type="submit">로그인</button>
</form>

<h1>사1원 등록 테스트</h1>
<h6>입력한 사원번호는 비밀번호와 일치합니다</h6>
<form method="post" action="${pageContext.request.contextPath}/member/memberEnroll.do">
  <div>
    <label for="id">사원 번호</label>
    <input type="text" id="memberId" name="memberId" placeholder="사원 번호" >
  </div>
  <button type="submit">사원 등록</button>
</form>
