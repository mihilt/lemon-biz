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

function chkInputValue(id, msg){
	if ( $.trim($(id).val()) == "") {
		alert(msg+" 입력해주세요.");
		$(id).focus();
		return false;
	}
	return true;
}
function fn_formSubmit(){
	if ( ! chkInputValue("#rewriter1", "작성자를")) return;
	if ( ! chkInputValue("#rememo1", "글 내용을")) return;
	
	var formData = $("#form1").serialize();
	$.ajax({
		url: "boardReplySave", 
		type:"post", 
		data : formData,
		success: function(result){
			if (result!=="") {
				$("#rewriter1").val("");
				$("#rememo1").val("");
				$("#replyList").append(result);
				alert("저장되었습니다.");
			} else{
				alert("서버에 오류가 있어서 저장되지 않았습니다.");
			}
		}
	})		
}

function fn_replyDelete(reno){
	if (!confirm("삭제하시겠습니까?")) {
		return;
	}
	$.ajax({
		url: "boardReplyDelete",
		type:"post", 
		data: {"reno": reno},
		success: function(result){
			if (result=="OK") {
				$("#replyItem"+reno).remove();
				alert("삭제되었습니다.");
			} else{
				alert("댓글이 있어서 삭제할 수 없습니다.");
			}
		}
	})
}

var updateReno = updateRememo = null;
function fn_replyUpdate(reno){
	hideDiv("replyDialog");
	
	$("#replyDiv").show();
	
	if (updateReno) {
		$("#replyDiv").appendTo(document.body);
		$("#reply"+updateReno).text(updateRememo);
	} 
	
	$("#reno2").val(reno);
	$("#rememo2").val($("#reply"+reno).text());
	$("#reply"+reno).text("");
	$("#replyDiv").appendTo($("#reply"+reno));
	$("#rememo2").focus();
	updateReno   = reno;
	updateRememo = $("#rememo2").val();
} 

function fn_replyUpdateSave(){
	if ( ! chkInputValue("#rememo2", "글 내용을")) return;
	
	var formData = $("#form2").serialize();
	$.ajax({
		url: "boardReplySave", 
		type:"post", 
		data : formData,
		success: function(result){
			if (result!=="") {
				$("#reply"+updateReno).text($("#rememo2").val());
				$("#replyDiv").hide();
				alert("저장되었습니다.");
			} else{
				alert("서버에 오류가 있어서 저장되지 않았습니다.");
			}
		}
	})
} 

function fn_replyUpdateCancel(){
	hideDiv("#replyDiv");
	
	$("#reply"+updateReno).text(updateRememo);
	updateReno = updateRememo = null;
} 

function hideDiv(id){
	$(id).hide();
	$(id).appendTo(document.body);
}

function fn_replyReply(reno){
	$("#replyDialog").show();
	
	if (updateReno) {
		fn_replyUpdateCancel();
	} 
	
	$("#reparent3").val(reno);
	$("#rememo3").val("");
	$("#replyDialog").appendTo($("#reply"+reno));
	$("#rewriter3").focus();
} 
function fn_replyReplyCancel(){
	hideDiv("#replyDialog");
} 

function fn_replyReplySave(){
	if ( ! chkInputValue("#rewriter3", "작성자를")) return;
	if ( ! chkInputValue("#rememo3", "글 내용을")) return;

	var formData = $("#form3").serialize();
	$.ajax({
		url: "boardReplySave",
		type:"post", 
		data : formData,
		success: function(result){
			if (result!=="") {
				var parent = $("#reparent3").val();
				$("#replyItem"+parent).after(result);
				$("#replyDialog").hide();
				alert("저장되었습니다.");
				$("#rewriter3").val("");
				$("#rememo3").val("");
			} else{
				alert("서버에 오류가 있어서 저장되지 않았습니다.");
			}
		}
	})	
}


</script>

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
				<a class="btn btn-outline-warning" href="boardList?bgno=<c:out value="${boardInfo.bgno}"/>">돌아가기</a>
				<c:if test="${loginMember.memberId eq board.memId}">
					<a class="btn btn-outline-warning" onclick="deleteBoard()" href="boardDelete.do?key=<c:out value="${board.key}"/>">삭제</a>
					<c:if test="${sessionScope.member.member_name eq boardInfo.brdwriter}">
					<a class="btn btn-outline-warning" onclick="updateBoard('${ board.key }')" href="boardUpdate.do?key=<c:out value="${board.key}"/>">수정</a>
					</c:if>
				</c:if>
				</div>
                </div>
              </div>
			</form>
            </div>
				<br>
				
				
				<!-- 여기부터 댓글 -->
							
	<div class="col-lg-12">		
		<div id="replyList" class="card"> 
			<c:forEach var="replylist" items="${replylist}" varStatus="status">
				<div id="replyItem<c:out value="${replylist.reno}"/>"
							style="border: 1px light gray; margin-left: <c:out value="${20*replylist.redepth}"/>px; display: inline-block">	
				
					<div class="card-header py-3" style="height:50px !important">
					<strong class="m-0 font-weight-bold text-primary"><c:out value="${replylist.rewriter}"/></strong> <c:out value="${replylist.redate}"/>
					
					<c:if test="${sessionScope.member.member_status eq '9' || sessionScope.member.member_name eq replylist.rewriter}">
						<a href="#"  onclick="fn_replyDelete('<c:out value="${replylist.reno}"/>')">삭제</a>
						<c:if test="${sessionScope.member.member_name eq replylist.rewriter}">
						<a href="#"  onclick="fn_replyUpdate('<c:out value="${replylist.reno}"/>')">수정</a>
						</c:if>
					</c:if>
					<a href="#" onclick="fn_replyReply('<c:out value="${replylist.reno}"/>')">댓글</a>
					</div>
					
					<div align=left id="reply<c:out value="${replylist.reno}"/>"><c:out value="${replylist.rememo}"/></div>
				</div><br/>
			</c:forEach>
		</div>
		
		
		
		<div id="replyDiv" class="card mb-4 py-3 border-bottom-warning" style="display:none; padding-top:2px !important;margin-bottom:2px !important;">
			<form id="form2" name="form2" action="boardReplySave" method="post">
				<div align="center">
				<input type="hidden" id="brdno2" name="brdno" value="<c:out value="${boardInfo.brdno}"/>"> 
				<input type="hidden" id="reno2" name="reno"> 
				<textarea style="width:80% !important;" class="form-control bg-light border-0 small" id="rememo2" name="rememo" rows="3" cols="60" maxlength="500"></textarea>
				</div>
				<hr>
				<div align="center">
								<a href="#" class="btn btn-outline-secondary" onclick="fn_replyUpdateSave()">저장</a>
				<a href="#" class="btn btn-outline-secondary" onclick="fn_replyUpdateCancel()">취소</a>
				</div>
			</form>
		</div>
		
		<div id="replyDialog" class="card mb-4 py-3 border-bottom-warning" style="display:none; padding-top:2px !important; margin-bottom:2px !important;">
			<form id="form3" name="form3" action="boardReplySave" method="post">
				<div align="center">
				<input type="hidden" id="brdno3" name="brdno" value="<c:out value="${boardInfo.brdno}"/>"> 
				<input type="hidden" id="reno3" name="reno"> 
				<input type="hidden" id="reparent3" name="reparent"> 
				<input type="hidden" id="rewriter3" name="rewriter" value="<c:out value="${sessionScope.member.member_name}"/>">
				
				<textarea style="width:80% !important;" class="form-control bg-light border-0 small" id="rememo3" name="rememo" rows="3" cols="60" maxlength="500"></textarea>
				</div>
				<hr>
				<div align="center">
				<a href="#" class="btn btn-outline-secondary" onclick="fn_replyReplySave()">저장</a>
				<a href="#" class="btn btn-outline-secondary" onclick="fn_replyReplyCancel()">취소</a>
				</div>
			</form>
		</div>	
		
		
		<!-- 댓글작성창 -->
		<div class="card mb-4 py-3 border-bottom-warning"">
			<form id="form1" name="boardCommentFrm" action="${pageContext.request.contextPath}/boardInsert.do" method="post">
			<div align="center">
				<input type="hidden" name="boardRef" value="${ board.key }" />
				<input type="hidden" name="boardCommentWriter" value= "${loginMember.memberId }" />
				<input type="hidden" name="boardCommentLevel" value="1" />
				<input type="hidden" name="boardCommentRef" value="0" /> 
				<textarea style="width:80% !important;" class="form-control bg-light border-0 small" id="boardCommentFrm" name="boardCommentFrm"  rows="3" cols="60" maxlength="500" placeholder="댓글을 달아주세요."></textarea>
				</div>
				<hr>
				<button  type="submit" id="btn-insert" class="btn btn-outline-primary" >등록</button>
			</form>
			
		
		</div>
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

</script>
</html>
<jsp:include page="/WEB-INF/views/common/sbFooter.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
