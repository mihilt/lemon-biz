<%@page import="com.lemon.lemonbiz.member.model.vo.Member"%>
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

	<!-- include summernote css/js : cdn --> 
	<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-bs4.min.css" rel="stylesheet"> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote.min.js"></script>

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
	#multiple-ok{
		font-size: .9rem;
	}
</style>
</head>

<body>

	<div class="container">
		<div class="card">
		  <h4 id="m-title" class="card-header"><strong>메일 작성</strong></h4>
			<div class="container-inner card-body">
		  <form action="${pageContext.request.contextPath}/mail/mailSend" method="POST">
		  <div class="form-group row">
		    <label for="mFrom" class="col-sm-1 col-form-label">작성자</label>
		    <div class="col-sm-9">
		      <input type="text" readonly class="form-control" id="toShow" value="${myInfo.name} (${myInfo.deptName}/${myInfo.rankName})">
		      <input type="hidden" readonly class="form-control" id="mFrom" value="${myInfo.email}">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="mTo" class="col-sm-1 col-form-label" id="send-to">수신자</label>
		     <div class="col-sm-9">
		    <input type="text" class="form-control" id="mTo" name="mTo" placeholder="김원식(영업부/대리), 홍기수(총무부/부장)의 형식으로 보여주기?">
		  	</div>
		  	<button type="button" class="btn btn-light" data-target="#addReceiverModal" id="addReceiverBtn">수신인 추가</button>
		  </div>
		  
		  <div class="form-group row">
		    <label for="mFrom" class="col-sm-1 col-form-label">&ensp;제목</label>
		    <div class="col-sm-9">
		      <input type="text" name="title" placeholder="제목을 입력해주세요." class="form-control" id="write-title">
		    </div>
		  </div>
		
		    <div align="justify">
		      <textarea id="summernote" class="summer-content" name="content" cols="120" rows="12" 
		      			style="width:100%; resize:none" class="form-control"></textarea>
		    </div>
		    <div align="center" id="btns">
		      <input type="submit" value="메일 발송" id="send-mail" class="btn btn-success">
		      <input type="button" value="파일 첨부" id="attach-to" class="btn btn-info" data-target="#attachModal"/>
		      <input type="button" value="임시 저장" id="content-temp" class="btn btn-secondary"/>
		      <input type="button" value="작성 취소" id="content-reset" class="btn btn-danger"/>
		    </div>
		  </form>
		     	 </div>
		     	 
		      </div> <!-- container-inner div 끝 --> 
		</div> <!-- container div 끝 -->
		<br />
		
<!-- 주. 모달 본체에 해당하는 애들은 container/wrapper로 감쌀 필요가 없으므로 /body태그의 바로 윗 편, 즉 body 태그 내부 최 하단에 위치시켜 주어야 문제가 안 생긴다! -->
		
	<!-- 수신인 추가 모달 -->
		<div class="modal fade" id="addReceiverModal" role="dialog" 
			aria-labelledby="addReceiverModal" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="addReceiverModalLabel"><strong>수신인 추가</strong></h5>
		      </div>
		      <div class="modal-body">
		        <p id="add-receiver" style="display:'inline-block'">어쩌구 저쩌구 여따가 설명글</p>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn-sm btn-primary">수신인 추가</button>
		        <button type="button" class="btn-sm btn-secondary" data-dismiss="modal">취소</button>
		      </div>
		    </div>
		  </div>
		</div>
	<!-- 첨부파일 추가 모달 -->
		<div class="modal fade" id="attachModal" tabindex="-1" role="dialog" 
			aria-labelledby="attachModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="attachModalLabel"><strong>첨부파일 추가</strong></h5>
		      </div>
		      <div class="modal-body">
		        <p id="multiple-ok" style="display:'inline-block'">복수 개의 파일 선택이 가능합니다.</p>
		    <div class="add-file">
		        <input type="file" name="add-attach" id="add-attach" multiple/>
			</div>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn-sm btn-primary">첨부파일 업로드</button>
		        <button type="button" class="btn-sm btn-secondary" data-dismiss="modal">취소</button>
		      </div>
		    </div>
		  </div>
		</div>
</body>

<script>

$(document).ready(function() { 	
/*  	$('#send-mail').click(function(){
 	 	alert("테슷흐");
 	 	return true;
		if ($('#summernote').summernote('isEmpty')) {
			 alert('본문 내용을 입력해 주세요.');
			 return false;
		} 
	});  */
	$("#attach-to").click(function(){
	    $("#attachModal").modal({backdrop: true});
	  });
	$("#addReceiverBtn").click(function(){
	    $("#addReceiverModal").modal({backdrop: true});
	  });

	/* summernote 호출 및 각종 설정 대입 */
	$('#summernote').summernote({
		/* 여기서부터 summernote 호출 및 각종 설정 대입 */
        placeholder: '이메일 내용을 입력 해 주세요.',
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

	/* 여기서부터 파일 관련 */
	var files = [];
	var fileCount = 0;
</script>
</html> 


<jsp:include page="/WEB-INF/views/common/sbFooter.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>