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
	#send-om, #content-temp, #attach-to, #content-reset{
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
    input[id^="om-btn"]{
    	padding: .4rem 1.2rem .4rem 1.2rem;
    	margin: 0rem .2rem 0rem .2rem;
    }
    table th, td{
    text-align: center;
    }
    td{
    font-size: .9rem;
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
<script>
$(function(){
	$("tr[data-no]").click(function(){
		var key = $(this).attr("data-no");
		console.log(key);
		location.href = "${ pageContext.request.contextPath }/om/omDetail.do?key=" + key;
	});
});


function goOmForm(){
	location.href = "${pageContext.request.contextPath}/om/omForm.do";
}

</script>
</head>
<body>
	<div class="container">
		<div class="card">
		  <h4 id="m-title" class="card-header"><strong>전체 메일</strong></h4>
			<div class="container-inner card-body">
		  <form action="${pageContext.request.contextPath}/om/omList" method="GET">
		 <!-- 여기서부터 card-body내 본문 영역 -->
         <!-- 여기서부터 네비게이션 헤더 -->
         <ul class="nav nav-tabs" id="addl-btns" role="tablist">
		      <li class="nav-item">
		        <a class="nav-link active" id="allOM-tab" href="${pageContext.request.contextPath}/om/omList.do" 
		        	role="tab" aria-controls="allOM" aria-selected="true">전체</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" id="deptOM-tab" href="${pageContext.request.contextPath}/om/omTeamList.do"
		        	role="tab" aria-controls="deptOM" aria-selected="false">내 부서 메일</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" id="myOM-tab" href="${pageContext.request.contextPath}/om/omMyList.do"
		        	role="tab" aria-controls="myOM" aria-selected="false">내가 보낸 메일</a>
		      </li>
		       <li class="nav-item">
		        <a class="nav-link" id="selfOM-tab" href="${pageContext.request.contextPath}/om/omSelfList.do"
		        	role="tab" aria-controls="selfOM" aria-selected="false">내게 보낸 메일</a>
		      </li>
		     <li class="nav-item">
		        <a class="nav-link" id="attachedOM-tab" href="${pageContext.request.contextPath}/om/omAttachedList.do"
		        	role="tab" aria-controls="attachedOM" aria-selected="false">첨부 메일</a>
		      </li>
		       <li class="nav-item"> 
                     <a class="nav-link disabled" href="#" style="margin-left:.2rem">
                     	<input type="text" name="search-om" id="search-om" 
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
					<th><input type="checkbox" name="ck-om" id="ck-om-all" /></th>
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
			 <!-- 여기서부터 전체 메일 리스트 -->
			<div class="tab-pane fade show active" id="allOM" role="tabpanel" aria-labelledby="allOM-tab">
				<!-- <table id="tbl-all" class="table"> -->
					<c:forEach items="${ list }" var="om">
					<tr data-no="${ om.key }">
						<td><input type="checkbox" name="ck-om" id="ck-om"/></td>
					   	<td>
					   	<div class="the-star">
					   		<input class="star" type="checkbox" title="bookmark" id="star"
					   		<c:if test="${ om.isStarred gt 0 }">checked="checked"</c:if>
					   		/></div>						
					   	</td>
						<td>${ om.memId }</td>
						<td>${ om.title }</td>
						<td>${ om.content }</td>
						<td><fmt:formatDate value="${ om.omDate }" pattern="yy/MM/dd"/></td>
						<td>
							<c:if test="${ om.fileCount gt 0 }">
								<img src="${ pageContext.request.contextPath }/resources/images/file.png"
									style="width: 1rem;" />
							</c:if>
						</td>
					</tr>
					</c:forEach>
					<!-- </table> -->
			</div>
			<!-- 여기까지 전체 메일 리스트 -->
		
			</table>
			<!-- 여기까지 중요 메일 리스트 -->	
		
		</div> <!-- 여기까지 card 본문 영역 -->	
		<hr style="margin-top:-1rem"/>	
		<br />
		<!-- 여기까지 메일 리스트 표시 -->
		
		<!-- 여기부터 하단부 버튼 및 페이징 영역 -->
			 <!-- 하단 버튼 영역 -->
		   	 <div align="center" id="btns">
		      <input type="submit" value="중요 메일로 이동" id="send-om" class="btn btn-success">
		      <input type="button" value="첨부파일 다운로드" id="attach-to" class="btn btn-info"/>
		       <input type="button" value="선택 메일 삭제" id="content-reset" class="btn btn-danger"/>
		       <input type="button" value="새 메일 작성" id="btn-add" class="btn btn-warning" onclick="goOmForm();"/>
			</div>	   
			<br />
			<!-- 페이징 영역 -->  	 
			<div class="row" id="pagenate">
				<div class="col">
					<ul style="justify-content: center;" class="pagination">
					<li>${ pagebar }</li>
				</ul>
				</div>
		    </div>
		  </form>		
		      </div> <!-- container-inner div 끝 --> 
		</div> <!-- container div 끝 -->
		</div>
		<br />
	</body>
<script>
$(function(){
	$("tr[data-key]").click(function(){
		var no = $(this).attr("data-key");
		console.log(no);
		location.href = "${ pageContext.request.contextPath }/om/omDetail.do?no=" + no;
	});
});
function goOMForm(){
	location.href = "${pageContext.request.contextPath}/board/omForm.do";
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
	$('#send-om').click(function(){
		if ($('#summernote').summernote('isEmpty')) {
			 alert('본문 내용을 입력해 주세요.');
			 return false;
		}
	});
</script>
</html> 

<jsp:include page="/WEB-INF/views/common/sbFooter.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>