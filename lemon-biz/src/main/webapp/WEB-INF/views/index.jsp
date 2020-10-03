<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<form method="post" id="loginFrm" action="${pageContext.request.contextPath}/member/memberLogin.do">
  <div>
    <label for="id">아이디</label>
    <input type="text" id="memberId" name="memberId" placeholder="ID" >
    <label for="password">비밀번호</label>
    <input type="password" id="password" name="password" placeholder="Password" >
  </div>
  <button type="submit">로그인</button>
</form>
