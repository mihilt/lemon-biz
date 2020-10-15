<%@page import="java.io.File"%>
<%@page import="com.lemon.lemonbiz.member.model.vo.Member"%>
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
			<strong><a href="${ pageContext.request.contextPath }/manager/manageMember.do">사원 정보</a> / 상세보기</strong>
		</h4>
		<form class="p-4"
			action="${ pageContext.request.contextPath }/manager/manageMember/detail/update.do"
			method="get">
			<div class="m-5 mx-auto" 
				 style="
				 	width: 200px;
				 	height: 200px;
				 	background-size: 200px 200px;
			 	    border-radius: 70%;
			 	    border: 1px;
    				overflow: hidden;
    				
   	 		    	<%  
    					Member member = (Member)request.getAttribute("member");
    					
    					String saveDirectory = request.getServletContext()
    							.getRealPath("/resources/upload/profile_images");
    					
    					File file = new File(saveDirectory+"/"+ member.getMemberId() +".png");
    					boolean isExist = file.exists();
    					
    					if(isExist){
    				%>
				 	background-image: url('${pageContext.request.contextPath }/resources/upload/profile_images/<%=member.getMemberId()%>.png');
    				<% 
    					} else {
    				%>
				 	background-image: url('${pageContext.request.contextPath }/resources/images/default-image.png');
    				<% 
    					}
    				%>
				 ">
			</div>
			<div class="mb-1 row mx-5">
				<div class="col-2 pt-2 text-right">사번 :</div>
				<div class="col-10 form-control bg-gray-200">${ member.memberId }</div>
				<input type="hidden" name="memberId"
					value="${ member.memberId }" />
			</div>
			<div class="mb-1 row mx-5">
				<div class="col-2 pt-2 text-right">이름 :</div>
				<input name="name" class="col-10 form-control" type="text"
					value=${ member.name }>
			</div>
			<div class="mb-1 row mx-5">
				<div class="col-2 pt-2 text-right">부서 :</div>
				<select name="deptKey" class="col-10 form-control"
					id="exampleFormControlSelect1">
					<c:forEach items="${ deptList }" var="dept">
						<option value="${ dept.key }"
							<c:if test="${ member.deptKey eq dept.key }">
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
							<c:if test="${ member.rankKey eq rank.key }">
							selected
						</c:if>>${ rank.name }</option>

					</c:forEach>
				</select>
			</div>
			<br />
			<div class="mb-1 row mx-5">
				<div class="col-2 pt-2 text-right">전화번호 :</div>
				<input name="telNum" class="col-10 form-control" type="text"
					value=${ member.telNum }>
			</div>
			<div class="mb-1 row mx-5">
				<div class="col-2 pt-2 text-right">주소 :</div>
				<input name="address" class="col-10 form-control" type="text"
					value=${ member.address }>
			</div>
			<br />
			<div class="mb-1 row mx-5">
				<div class="col-2 pt-2 text-right">관리자 :</div>
				<div class="col-10 pt-2">
					<div class="form-check">
					  <input class="form-check-input" type="radio" name="isManager" id="no" value="0" <c:if test="${ member.isManager eq 0 }">checked</c:if>>
					  <label class="form-check-label" for="no">
					    	아니오
					  </label>
					</div>
					<div class="form-check">
					  <input class="form-check-input" type="radio" name="isManager" id="yes" value="1" <c:if test="${ member.isManager eq 1 }">checked</c:if>>
					  <label class="form-check-label" for="yes">
					 	   네
					  </label>
					</div>
				</div>
			</div>
			
			<div>
				<button
					class="btn bg-warning text-white font-weight-bold float-right mt-3 mr-5"
					type="submit">수정하기</button>
			</div>
		</form>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/sbFooter.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />