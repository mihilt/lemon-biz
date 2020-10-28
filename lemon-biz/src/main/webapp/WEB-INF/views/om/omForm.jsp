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
</style>
</head>

<body>

	<div class="container">
		<div class="card">
			<h4 id="m-title" class="card-header">
				<strong>메일 작성</strong>
			</h4>
			<div class="container-inner card-body">
				<form id="omFrm" name="omFrm"
					action="${pageContext.request.contextPath}/om/omEnroll.do"
					method="POST" enctype="multipart/form-data">
					<div class="form-group row">
						<label for="mFrom" class="col-sm-1 col-form-label">작성자</label>
						<div class="col-sm-9">
							<input type="text" readonly class="form-control" id="toShow"
								name="name" value="${loginMember.name}" readonly> <input
								type="hidden" name="memId" class="form-control" id="memId"
								value="${loginMember.memberId}" />
						</div>
					</div>
					<div class="form-group row">
						<label for="mTo" class="col-sm-1 col-form-label" id="send-to">수신자</label>
						<div class="col-sm-9">
							<input type="text" class="form-control" id="omrId" name="omrId"
								placeholder="수신인을 선택하세요.">
						</div>
						<button type="button" class="btn btn-light"
							data-target="#addReceiverModal" id="addReceiverBtn">수신인
							추가</button>
					</div>

					<div class="form-group row">
						<label for="mFrom" class="col-sm-1 col-form-label">&ensp;제목</label>
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
								for="upFile1" style="width:80%">파일을 선택하세요</label>
						</div>
					</div> 
					<div align="justify">
						<textarea id="brdmemo" class="summernote" name="content"
							cols="120" rows="12" style="width: 100%; resize: none"
							class="form-control"></textarea>
					</div>
					<div align="center" id="btns">
						<input type="submit" value="메일 발송" id="send-mail"
							class="btn btn-success" onclick="fn_formSubmit()"> <input
							type="button" value="파일 첨부" id="attach-to" class="btn btn-info"
							data-target="#attachModal" /> <input type="button" value="임시 저장"
							id="content-temp" class="btn btn-secondary" /> <input
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

	<!-- 수신인 추가 모달 -->
	<!-- Modal -->
