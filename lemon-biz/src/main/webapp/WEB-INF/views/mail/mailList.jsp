<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:requestEncoding value="utf-8" /> <!-- 한글깨짐 방지  -->
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/sbHeader.jsp"/>

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
		text-align: center;
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
	.star {
	    visibility:hidden;
	    font-size: 1.3rem;
	    cursor:pointer;
	}
	.the-star{
	    margin-top: -.7rem;
	    width: 1.3rem;
    }
    #star-all{
    	/* border: 1px solid tomato; */
    }
    #btns{
    	transform: scale(.8);
    	margin-top: -1rem;
    }
    input[id^="mail-btn"]{
    	padding: .4rem 1.2rem .4rem 1.2rem;
    	margin: 0rem .2rem 0rem .2rem;
    }
    table th, td{
    text-align: center;
    }
    .pagenation{
    	text-align: center;
    }
    #addl-btns{
    margin-bottom: 0rem;
    }
    .nav-link.active{
    font-weight: bold;
    }
    .nav-link, #pagenate li{
    color: black;
    }
    .nav-link:hover{
    color: blue;
    }
</style>
</head>
<body>
	<div class="container">
		<div class="card">
		  <h4 id="m-title" class="card-header"><strong>전체 메일</strong></h4>
			<div class="container-inner card-body">
		  <form action="${pageContext.request.contextPath}/mail/mailList" method="GET">
		 <!-- 여기서부터 card-body내 본문 영역 -->
		<!--  <div class="row">
		 <label for="q">통합 검색</label>
		  <input type="text" class="form-control" placeholder="search" name="q" 
		  		 style="width:26%; margin-right:.4rem">
                <div class="input-group-btn">
                    <button class="btn btn-default" type="submit"><i class="fa fa-search"></i></button>
                </div>
         </div> -->
         <!-- 여기서부터 네비게이션 헤더 -->
           <ul class="nav nav-tabs" id="addl-btns" role="tablist">
		      <li class="nav-item">
		        <a class="nav-link active" id="allMail-tab" data-toggle="tab" href="#allMail" 
		        	role="tab" aria-controls="allMail" aria-selected="true">전체</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" id="deptMail-tab" data-toggle="tab" href="#deptMail" 
		        	role="tab" aria-controls="deptMail" aria-selected="false">내 부서 메일</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" id="myMail-tab" data-toggle="tab" href="#myMail" 
		        	role="tab" aria-controls="myMail" aria-selected="false">내가 보낸 메일</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" id="starredMail-tab" data-toggle="tab" href="#starredMail" 
		        	role="tab" aria-controls="starredMail" aria-selected="false">중요 메일</a>
		      </li>
<!-- 		      <li class="nav-item">
		        <a class="nav-link" href="#">임시 저장 메일</a>
		      </li> -->
		      <li class="nav-item">
		        <a class="nav-link" href="#">첨부 메일</a>
		      </li>
		       <li class="nav-item">
                     <a class="nav-link disabled" href="#">
                     	<input type="text" name="search-mail" id="search-mail" 
                     		style="width:10rem; height:1.6rem; margin-right: .2rem; margin-bottom: -.1rem"/>
                     	<i class="fa fa-search"></i>
                     </a>
		      	</li>
		   </ul>
		   <!-- 여기까지 네비게이션 헤더 -->
		   
		    <!-- 여기서부터 메일함 상단부 헤더 -->
			<div class="tab-content"> 
				<table class="table" id="tbl-header">
				<tr>
					<th><input type="checkbox" name="ck-mail" id="ck-mail-all" /></th>
					<th id="star-all">
						<div class="the-star">
					   		<input class="star" type="checkbox" title="bookmark-all" id="bookmark-all">
					   	</div>
					</th>
					<th>발신인</th> 
					<th>제목</th>
					<th>내용</th>
					<th>수신일</th>
					<th>첨부파일</th>
				</tr>
				<!-- </table> -->
			</div>
			<!-- 여기까지 메일함 상단부 헤더 -->
			
		 <!-- 지금부터 메일 표시 -->	
			<%-- <!-- 여기서부터 전체 메일 리스트 -->
			<div class="tab-pane fade show active" id="allMail" role="tabpanel" aria-labelledby="allMail-tab">
				<!-- <table id="tbl-all" class="table"> -->
					<c:forEach items="${ list }" var="mail">
					<tr data-no="${ mail.key }">
						<td><input type="checkbox" name="ck-mail" id="ck-mail"/></td>
					   	<td>
					   	<div class="the-star">
					   		<input class="star" type="checkbox" title="bookmark" id="star"
					   		<c:if test="${ mail.isStarred gt 0 }">checked="checked"</c:if>
					   		/></div>						
					   	</td>
						<td>${ mail.memId }</td>
						<td>${ mail.title }</td>
						<td>${ mail.content }</td>
						<td><fmt:formatDate value="${ mail.mailDate }" pattern="yyyy/MM/dd"/></td>
						<td>
							<c:if test="${ mail.fileCount gt 0 }">
								<img src="${ pageContext.request.contextPath }/resources/images/file.png"
									style="width:.4rem;" />
							</c:if>
						</td>
					</tr>
					</c:forEach>
					<!-- </table> -->
			</div>
			<!-- 여기까지 전체 메일 리스트 -->
			
		<!-- table+nav의 충돌로 navbar를 클릭했을 때 분기처리가 되지 않고 한 페이지에 병합된 데이터가 보여짐. 
			  또한 td가 무너지지 않는 선에서 내용의 '일부 표기'를 위한 max-height 등의 설정이 추가 필요. 수정 예정 -->
			
			<!-- 여기서부터 내 부서 메일 리스트 -->
			<div class="tab-pane fade" id="deptMail" role="tabpanel" aria-labelledby="deptMail-tab">
				<!-- <table id="tbl-dept" class="table"> -->
				<c:forEach items="${ listDept }" var="mail">
					<tr data-no="${ mail.key }">
						<td><input type="checkbox" name="ck-mail" id="ck-mail" /></td>
					   	<td>
					   	<div class="the-star">
					   		<input class="star" type="checkbox" title="bookmark" id="star"
					   		<c:if test="${ mail.isStarred gt 0 }">checked="checked"</c:if>
					   		/></div>						
					   	</td>
						<td>${ mail.memId }</td>
						<td>${ mail.title }</td>
						<td>${ mail.content }</td>
						<td><fmt:formatDate value="${ mail.mailDate }" pattern="yyyy/MM/dd"/></td>
						<td>
							<c:if test="${ mail.fileCount gt 0 }">
								<img src="${ pageContext.request.contextPath }/resources/images/file.png"
									style="width:.4rem;" />
							</c:if>
						</td>
					</tr>
					</c:forEach>
				</div>
			<!-- 여기까지 부서 메일 리스트 -->	 --%>
			
			<!-- 여기서부터 내가 보낸 메일 리스트 -->
			<div class="tab-pane fade" id="myMail" role="tabpanel" aria-labelledby="myMail-tab">
				<!-- <table id="tbl-dept" class="table"> -->
				<c:forEach items="${ listMy }" var="mail">
					<tr data-no="${ mail.key }">
						<td><input type="checkbox" name="ck-mail" id="ck-mail" /></td>
					   	<td>
					   	<div class="the-star">
					   		<input class="star" type="checkbox" title="bookmark" id="star"
					   		<c:if test="${ mail.isStarred gt 0 }">checked="checked"</c:if>
					   		/></div>						
					   	</td>
						<td>${ mail.memId }</td>
						<td>${ mail.title }</td>
						<td>${ mail.content }</td>
						<td><fmt:formatDate value="${ mail.mailDate }" pattern="yyyy/MM/dd"/></td>
						<td>
							<c:if test="${ mail.fileCount gt 0 }">
								<img src="${ pageContext.request.contextPath }/resources/images/file.png"
									style="width:.4rem;" />
							</c:if>
						</td>
					</tr>
					</c:forEach>
				</div>
			<!-- 여기까지 내가 보낸 메일 리스트 -->	
			
			<!-- 여기서부터 중요 메일 리스트 -->
			<div class="tab-pane fade" id="starredMail" role="tabpanel" aria-labelledby="starredMail-tab">
				<!-- <table id="tbl-dept" class="table"> -->
				<c:forEach items="${ listStarred }" var="mail">
					<tr data-no="${ mail.key }">
						<td><input type="checkbox" name="ck-mail" id="ck-mail" /></td>
					   	<td>
					   	<div class="the-star">
					   		<input class="star" type="checkbox" title="bookmark" id="star"
					   		<c:if test="${ mail.isStarred gt 0 }">checked="checked"</c:if>
					   		/></div>						
					   	</td>
						<td>${ mail.memId }</td>
						<td>${ mail.title }</td>
						<td>${ mail.content }</td>
						<td><fmt:formatDate value="${ mail.mailDate }" pattern="yyyy/MM/dd"/></td>
						<td>
							<c:if test="${ mail.fileCount gt 0 }">
								<img src="${ pageContext.request.contextPath }/resources/images/file.png"
									style="width:.4rem;" />
							</c:if>
						</td>
					</tr>
					</c:forEach>
				</div>
			</table>
			<!-- 여기까지 중요 메일 리스트 -->	
		
		</div> <!-- 여기까지 card 본문 영역 -->	
		<hr style="margin-top:-1rem"/>	
		<br />
		<!-- 여기까지 메일 리스트 표시 -->
		
		<!-- 여기부터 하단부 버튼 및 페이징 영역 -->
			 <!-- 하단 버튼 영역 -->
		   	 <div align="center" id="btns">
		      <input type="submit" value="중요 메일로 이동" id="send-mail" class="btn btn-success">
		      <input type="button" value="첨부파일 다운로드" id="attach-to" class="btn btn-info"/>
		      <input type="button" value="선택 메일 삭제" id="content-reset" class="btn btn-danger"/>
			</div>	   
			<br />
			<!-- 페이징 영역 -->  	 
			<div class="row" id="pagenate">
				<div class="col">
					<ul class="pagination justify-content-center" id="pagenate">
						 <li class="page-item">
					      <a class="page-link" href="#" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					        <span class="sr-only">Previous</span>
					      </a>
					     </li>
					    <li class="page-item"><a class="page-link" href="#">1</a></li>
					    <li class="page-item"><a class="page-link" href="#">2</a></li>
					    <li class="page-item"><a class="page-link" href="#">3</a></li>
					    <li class="page-item"><a class="page-link" href="#">4</a></li>
					    <li class="page-item"><a class="page-link" href="#">5</a></li>
					    <li class="page-item">
					      <a class="page-link" href="#" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					        <span class="sr-only">Next</span>
					      </a>
					    </li>
					</ul>
				</div>
		    </div>
		  </form>		
		      </div> <!-- container-inner div 끝 --> 
		</div> <!-- container div 끝 -->
		<br />
	</body>
<script>
$(function(){
	$("tr[data-key]").click(function(){
		var no = $(this).attr("data-key");
		console.log(no);
		location.href = "${ pageContext.request.contextPath }/mail/mailDetail.do?no=" + no;
	});
});
function goMailForm(){
	location.href = "${pageContext.request.contextPath}/mail/mailForm.do";
}
$(document).ready(function() { 	
	$('#star-all').click(function(){
		/* alert("test success"); */
		/* 이후 추가 */
	});
});
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