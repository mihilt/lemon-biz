<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<form method="post" id="authForm" action="https://www.tistory.com/auth/login">
  <div>
    <label for="loginId">아이디</label>
    <input type="email" id="loginId" name="loginId" placeholder="ID" >
    <label for="loginPw">비밀번호</label>
    <input type="password" id="loginPw" name="password" placeholder="Password" >
  </div>
  <button type="submit"  disabled="disabled">로그인</button>
  <div>
    <input type="checkbox" id="keepLogin" name="keepLogin">
    <label for="keepLogin"><span>로그인 상태 유지</span></label>
  </div>
</form>
			 
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
