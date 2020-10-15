<%@page import="com.lemon.lemonbiz.member.model.vo.Member"%>
<%@page import="java.io.File"%>
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
			method="post"
			enctype="multipart/form-data">
			
			<!-- 프로필 사진 -->
			<div id = "profile_file_add"
				 class="m-5 mx-auto" 
				 style="
				 	width: 200px;
				 	height: 200px;
				 	background-size: 200px 200px;
			 	    border-radius: 70%;
			 	    border: 1px;
    				overflow: hidden;
    				
    				<%  
    					Member loginMember = (Member)session.getAttribute("loginMember");
    					
    					String saveDirectory = request.getServletContext()
    							.getRealPath("/resources/upload/profile_images");
    					
    					File file = new File(saveDirectory+"/"+ loginMember.getMemberId() +".png");
    					boolean isExist = file.exists();
    					
    					if(isExist){
    				%>
				 	background-image: url('${pageContext.request.contextPath }/resources/upload/profile_images/<%=loginMember.getMemberId()%>.png');
    				<% 
    					} else {
    				%>
				 	background-image: url('${pageContext.request.contextPath }/resources/images/default-image.png');
    				<% 
    					}
    				%>
    				
				 	cursor: pointer;
				 ">
			</div>
			
			<!-- input file -->
			<input type="file" id="myfile" name="profile_img" style="display:none;" accept="image/png">
			
			<div class="mb-1 row mx-5">
				<div class="col-2 pt-2 text-right">사번 :</div>
				<div class="col-10 form-control bg-gray-200">${ loginMember.memberId }</div>
				<input type="hidden" name="memberId"
					value="${ loginMember.memberId }" />
				<input type="hidden" name="isManager"
					value="${ loginMember.isManager }" />
			</div>
			<div class="mb-1 row mx-5">
				<div class="col-2 pt-2 text-right">이름 :</div>
				<input name="name" class="col-10 form-control" type="text"
					value=${ loginMember.name }>
			</div>
			<div class="mb-1 row mx-5">
				<div class="col-2 pt-2 text-right">부서 :</div>
				<select disabled  name="deptKey" class="col-10 form-control"
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
				<select disabled name="rankKey" class="col-10 form-control"
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
			</div>
		</form>
	</div>
</div>
<script>
$(function() {
    $('#profile_file_add').click(function() {
        $("input[name='profile_img']").click();
       
    })
    $("input[name='profile_img']").change(function(e){
    	readURL(this);
    })

    function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
            $('#profile_file_add').css('background-image', 'url('+e.target.result +')');
            $('#profile_file_add').hide();
            $('#profile_file_add').fadeIn(650);
        }
        reader.readAsDataURL(input.files[0]);
    }
}
})

</script>
<jsp:include page="/WEB-INF/views/common/sbFooter.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />