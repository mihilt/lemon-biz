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


<script>
function boardValidate(){
	var $content = $("[name=boardContent]");
	if(/^(.|\n)+$/.test($content.val()) == false){
		alert("내용을 입력하세요");
		return false;
	}
	return true;

function boardView(){
	history.go(-1);
}


</script>

</head>
<body>

 	<div class="col-lg-12">
 			<form action="${pageContext.request.contextPath}/board/boardUpdate.do" method="post" name="board">
 			<input type="hidden" name="key" value="${ board.key }" />
              <div class="card" >
                <div class="card-header py-3">
                  <div align="right">작성일 :<strong class="m-0 font-weight-bold text-warning"> <fmt:formatDate  value="${ board.postDate }" pattern="yyyy/MM/dd"/><br></strong>작성자  : <strong class="m-0 font-weight-bold text-warning">${board.memId}</strong>	&nbsp; 조회수 : <strong class="m-0 font-weight-bold text-warning">${ board.readCount }</strong></div>
                </div>
                <div class="card-body text-center">
                 <label for="title">제목:</label> <input type="text" class="form-control" id="title" name="title" value="${board.title}">
                  <hr>
                  <div class="form-group" align="left">
					<textarea id="brdmemo" class="form-control" name="Content" rows="10">${ board.content }</textarea>	 
				  </div>
                  <hr>
                  <div><strong>첨부파일</strong>
                  <c:forEach items="${ board.attachList }" var="attach">
					<button type="button" 
							class="btn btn btn-secondary btn-block"
							onclick="fileDownload('${ attach.key }')">
						첨부파일 - ${ attach.originName }
					</button>
				</c:forEach>
				</div><br>
				<div class="container">
				<input type="button" class="btn btn-outline-warning" onclick="boardView();" value="취소">
				
					<input type="submit" class="btn btn-outline-warning" onclick="return boardValidate();" value="수정하기">
		
			
				</div>
                </div>
              </div>
			</form>
            </div>
		
				
		
</body>
<script>
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
</script>
</html>
<jsp:include page="/WEB-INF/views/common/sbFooter.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
