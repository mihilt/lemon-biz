<%@page import="com.lemon.lemonbiz.board.model.vo.BoardComment"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/sbHeader.jsp"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 <!-- 헤드 네비게이션 효과 -->
  <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">
  <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 


  <!-- summernote -->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.js"></script>

</head>
<body>
<div class="container">
	<div class="container-fluid text-center">

		<!-- 게시글 -->
 	<div class="col-lg-12">
 			<form action="${pageContext.request.contextPath}/board"	method="post" name="board">
              <div class="card" >
                <div class="card-header py-3">
                  <div align="right">작성일 :<strong class="m-0 font-weight-bold text-warning"> <fmt:formatDate  value="${ board.postDate }" pattern="yyyy/MM/dd"/><br></strong>작성자  : <strong class="m-0 font-weight-bold text-warning">${board.memId}</strong>	&nbsp; 조회수 : <strong class="m-0 font-weight-bold text-warning">${ board.readCount }</strong></div>
                </div>
                <div class="card-body text-center">
                  <div align="left"><strong>제목 : ${board.title}</strong></div>
                  <hr>
                  <div class="form-group" align="left">
                   <div style="height:300px; overflow:auto;" align=left>${ board.content }</div> 
				  </div>
                  <hr>
                  <div><strong>첨부파일</strong><br>
                  <c:forEach items="${ board.attachList }" var="attach">
                  <c:if test="${ attach.originName != null }">
                  <a href="javascript:fileDownload('${ attach.key }');">
                  <img alt="첨부파일" src="${ pageContext.request.contextPath }/resources/images/file.png" width=16px>
					${ attach.originName }
                  </a>
                  </c:if>
				</c:forEach>
				</div><br>
				<div class="container">
				<a class="btn btn-outline-warning" href="${ pageContext.request.contextPath }/board/boardList.do">돌아가기</a>
				<c:if test="${loginMember.name eq board.memId or loginMember.isManager eq 1}">
					<a class="btn btn-outline-warning" onclick="deleteBoard('${ board.key}')" href="boardfrmDelete.do?key=<c:out value="${board.key}"/>">삭제</a>
					<a class="btn btn-outline-warning" onclick="updateBoard('${ board.key }')" href="boardUpdate.do?key=<c:out value="${board.key}"/>">수정</a>
				</c:if>
				</div>
                </div>
              </div>
			</form>
            </div>
				<br>
				
	
		<!-- 댓글 -->
		<div class="card mb-4 py-3 border-bottom-warning">
			<form id="form1" name="boardCommentFrm" action="${pageContext.request.contextPath}/board/boardInsert.do" method="post">
			<div align="center">
				<input type="hidden" name="boardRef" value="${ board.key }" />
				<input type="hidden" name="boardCommentWriter" value= "${loginMember.memberId }" />
				<input type="hidden" name="boardCommentLevel" value="1" />
				<input type="hidden" name="boardCommentRef" value="0" /> 
				<textarea style="width:50% !important;" class="form-control bg-light border-0 small" name="boardCommentContent"  rows="3" cols="60" maxlength="500" placeholder="댓글을 달아주세요."></textarea>
				<br>
				<button  type="submit" id="btn-insert" class="btn btn-outline-warning" >등록</button>
				</div>
			</form>
				<hr>
		<!-- 댓글작성창	 -->	
	<table id="tbl-comment">
		 	<c:if test="${ commentList ne null and not empty commentList}">
		 		<c:forEach items="${commentList}" var="BoardComment">
		 			<c:choose>
		 			<c:when test="${ BoardComment.boardCommentLevel eq 1 }">
		 			<tr class="level1">
					<td>
						<sub class="comment-writer">
							${ BoardComment.boardCommentWriter }
						</sub>
						<sub class="comment-date">
							<fmt:formatDate value="${ BoardComment.boardCommentDate }" pattern="yyyy/MM/dd"/>
						</sub>
						<br />
						${ BoardComment.boardCommentContent }
					</td>
					<td>
						<button class="btn-reply"
								value="${ BoardComment.boardCommentNo }">답글</button>
						<c:if test="${ BoardComment.boardCommentWriter eq (loginMember.memberId)}">			
						<button class="btn-delete" value="${ BoardComment.boardCommentNo }">삭제</button>
						</c:if>										
					</td>
				</tr>	
		 		</c:when>
				<c:otherwise>
				<tr class="level2">
					<td>
						<sub class="comment-writer">
							${ BoardComment.boardCommentWriter }
						</sub>
						<sub class="comment-date">
							<fmt:formatDate value="${ BoardComment.boardCommentDate }" pattern="yyyy/MM/dd"/>
						</sub>
						<br />
						${ BoardComment.boardCommentContent }
					</td>
					<td>
						<c:if test="${ BoardComment.boardCommentWriter eq (loginMember.memberId)}">			
						<button class="btn-delete" value="${ BoardComment.boardCommentNo }">삭제</button>
						</c:if>										
					</td>
				</tr>
				</c:otherwise>
				
				 </c:choose>
			 </c:forEach>
			 </c:if>
				
		</table>	
		</div>
		</div>	
	</div>
		
