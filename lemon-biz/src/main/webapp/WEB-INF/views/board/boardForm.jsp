<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/sbHeader.jsp"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>board</title>
  <!-- 헤드 네비게이션 효과 -->
  <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">

  <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 

  <!-- summernote -->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.js"></script>



</head>
<body>
	<div class="container-fluid text-center">
		<div class="row content">
			<div class="col-sm text-left">
				<br>
				<h2>게시글 작성</h2>

				<form id="boardFrm" name="boardFrm" action="${pageContext.request.contextPath}/board/boardEnroll.do" 
					  method="post" enctype="multipart/form-data"
				action="${pageContext.request.contextPath}/board/boardEnroll.do" method="post">
					<div class="form-group">
						<input type="hidden" name="memId" value="${loginMember.memberId}"/>	
						<input type="hidden" name="name" value="${loginMember.name}"/>	
					</div> 
					<div class="custom-control custom-checkbox" >
				<input type="checkbox" id="jb-checkbox" name="isNotice" class="custom-control-input" value="0">
				<label class="custom-control-label" for="jb-checkbox" style="float:right;"><strong>공지사항 등록</strong></label>
			</div>
					<div class="form-group">
						<label for="title">제목:</label> <input placeholder="Enter Title" type="text" class="form-control" id="title" name="title">
					</div>
					<div class="input-group mb-3" style="padding:0px;">
		  <div class="input-group-prepend" style="padding:0px;">
		    <span class="input-group-text">첨부파일1</span>
		  </div>
		  <div class="custom-file">
		    <input type="file" class="custom-file-input" name="upFile" id="upFile" >
		    <label class="custom-file-label" for="upFile1">파일을 선택하세요</label>
		  </div>
		</div>
		<div class="input-group mb-3" style="padding:0px;">
		  <div class="input-group-prepend" style="padding:0px;">
		    <span class="input-group-text">첨부파일2</span>
		  </div>
		  <div class="custom-file">
		    <input type="file" class="custom-file-input" name="upFile" id="upFile" >
		    <label class="custom-file-label" for="upFile2">파일을 선택하세요</label>
		  </div>
		</div>
			<div class="form-group">
				<label for="content">내용:</label>
				<textarea id="brdmemo" class="form-control" name="content" rows="10"></textarea> 
			</div>
			<div align="center">

					<a href="#"	class="btn btn-outline-warning" onclick="fn_formSubmit()">작성 완료</a>
					<a href="${pageContext.request.contextPath}/board/boardList.do" class="btn btn-outline-warning">취소</a> 
			</div>
		</form>
				<br>
			</div>
		</div>
	</div>
</body>
<br><br>
<script type="text/javascript">

$(document).ready(function(){
	 $("#jb-checkbox").click(function () {
		 if($("input[name=isNotice]:checked") ){
			 document.getElementById("jb-checkbox").value = "1"
			 
		 }
	});
});
 


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

function chkInputValue(id, msg) {
	if ($.trim($(id).val()) == "") {
		alert(msg + " 입력해주세요.");
		$(id).focus();
		return false;
	}
	return true;
}
function fn_formSubmit() {
	
	if (!chkInputValue("#title", "글 제목을"))
		return;
	if (!chkInputValue("#brdmemo", "글 내용을"))
		return;

	$("#boardFrm").submit();
}

$(function(){
	$("[name=upFile]").on("change", function(){
		var file = $(this).prop('files')[0];
		var $label = $(this).next(".custom-file-label");

		if(file == undefined)
			$label.html("파일을 선택하세요");
		else
			$label.html(file.name);
	});
});

</script>
</html>
<jsp:include page="/WEB-INF/views/common/sbFooter.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