<div class="modal" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" style="max-width: 90%;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">결재라인 추가</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <div class="row">
      <div class="col-md-4">
      <h5>부서 선택</h5>
        <!-- tree -->
	<div id="appr" style="margin: 5px; padding: 5px; border:1px solid lightgray;">
        <ul id="approvalSelect">
        	<c:forEach items="${dept}" var="dept">
            <li><a>${dept.name}</a>
                <ul>
                	<c:forEach items="${child}" var="child">
                    <li><a>${child.name}</a>
                        <ul>
                        	<c:forEach items="${child2}" var="child2">
                        	<c:if test="${child.key eq child2.ref }">
                            <li>${child2.name}</li>
                            </c:if>
                            </c:forEach>
                        </ul>
                    </li>
                    </c:forEach>
                </ul>
            </li>
            </c:forEach>
        </ul>
    </div>
    </div>
    
        <!-- tree end-->
        
        <!-- printList Form -->
      
		<div class="container col-4" style="height:400px; margin: 0px; overflow-y:auto;">
    	<h5>결재자 선택</h5>
    		<div id="apprst" style="margin: 0px; padding: 0px; border:1px solid lightgray; height:360px;">
    			<div class="row" style="margin: 5px 5px"> 
    			<label>성명</label>
    			<input type="text" id="searchN"/>
    			<button class="btn btn-outline-primary" id="searchNm" onclick="searchName()">검색</button>
    			</div>
    	
    			<div class="row" style="margin: 5px 5px">
    			
			    	<table>
			    	
			    	<tr>
			    	<th>부서</th>
			    	<th>성명</th>
			    	<th>직위</th>
			    	<th>사번</th>
			    	</tr>
			    	
			    	<tbody id="tbody">
				    <c:forEach var="item" items="${ memberList }">
				    	<tr onclick="selectMember(${item.memberId})" style="cursor:pointer;" class="memberList">
				    	<td>
				    	<c:choose>
				    		<c:when test="${ item.deptName == null }">${ item.deptName = "발령대기" }</c:when>
				    		<c:otherwise>${ item.deptName }</c:otherwise>
				    	</c:choose>
				    	</td>
				    	<td>${ item.name }</td>
				    	<td>${ item.rankKey }</td>
				    	<td>${ item.memberId }</td>
				    	</tr>
				    </c:forEach>	
			    	</tbody>
			    	</table>
    	
    			</div>
    
    		</div>
    	</div>
    	<!-- printList Form end -->
    	
    	
      	<!-- selectMember Form-->
		<div class="container col-4" style="height:400px; margin: 0px; overflow-y:auto;">
    	<h5>결재자 선택</h5>
    		<div id="apprst" style="margin: 5px; padding: 5px; border:1px solid lightgray; height:360px;">
    			
    	
    			<div class="row" style="margin: 5px 5px">
			<table>
    
		      	<tr>
		      	<th>No.</th>
		    	<th>부서</th>
		    	<th>성명</th>
		    	<th>직위</th>
		    	<th>사번</th>
		    	<th>순서</th>
		    	<th>삭제</th>
		    	</tr>
		    	
		    	<tbody id="finalList">
		    	<c:forEach begin="1" end="3" varStatus="stat">
		    	
		    	<tr id="${ stat.count }" >
		    	<td id="no_${ stat.count }">${ stat.count }</td>
		    	<td id="dept_${ stat.count }"></td>
		    	<td id="name_${ stat.count }"></td>
		    	<td id="rank_${ stat.count }"></td>
		    	<td id="memId_${ stat.count }"></td>
		    	<td id="order_${ stat.count }"></td>
		    	<td id="del_${ stat.count }"></td>
		    	</tr>
		    	
		    	</c:forEach>
		    	</tbody>
    
    		</table>
    			</div>
    
    		</div>
    	</div>
      	
      	
      	<!-- selectMember Form end-->
      	
    

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" onclick="apply()">저장하기</button>
      </div>
    </div>
  </div>
</div>
</div>
	
	
	<!-- 주. 모달 본체에 해당하는 애들은 container/wrapper로 감쌀 필요가 없으므로 /body태그의 바로 윗 편, 즉 body 태그 내부 최 하단에 위치시켜 주어야 문제가 안 생긴다! -->

	
</body>
<script>
$(document).ready(function() {
	$('#proNum1').val(1);
	$('#proNum2').val(2);
	$('#proNum3').val(3);
	
	MIN_NUM = 1;
	MAX_NUM = 3;

	for(var i = MIN_NUM; i <= MAX_NUM ; i++) {

		if($(document).find('#authRank'+i+'').text().trim() != ''){
	    	$('#rank_'+i+'').text($(document).find('#authRank'+i+'').text());
	    	$('#name_'+i+'').text($(document).find('#authName'+i+'').text());
	    	$('#dept_'+i+'').text($(document).find('#authDept'+i+'').val());
	    	$('#memId_'+i+'').text($(document).find('#apv_mem'+i+'').text());
			$('#del_'+i+'').html('<a class="xBtn" onclick="delLine('+i+')">[ X ]</a>');
			$('#order_'+i+'').html('&nbsp;<a class="upBtn" onclick="upBtn('+i+')">▲</a>&nbsp;<a class="dnBtn" onclick="dnBtn('+i+')">▼</a>&nbsp;');
			$('#'+i+'').val('exist');
		}
	}
})

$("#appr").jstree({
  "plugins": ["wholerow","types","themes","html_data"],
  "themes" : {            
      'responsive' : true,
      'themes' : ["classic"],
  }

}).bind('select_node.jstree',function(e,data){

	console.log(data.node.text);
	$.ajax({
		type: "GET",
		url : "${pageContext.request.contextPath}/approval/approvalSelect.do",
		data : {
			node : data.node.text
		},
		dataType : "json",
		contentType: "application/json; charset=utf-8;",
		success : function(data) {

			$("#tbody").empty();
			
			printList(data);
			return;
				
		},
		error:function() {
			return;
		}
	})
});