</body>
<script type="text/javascript">
$(document).ready(function(){

	$('#brdmemo').summernote({
		  lang: 'ko-KR',
	      height: 500,
	      popover: {
	    	  image:[],
	    	  link:[],
	    	  air:[]
	      } ,
	      toolbar: [
	    	    // [groupName, [list of button]]
	    	    ['style', ['bold', 'italic', 'underline', 'clear']],
	    	    ['font', ['strikethrough', 'superscript', 'subscript']],
	    	    ['fontsize', ['fontsize']],
	    	    ['color', ['color']],
	    	    ['para', ['ul', 'ol', 'paragraph']],
	    	    ['table', ['table']],
	    	    ['insert', ['link', 'picture', 'hr']],
	    	    ['height', ['height']]
	    	  ],
	    	  focus: true,
				callbacks: {
					onImageUpload: function(files, editor, welEditable) {
			            for (var i = files.length - 1; i >= 0; i--) {
			            	sendFile(files[i], this);
			            }
			        }
				}
	  });	  
}) 

function fileDownload(key){
	location.href = "${ pageContext.request.contextPath }/board/fileDownload.do?key=" + key;
}

function deleteBoard(key){
	if(!confirm("정말 삭제하시겠습니까?")) return;
	location.href = "${ pageContext.request.contextPath }/board/boardfrmDelete.do?key=" + key;
}

function updateBoard(key){
	location.href = "${ pageContext.request.contextPath }/board/boardUpdate.do?key=" + key;
}

 /* 댓글입력창 */
$("[name=boardCommentFrm]").submit(function(){

	var $textarea = $("#boardCommentContent");
	if(/^(.|\n)+$/.test($textarea.val()) == false){
		alert("댓글 내용을 입력하세요.");
		return false;
	}
	
	return true;
});
 /* 댓글 삭제 */
 $(".btn-delete").click(function(){
	
	if(!confirm("정말 삭제하시겠습니까?")) return;
	
	location.href = "${ pageContext.request.contextPath }/board/boardDelete.do?key=" + ${ board.key } + "&boardCommentNo="+$(this).val();
	
});

/*  대댓글 */
	$(".btn-reply").click(function(){
		var html = "<tr>"
				 + "<td style='display:none; text-align:left' colspan='2'>"
				 + "<form action='${pageContext.request.contextPath}/board/boardInsert.do' method='POST'>"
				 + '<input type="hidden" name="boardRef" value="${ board.key }" />'
				 + '<input type="hidden" name="boardCommentWriter" value="${loginMember.memberId }" />'
				 + '<input type="hidden" name="boardCommentLevel" value="2" />'
				 + '<input type="hidden" name="boardCommentRef" value="' + $(this).val() + '" />' 
				 + '<textarea name="boardCommentContent" cols="60" rows="1" style="width:450px;"></textarea>'
				 + '<button type="submit" class="btn-insert2" style="width:60px;">등록</button>'
				 + "</form>"
				 + "</td>"
				 + "</tr>"
		  var $tr = $(html);
		  var $trFromBtn = $(this).parent().parent();
		  $tr.insertAfter($trFromBtn)
		  	 .children("td")
		  	 .slideDown(800)
		  	 .children("form")
		  	 .submit(function(){
		  		var $textarea = $(this).children("textarea");
		  		console.log($textarea);
		  		if(/^(.|\n)+$/.test($textarea.val()) == false){
		  			alert("댓글 내용을 입력하세요.");
		  			return false;
		  		}
		  		return true;
		  	 })
		  	 .children("textarea")
		  	 .focus();
		  $(this).off('click');

});

</script>
</html>
<jsp:include page="/WEB-INF/views/common/sbFooter.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
