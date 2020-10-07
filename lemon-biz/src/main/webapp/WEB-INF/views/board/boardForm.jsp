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
<title>업무 메일 작성</title>
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
		padding: .7rem;
	}
	.container{
		transform: scale(.96);
	}
	#write-title{
		margin: 0rem 0rem 1rem 0rem; 
	}
	.add-file{
	margin-left: 7rem;
	}
	#plus{
	margin-right: .5rem;
	}
	
	#file1{
	width:400px;
	
	}
	
	#file2{
	width:400px;
	}

</style>
</head>

<body>
	<div class="container">
		<div class="card">
		  <h4 id="m-title" class="card-header"><strong>게시글 작성</strong></h4>
		  
			<div class="container-inner card-body">
		  <form action="${pageContext.request.contextPath}/mail/mailSend" method="post">
		  
  
		 <input type="text" class="form-control" placeholder="제목" name="title" id="title" required>
		    
		  </div>
		  <div class="input-group mb-3" style="padding:0px;">
		  <div class="input-group-prepend" style="padding:0px;">
		    <span class="input-group-text" id="filename" >첨부파일1</span>
		  </div>
		  <div class="custom-file">
		    <input type="file" class="custom-file-input" name="upFile" id="upFile1"  >
		    <label class="custom-file-label" for="upFile1" id="file1" >파일을 선택하세요</label>
		  </div>
		</div>
		<div class="input-group mb-3" style="padding:0px;">
		  <div class="input-group-prepend" style="padding:0px;">
		    <span class="input-group-text">첨부파일2</span>
		  </div>
		  <div class="custom-file">
		    <input type="file" class="custom-file-input" name="upFile" id="upFile2" >
		    <label class="custom-file-label" for="upFile2" id="file2">파일을 선택하세요</label>
		  </div>
		</div>
		
		    <div align="justify">
		      <textarea id="summernote" class="summer-content" name="content" cols="120" rows="12" 
		      			style="width:100%; resize:none" class="form-control"></textarea>
		    </div>
		    
		  </form>
		    <div align="center" id="btns">	     
		      <input type="button" value="작성 완료" id="content-temp" class="btn btn-secondary"/>
		      <input type="button" value="작성 취소" id="content-reset" class="btn btn-danger"/>
		    </div>
		     	 </div>
		      </div> <!-- container-inner div 끝 --> 
		</div> <!-- container div 끝 -->
		<br />
		


<script>

/* summernote 호출 및 각종 설정 대입 */
$(document).ready(function() { 
	$('#plus').click(function(){
		var fSection = $('.add-file');
		/* fSection.add('<input type="file" name="add-attach1" id="add-attach1" />').appendTo("#add-attach"); */
		});
	
	$('#summernote').summernote({
		/* 여기서부터 summernote 호출 및 각종 설정 대입 */
        placeholder: '이메일 내용을 입력 해 주세요.'+'</br></br>'+
        			 '배고프다 마라탕 먹고싶다'+'</br>'+
            		 '아~~~~~~~~~ 마라마라마라마라마라마라',
        tabsize: 4, 
        height: 370,
        tooltip: true,
        toolbar: [
        	  /* ['custom',['pageTemplates','blocks']], */
        	  /* ['HelloButton', ['hello']], */
        	  ['style', ['style']],
        	  ['font', ['bold', 'underline', 'clear']],
        	  ['fontname', ['fontname']],
        	  ['color', ['color']],
        	  ['para', ['ul', 'ol', 'paragraph']],
        	  ['table', ['table']],
        	  ['insert', ['link', 'picture', 'video', 'hr']],
        	  ['view', ['undo', 'redo']]
        	],
        /* 	buttons: {
        	    hello: HelloButton
        	  }, */
        lang: 'ko-KR',
        codeviewFilter: false,
        codeviewIframeFilter: true 
      }); 

	/* 여기서 부터 커스텀 버튼 생성 */
	/* 사용자가 에디터에 작성한 내용을 파싱해서 값으로 반환받는 것도 가능할 것 같음. 더 리서칭해서 알아보기. */
	/* 또한 사용자 정의 버튼/기능을 추가하는 것도 가능할 듯. */
	/* var HelloButton = function (context) {
		  var ui = $.summernote.ui;

		  // create button
		  var button = ui.button({
		    contents: '<i class="fa fa-child"/> Hello',
		    tooltip: 'hello',
		    click: function () {
		      // invoke insertText method with 'hello' on editor module.
		      context.invoke('editor.insertText', 'hello');
		    }
		  });
		  return button.render();   // return button as jquery object
		} */
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