function printList(data) {

	for(var i in data.memberList) {
			console.log(data.memberList[1].name);
		console.log(data.memberList);
		
		if(data.memberList[i].deptName==null){
			data.memberList[i].deptName='발령대기';
		}
		if(data.memberList[i].memberId==null) {
			data.memberList[i].deptName='입사대기';
		}
		
		$('<tr></tr>').css('cursor','pointer').attr('class','memberList')
					  .attr('onclick','selectMember("'+data.memberList[i].memberId+'")')
					  .attr('id',data.memberList[i].memberId).appendTo('#tbody');
		$('<td></td>').text(data.memberList[i].deptName).appendTo('#'+data.memberList[i].memberId+'');
		$('<td></td>').text(data.memberList[i].name).appendTo('#'+data.memberList[i].memberId+'');
		$('<td></td>').text(data.memberList[i].rankKey).appendTo('#'+data.memberList[i].memberId+'');
		$('<td></td>').text(data.memberList[i].memberId).appendTo('#'+data.memberList[i].memberId+'');
	}
}


function selectMember(memberId) {

	
	console.log(memberId);
	
	
	if(memberId == "${loginMember.memberId}") { 
		alert('본인은 선택할 수 없습니다.');
		return;
	}
	
	
	var trArr = $('#finalList > tr');
	var cnt = 3; 
	
	
	for(var j = MIN_NUM; j <= MAX_NUM; j++) {
		if($('#memId_'+j).text()==memberId) {
			alert('이미 추가되어있는 결재자 입니다.');
			return;	
		}
		if(trArr[j-1].value != 'exist') {
			cnt--;
		} 
	}
	
	if(cnt==3) {
		alert('결재자가 모두 선택되었습니다. 삭제하고 다시 추가해주세요.');
		return;
	}

	var rankKey;
	var deptName;
	var memberName;
	var param = memberId;
	$.ajax({
		type: "POST",
		url : "${pageContext.request.contextPath}/approval/selectMember.do",
		dataType : "json",
		data: {
			param : param
		},
		success : function(data) {

			var result = data.selectMember;
			
			rankKey = result[0].rankKey;
			deptName = result[0].deptName;
			memberName = result[0].name;
			console.log(memberName);
			console.log(deptName);
			
	if(rankKey == null) {
		rankKey = '입사대기';
	}
	if(deptName == null) {
		deptName = '발령대기';
	}
	if(memberName == null) {
		memberName= '오류';
	}
	
	for(var i=0; i<trArr.length; i++ ) {

		if($('#'+(i+1)+'').val() != 'exist'){
		$('#memId_'+(i+1)).text(memberId);
		$('#dept_'+(i+1)).text(deptName);
		$('#name_'+(i+1)).text(memberName);
		$('#rank_'+(i+1)).text(rankKey);

		$('#del_'+(i+1)+'').html('<a class="xBtn" onclick="delLine('+(i+1)+')">[ X ]</a>');
		$('#order_'+(i+1)+'').html('&nbsp;<a class="upBtn" onclick="upBtn('+(i+1)+')">▲</a>&nbsp;<a class="dnBtn" onclick="dnBtn('+(i+1)+')">▼</a>&nbsp;')
		$('#'+(i+1)+'').val('exist');

		return;
	}


 }
		}
	});

}


