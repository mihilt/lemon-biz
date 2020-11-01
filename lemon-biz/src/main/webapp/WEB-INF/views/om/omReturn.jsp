<%@page import="com.lemon.lemonbiz.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<fmt:requestEncoding value="utf-8" />
<!-- 한글깨짐 방지  -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/sbHeader.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- include summernote css/js : cdn -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-bs4.min.css"
	rel="stylesheet">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote.min.js"></script>

<title>업무 메일 작성</title>
<style>
#btns {
	margin: 1rem 0rem 1rem 0rem;
}

#send-mail, #content-temp, #attach-to {
	margin-right: .2rem;
}

.btn.btn-light {
	border: 1px solid lightgray;
}

form {
	padding: .7rem;
}

.container {
	transform: scale(.96);
}

#write-title {
	margin: 0rem 0rem 1rem 0rem;
}

#multiple-ok {
	font-size: .9rem;
}
td[id^="authName"]{
	padding-top: .4rem;
	padding-bottom: -.3rem;
	border-radius: .2rem;
}
</style>
</head>

<body>

	<div class="container">
		<div class="card">
			<h4 id="m-title" class="card-header">
				<strong>메일 회신</strong>
			</h4>
			<div class="container-inner card-body">
				<form id="omFrm" name="omFrm"
					action="${pageContext.request.contextPath}/om/omReSend.do"
					method="POST" enctype="multipart/form-data">
					<div class="form-group row">
						<label for="mFrom" class="col-sm-1 col-form-label">작성자</label>
						<div class="col-sm-9">
							<input type="text" readonly class="form-control" id="toShow"
								name="name" value="${loginMember.name}" readonly> <input
								type="hidden" name="memId" class="form-control" id="memId"
								value="${loginMember.memberId}" /> <input type="hidden"
								name="deptKey" class="form-control" id="deptKey"
								value="${loginMember.deptKey}" />
						</div>
					</div>
					
					<!-- 수신인 추가 파트 -->
					<div class="form-group row">
						<label for="mTo" class="col-sm-1 col-form-label" id="send-to">수신자</label>
						<div class="col-sm-9">
							<input type="text" name="sendShow" value="${sender.name}(${sender.deptName}/${sender.rankName})" class="form-control" disabled/>
							<input type="hidden" name="sender" value="${origin.memId}" class="form-control"/>
							</div>
					</div>
					<div class="form-group row">
						<label for="title" class="col-sm-1 col-form-label">&ensp;제목</label>
						<div class="col-sm-9">
							<input type="text" name="title" placeholder="제목을 입력해주세요."
								class="form-control" id="title">
						</div>
					</div>
					<div class="form-group row">
						<label for="upFile" class="col-sm-1 col-form-label" id="attch-lab">&ensp;첨부</label>
						&emsp;
						<div class="custom-file col-sm">
							<input type="file" class="custom-file-input" name="upFile"
								id="upFile" multiple> <label class="custom-file-label"
								for="upFile1" style="width: 80%">파일을 선택하세요: 복수 선택이
								가능합니다.</label>
						</div>
					</div>
					<div align="right" id="cks">
					<input type="checkbox" name="goEI" id="goEI" value="goEI" />
							<label for="goEI">해당 사원 이메일로도 발송&nbsp;</label>
							&nbsp;
						<input type="checkbox" name="goS" id="goS" value="goS"/>
						<label for="goS">중요 메일로 설정&nbsp;</label>
					</div>	
					<div align="justify">
						<textarea id="brdmemo" class="summernote" name="content"
							cols="120" rows="12" style="width: 100%; resize: none"
							class="form-control"></textarea>
					</div>
					<br />
					<div align="center" id="btns">
						<input type="submit" value="메일 발송" id="send-mail"
							class="btn btn-success" onclick="fn_formSubmit()"> 
						
							<input
							type="button" value="작성 취소" id="content-reset"
							class="btn btn-danger" />
					</div>
				</form>
			</div>
		</div>
		<!-- container-inner div 끝 -->
	</div>
	<!-- container div 끝 -->
	<br />


</body>
<script>
	$(document)
			.ready(
					function() {
	
						var json = {}
						$("#goSearch").click(function(){
						$.ajax({
						    url: "login.do",
						    type: "POST",
						    data: JSON.stringify(json),
						    success : function(arg) {
							alert("통신성공시에만 실행");
						    }, 
						    error : function(arg){
							alert("통신실패시에만 실행");
						    }
						});
							});
						
						$('#send-mail').click(function() {
							alert("정말로 발송하시겠습니까?");
							return true;
							if ($('.summernote').summernote('isEmpty')) {
								alert('본문 내용을 입력해 주세요.');
								return false;
							}
						});
						$("#attach-to").click(function() {
							$("#attachModal").modal({
								backdrop : true
							});
						});
						$("#addReceiverBtn").click(function() {
							$("#addReceiverModal").modal({
								backdrop : true
							});
						});
						/* summernote 호출 및 각종 설정 대입 */
						$('.summernote')
								.summernote(
										{
											/* 여기서부터 summernote 호출 및 각종 설정 대입 */
											placeholder : '이메일 내용을 입력 해 주세요.',
											tabsize : 4,
											height : 370,
											tooltip : true,
											toolbar : [

													[ 'style', [ 'style' ] ],
													[
															'font',
															[
																	'bold',
																	'underline',
																	'clear' ] ],
													[ 'fontname',
															[ 'fontname' ] ],
													[ 'color', [ 'color' ] ],
													[
															'para',
															[ 'ul', 'ol',
																	'paragraph' ] ],
													[ 'table', [ 'table' ] ],
													[
															'insert',
															[ 'link',
																	'picture',
																	'video',
																	'hr' ] ],
													[ 'view',
															[ 'undo', 'redo' ] ] ],

											lang : 'ko-KR',
											codeviewFilter : false,
											codeviewIframeFilter : true
										});

					});

	$('#content-reset').click(function() {
		var reset = confirm("정말로 작성 중인 내용을 삭제하시겠습니까?");
		if (reset == true) {
			alert("메일 작성을 취소하셨습니다. 이전 화면으로 돌아갑니다.");
			window.history.back();
		} else {
		}
	});

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
		
		$("#omFrm").submit();
	}

	$(function() {
		$("[name=upFile]").on("change", function() {
			var file = $(this).prop('files')[0];
			var $label = $(this).next(".custom-file-label");

			if (file == undefined)
				$label.html("파일을 선택하세요");
			else
				$label.html(file.name);
		});
	});
</script>
</html>


<jsp:include page="/WEB-INF/views/common/sbFooter.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />