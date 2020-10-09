<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<fmt:requestEncoding value="utf-8" /> <!-- 한글깨짐 방지  -->
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/sbHeader.jsp"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 
<!-- Bootstrap -->
<link href='<c:url value="/css/bootstrap.min.css" />' rel="stylesheet">
<link href='<c:url value="/css/kfonts2.css" />' rel="stylesheet">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src='<c:url value="/jquery/jquery-1.11.3.min.js" />'></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src='<c:url value="/js/bootstrap.min.js"  />'></script>

<title>전체 메일</title>
<style>
	#btns{
		margin: 1rem 0rem 1rem 0rem;
	}
	#send-mail, #content-temp, #attach-to{
		margin-right: .2rem;
	}
	.btn.btn-light{
		border: 1px solid lightgray;
	}
	form{
		padding: 1rem;
	}
	.container{
		transform: scale(.96);
	}
	#write-title{
		margin: 0rem 0rem 1rem 0rem; 
	}
	/* 별 모양 체크박스 만들기(북마크) */
	/* 클릭 이전 상태를 2606(outline only 별 모양)으로 설정 */
	.star:before {
	   content: "\2606";
	   visibility:visible;
	   color: gray;
	}
	/* 클릭 이전 상태를 2605(filled 별 모양)으로 설정 */
	.star:checked:before {
	   content: "\2605";
	}
	.star:checked:before {
	   content: "\2605";
	   color: orange;
	}
	div[id^="mail-row"], div[id^="upper-col"]{
		border: 1px solid lightgray;
		padding: .2rem .5rem .2rem .5rem; 
		max-height: 2rem;
		text-align: center;
	}
	#mail-row3 > span, #mail-row3 > span{
		font-size: .9rem;
		margin-top: auto;
	}
	
	.star {
	    visibility:hidden;
	    font-size: 1.3rem;
	    cursor:pointer;
	}
	.the-fucking-star{
	    margin-top: -.7rem;
	    width: 1.3rem;
    }
    #btns{
    	transform: scale(.8);
    	margin-top: -1rem;
    }
    input[id^="mail-btn"]{
    	padding: .4rem 1.2rem .4rem 1.2rem;
    	margin: 0rem .2rem 0rem .2rem;
    }
</style>
</head>

<body>
	<div class="container">
		<div class="card">
		  <h4 id="m-title" class="card-header"><strong>전체 메일</strong></h4>
			<div class="container-inner card-body">
		  <form action="${pageContext.request.contextPath}/mail/mailAll">
		 <!-- card 박스 내 상위 영역 : 수정 예정 -->
		    <div class="row" id="upper-menu">
		    	<div class="col" id="upper-col1">
		    		<input type="checkbox" name="cb-mail" id="cb-mail" /></div>
		    	<div class="col" id="upper-col2">
		    		Re</div>
		    	<div class="col" id="upper-col3">
		    		Mr</div>
		    	<div class="col" id="upper-col4">
		    		.</div>
		    		<div class="col" id="upper-col5">
		    		.</div>
		    </div>
		 <!-- 여기서부터 card-body내 본문 영역 -->
		 	<!-- 지금부터 한 줄 -->	
		   <div class="row">
		   		<div class="col" id="mail-row1">
		   			<input type="checkbox" name="cb-mail" id="cb-mail" /></div>
		   		<div class="col" id="mail-row2">
		   			<div class="the-fucking-star">
		   				<input class="star" type="checkbox" title="bookmark"></div>
		   			</div>
		   		<div class="col-2" id="mail-row3">
		   			<span>김원식(기술지원부/과장)</span></div>
		   		<div class="col-8" id="mail-row4">
		   			<span>거래처 (주)멜론비즈 계약 건 관련하여 요청하신 프리젠테이션 자료입니다.</span></div>
		   		<div class="col-1" id="mail-row5">
		   			<span>20/10/06</span></div>
		   </div>
		   	<!-- 여기까지 한 줄 -->
		   	<!-- 지금부터 한 줄 -->	
		   <div class="row">
		   		<div class="col" id="mail-row1">
		   			<input type="checkbox" name="cb-mail" id="cb-mail" /></div>
		   		<div class="col" id="mail-row2">
		   			<div class="the-fucking-star">
		   				<input class="star" type="checkbox" title="bookmark"></div>
		   			</div>
		   		<div class="col-2" id="mail-row3">
		   			<span>박예빈(사업기획부/과장)</span></div>
		   		<div class="col-8" id="mail-row4">
		   			<span>자네 제정신인가??????????</span></div>
		   		<div class="col-1" id="mail-row5">
		   			<span>20/10/07</span></div>
		   </div>
		   	<!-- 여기까지 한 줄 -->
		  </form>

		     	 </div>
		     	 
		      </div> <!-- container-inner div 끝 --> 
		</div> <!-- container div 끝 -->
		<br />
	
</body>

<script>

/* summernote 호출 및 각종 설정 대입 */
$(document).ready(function() { 	
	$("#attach-to").click(function(){
	    $("#attachModal").modal({backdrop: true});
	  });
	$("#addReceiverBtn").click(function(){
	    $("#addReceiverModal").modal({backdrop: true});
	  });

	$('#content-reset').click(function(){
		var reset = confirm("정말로 작성 중인 내용을 삭제하시겠습니까?");
			if (reset == true) {
			  alert("메일 작성을 취소하셨습니다. 이전 화면으로 돌아갑니다.");
			  window.history.back();
			} else {
		}
	});
	
	$('#send-mail').click(function(){
		if ($('#summernote').summernote('isEmpty')) {
			 alert('본문 내용을 입력해 주세요.');
			 return false;
		}
	});

</script>
</html> 


<jsp:include page="/WEB-INF/views/common/sbFooter.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>