function delLine(i){
	 
	 if($('#'+(i+1)+'').val() == 'exist'){
		 alert('차순 결재자가 있습니다.');
		 return;
	 }else{
		$('#'+i+'').val(null); 
		$('#dept_'+i+'').text('');
		$('#dept_'+i+'').val('');
		$('#name_'+i+'').text('');
		$('#rank_'+i+'').text('');
		$('#memId_'+i+'').text('');
		
		$('#del_'+i+'').html('');
		$('#order_'+i+'').html('');
	 }
	 
 }
 
 function searchName(){
	 var searchN = $('#searchN').val();
	 $('#searchN').val('');
	 
	 var param = searchN;
	 $.ajax({
         type: 'POST',
         url: "${ pageContext.request.contextPath }/approval/searchName.do",
         data: {
			param : param
         },
         dataType : "json",
         success: function(data) {
				if(data == 'error'){
					return;
				}
				var obj = data.joinMemberList; 
				//var obj = data; <-- 이렇게 해버리면 불러올때 obj[i].joinMemberList.name 하면 undifine뜸
				//java에서 정의한 ArrayList명을 적어준다. 중요..안그럼 불러오기 까다로워짐
				
				$('#tbody').empty();
				
				MprintList(obj);

				return;

		},
		error: function(){
			return;
		}
	});
 }
 
 function MprintList(obj){
	 	
		for(var i in obj){
		
		
		if(obj[i].deptName == null){
			obj[i].deptName = '발령대기'
		}
			if(obj[i].rankKey == null){
				obj[i].rankKey = '입사대기'	
			}
			$('<tr></tr>').css('cursor','pointer').attr('class','memberList')
						  .attr('onclick','selectMember('+obj[i].memberId+')')
						  .attr('id', obj[i].memberId).appendTo('#tbody');
			$('<td></td>').text(obj[i].deptName).appendTo('#'+obj[i].memberId+'');
			$('<td></td>').text(obj[i].name).appendTo('#'+obj[i].memberId+'');
			$('<td></td>').text(obj[i].rankKey).appendTo('#'+obj[i].memberId+'');
			$('<td></td>').text(obj[i].memberId).appendTo('#'+obj[i].memberId+'');
			
		}
 }

 function upBtn(i){
	 
		if(i == MIN_NUM){
			return;
		}
		 
		var dept = $('#dept_'+(i-1)+'').text();
		var name = $('#name_'+(i-1)+'').text();
		var rank = $('#rank_'+(i-1)+'').text();
		var memId = $('#memId_'+(i-1)+'').text();
		
		$('#dept_'+(i-1)+'').text($('#dept_'+i+'').text());
		$('#name_'+(i-1)+'').text($('#name_'+i+'').text());
		$('#rank_'+(i-1)+'').text($('#rank_'+i+'').text());
		$('#memId_'+(i-1)+'').text($('#memId_'+i+'').text());
		
		$('#dept_'+i+'').text(dept);
		$('#name_'+i+'').text(name);
		$('#rank_'+i+'').text(rank);
		$('#memId_'+i+'').text(memId);
		 
	 }

 function dnBtn(i){

		if(i == MAX_NUM){
			return;
		}
		 
		var dept = $('#dept_'+(i+1)+'').text();
		var name = $('#name_'+(i+1)+'').text();
		var rank = $('#rank_'+(i+1)+'').text();
		var memId = $('#memId_'+(i+1)+'').text();
		
		$('#dept_'+(i+1)+'').text($('#dept_'+i+'').text());
		$('#name_'+(i+1)+'').text($('#name_'+i+'').text());
		$('#rank_'+(i+1)+'').text($('#rank_'+i+'').text());
		$('#memId_'+(i+1)+'').text($('#memId_'+i+'').text());
		
		$('#dept_'+i+'').text(dept);
		$('#name_'+i+'').text(name);
		$('#rank_'+i+'').text(rank);
		$('#memId_'+i+'').text(memId);

 }

function apply(){

	for(var i = MIN_NUM; i <= MAX_NUM ; i++){

		$(document).find('#authName'+i).text($('#name_'+i).text());
		$(document).find('#authRank'+i).text($('#rank_'+i).text());
		$(document).find('#authDept'+i).val($('#dept_'+i).text());
		$(document).find('#authId'+i).val($('#memId_'+i).text());
		$(document).find('#apv_mem'+i).text($('#memId_'+i).text());
		
		$('#exampleModal').modal('hide');
		 			

	 }

}
</script>



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

	/* $(function(){
		$("#searchType").change(function(){
			console.log($(this).val());
			var type = $(this).val();
			$(".search-type").hide()
							 .filter("#search-" + type)
							 .css("display", "inline-block");
		});
	}); */
</script>
</html>


<jsp:include page="/WEB-INF/views/common/sbFooter.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />