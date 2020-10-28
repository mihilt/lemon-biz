<%@page import="com.lemon.lemonbiz.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:useBean id="now" class="java.util.Date" />
<fmt:requestEncoding value="utf-8" /> <!-- 한글깨짐 방지  -->
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/sbHeader.jsp"/>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>

<!-- include summernote-ko-KR -->
<script src="${pageContext.request.contextPath }/resources/summernoteKr/summernote-ko-KR.js"></script>

<script>
//add summernote
$(document).ready(function() {
  $('#summernote').summernote({
    lang: 'ko-KR',
    height: 500
    
  });
});
</script>

<div>
	<h2>일반결재 작성</h2>

	


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
    		<div id="apprst" style="margin: 0px; padding: 0px; border:1px solid lightgray; min-height:360px;">
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











	<!-- Modal end -->
	
	<div class="container">
		<div class="container-fluid">
		<!-- 게시글 -->
 			<div class="col-lg-12">			
             	<div class="card" >
                	<div class="card-header py-3" align="center">	
						<table class="table table text-center">
					    <tr>
					    	<td><strong>기안담당</strong>
								<c:choose>
								<c:when test="${ loginMember.isManager == 1 }">관리자</c:when>
								<c:otherwise>${ loginMember.name }</c:otherwise>
								</c:choose>
							</td>
								
							<td><strong>기안부서</strong>
								<c:choose>
								<c:when test="${ loginMember.isManager == 1 }">관리자</c:when>
								<c:otherwise>${ loginMember.deptName }</c:otherwise>
								</c:choose>
							</td>
							
							<td>
							<strong>기안일자</strong>
							<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
							<c:out value="${today}"/>
							</td>
						</tr>
					    </table>
					</div>
					<div class="p-2">
					    <!-- ================결재칸=============== -->
					    <input type="hidden" id="authDept1" name="authDept1" value="">
						<input type="hidden" id="authDept2" name="authDept2" value="">
						<input type="hidden" id="authDept3" name="authDept3" value="">
						
					    <table>
						<tr><td width="50%">
						<div class="float-center">
							<!-- Button trigger modal -->
							<button type="button" class="btn btn-outline-primary" data-toggle="modal" data-target="#exampleModal">
							  결재라인 추가
							</button>
						</div>
						</td>
						<td width="50%">
						<div class="float-right">
						<table border="1" style="display: inline-block">
						
						<tr>
							<td></td>
							<td>기안자</td>
							<td id="proNum1">1차 결재자</td>
							<td id="proNum2">2차 결재자</td>
							<td id="proNum3">3차 결재자</td>
						</tr>
						<tr>
						<td class="tt" rowspan='4'>결재</td>
						<td class="aa">작성자</td>
						
						<td id="authRank1" class="aa">
						${ apprck1.rankName }
						</td>
						
						<td id="authRank2" class="aa">
						${ apprck2.rankName }
						</td>
						
						<td id="authRank3" class="aa">
						${ apprck3.rankName }
						</td>
						
						
						<%-- <td id="authRank1" class="aa">${ apvReWrite.rank_name1 }</td>
						<td id="authRank2" class="aa">${ apvReWrite.rank_name2 }</td>
						<td id="authRank3" class="aa">${ apvReWrite.rank_name3 }</td> --%>
						</tr>
						
						
						<tr>
						
						<td>${ loginMember.name }</td>
						<td id="authName1">${ apprck1.ckName }</td>
						<td id="authName2">${ apprck2.ckName }</td>
						<td id="authName3">${ apprck3.ckName }</td>
						
						</tr>
						
						<tr>
						
						<td>${ loginMember.memberId }</td>
						<td id="apv_mem1">${ apprck1.memId }</td>
						<td id="apv_mem2">${ apprck2.memId }</td>
						<td id="apv_mem3">${ apprck3.memId }</td>
	
						</tr>
						
						</table>
						</div>
						
						</table>
						</div>
						<!-- ==============결재칸 끝============== -->
						
						<!-- 양식 선택 -->											      	
						<select name="docType" class="col-5 form-control mx-2 my-5"
							id="docType">
							<option value="none" selected>--- 양식을 선택해주세요. ---</option>
							<c:forEach items="${ docTypeList }" var="docType">
								<option value="${ docType.key }">
									${ docType.name }
								</option>
							</c:forEach>
						</select>
						
						<!-- 폼 내용 -->
						<form class="p-2" id="sendApv" action="${ pageContext.request.contextPath }/approval/updateApproval.do" method="POST" enctype="multipart/form-data">
							<input type="hidden" id="authId1" name="approval_mem1" />
							<input type="hidden" id="authId2" name="approval_mem2" />
							<input type="hidden" id="authId3" name="approval_mem3" />
							<input type="hidden" id="processNum1" name="process_num1">
							<input type="hidden" id="processNum2" name="process_num2">
							<input type="hidden" id="processNum3" name="process_num3">
							<input type="hidden" id="status" name="status" value="p"/>
							
							
							&nbsp;제목 : <input class="form-control" id="title" type="text" name="approval_title" value="${ appr.title }">
							<br>
							
							<div>
								<div class="form-control" style="height:700px; overflow:auto;" align=left>${ appr.content }</div> <br>
							</div>
							
							
							<label for="file">첨부: </label> <br>
							<input type="file" name="upFile" id="upFile"/>
							<hr>
						               
						</form>
						
						<!-- 폼 내용 end -->
						
						<div class="container" align="center">
						<input class="btn btn-outline-primary" type="button" value="뒤로가기" onclick="history.back(-1);">
						<button class="btn btn-outline-primary" onclick="save()">저장하기</button>
						<button class="btn btn-outline-primary" onclick="tempchk()">제출하기</button>
						
						<div><br></div>
						</div>
						
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal" id="comment">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">알림</h5>
					<button type="button" class="btn btn-outline-primary" data-dismiss="modal">&times;</button>
				</div>

					<div class="form-group">
						<div class="modal-body">

							<label>문서를 제출합니다.</label><br>
							
						</div>
						<div class="modal-footer float-right">
							<button class="btn btn-outline-primary" type="submit" onclick="tempStore()" >제출</button>
							
						</div>
					</div>
			</div>
		</div>
	</div>
	
	
	<div class="modal" id="savingApproval">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">알림</h5>
					<button type="button" class="btn btn-outline-primary" data-dismiss="modal">&times;</button>
				</div>

					<div class="form-group">
						<div class="modal-body">

							<label>문서 저장시에 첨부파일은 저장되지 않습니다.</label><br>
							
						</div>
						<div class="modal-footer float-right">
							<button class="btn btn-outline-primary" type="submit" onclick="updateApproval()" >제출</button>
							
						</div>
					</div>
			</div>
		</div>
	</div>
	
	
	
	
	





<script>
/*=================================== 결재라인추가 script start ====================================*/
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
			$('<td></td>').text(data.memberList[i].rankName).appendTo('#'+data.memberList[i].memberId+'');
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
				
				rankName = result[0].rankName;
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
			$('#rank_'+(i+1)).text(rankName);

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
	/*=================================== 결재라인추가 script end ====================================*/
	
	/* ======================================폼 제출관련 script start=================================== */
	function tempchk() {

		console.log("11");
		console.log($('#authId1').val());
		console.log($('#authId2').val());
		console.log($('#authId3').val());
		console.log($('#proNum1').val());
		console.log($('#proNum2').val());
		console.log($('#proNum3').val());
		console.log($('#title').val());
		console.log($('#summernote').val());
		console.log($('#apvCateGo').val());
		console.log($('#apv_comment').val());

		if(($('#title').val()).trim() == ''){
			alert('제목을 입력해주세요')
			return;
		}
		if(($('#summernote').val()).trim() == ''){
			alert('내용을 입력해주세요')
			return;
		}
		
		if( $('#authId1').val() == '' || $('#authId2').val() == '' || $('#authId3').val() == '') {
			alert('결재자를 모두 선택해주세요');
			return;
		}

		

		$('#comment').modal();
	}

	function tempStore() {
		
		
		for(var i = 1 ; i <=3 ; i++){
			$('#authId'+i+'').val($('#apv_mem'+i+'').text());	
		} 
		for(var i = 1 ; i <=3 ; i++) {
			$("#processNum"+i).val($('#proNum'+i).val());
		}
		$('<input></input>').attr('type','hidden').attr('value','${appr.key}').attr('name','updateApprovalKey').appendTo('#sendApv');
	
		$('#sendApv').submit();
		
		
		
	}

	function save() {

		$('#savingApproval').modal();
	}

	function updateApproval() {

		if(($('#title').val()).trim() == ''){
			alert('제목을 입력해주세요')
			return;
		}
		if(($('#summernote').val()).trim() == ''){
			alert('내용을 입력해주세요')
			return;
		}

		

		for(var i = 1 ; i <=3 ; i++){
			$('#authId'+i+'').val($('#apv_mem'+i+'').text());	
		} 
		for(var i = 1 ; i <=3 ; i++) {
			$("#processNum"+i).val($('#proNum'+i).val());
		}


		
		
		var status = $('#status');
		status.attr('value','t');
		
		
		var authId11 = $('#authId1').val();
		
		console.log(authId11);
		
																																			
		$('<form></form>').attr('action',"${pageContext.request.contextPath}/approval/applovalSave.do").attr('method', 'POST').attr('id','updateApproval').attr('enctype','multipart/form-data').appendTo('#body');
		$('<input></input>').attr('type','hidden').attr('value',$('#authId1').val()).attr('name','updatdAuthId1').appendTo('#updateApproval');
		$('<input></input>').attr('type','hidden').attr('value',$('#authId2').val()).attr('name','updatdAuthId2').appendTo('#updateApproval');
		$('<input></input>').attr('type','hidden').attr('value',$('#authId3').val()).attr('name','updatdAuthId3').appendTo('#updateApproval');
		$('<input></input>').attr('type','hidden').attr('value',$('#processNum1').val()).attr('name','updateProcessNum1').appendTo('#updateApproval');
		$('<input></input>').attr('type','hidden').attr('value',$('#processNum2').val()).attr('name','updateProcessNum2').appendTo('#updateApproval');
		$('<input></input>').attr('type','hidden').attr('value',$('#processNum3').val()).attr('name','updateProcessNum3').appendTo('#updateApproval');
		$('<input></input>').attr('type','hidden').attr('value',$('#status').val()).attr('name','updateStatus').appendTo('#updateApproval');
		$('<input></input>').attr('type','hidden').attr('value',$('#title').val()).attr('name','updateTitle').appendTo('#updateApproval');
		$('<input></input>').attr('type','hidden').attr('value',$('#summernote').val()).attr('name','updateContent').appendTo('#updateApproval');
		
		$('<input></input>').attr('type','hidden').attr('value','${appr.key}').attr('name','updateApprovalKey').appendTo('#updateApproval');

		if( $('#authId1').val() == '' || $('#authId2').val() == '' || $('#authId3').val() == '') {
			alert('결재자를 모두 선택해주세요');
			return;
		}
		
		
		console.dir($('#updateApproval'));
		
		
		$('#updateApproval').submit();
	

	}
	
	
	
	
		 
	/* ======================================폼 제출관련 script end=================================== */	 
	 
	 
	/* 양식 설정 script */
	
	$(function(){
			$('#docType').change(function(){

					const key = $("#docType option:selected").val();
					
					$.ajax({
						url : "${ pageContext.request.contextPath }/approval/selectOneDocTypeAjax.do?key="+key,
						data : {
						},
						dataType : "json",
						success : function(data){
							/* console.log(data); */
							
							$("#summernote").summernote("code", data.form);

						},
						error : function(xhr, status, err){
							console.log(xhr, status, err);
						}
					});

					
				});
		});
	 
</script>


<jsp:include page="/WEB-INF/views/common/sbFooter.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>