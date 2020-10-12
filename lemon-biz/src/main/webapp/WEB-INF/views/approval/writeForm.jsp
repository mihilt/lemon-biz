<%@page import="com.lemon.lemonbiz.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:requestEncoding value="utf-8" /> <!-- 한글깨짐 방지  -->
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/sbHeader.jsp"/>


<style>



</style>


<div>
	<h2>일반결제 작성</h2>

	<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
  결제라인 추가
</button>

<!-- Modal -->
<div class="modal" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" style="max-width: 90%;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">결제라인 추가</h5>
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
    	<h5>결제자 선택</h5>
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
    	<h5>결제자 선택</h5>
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
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
	
	<!-- Modal end -->
	

	

</div>

<script>
/*=================================== 결제라인추가 script start ====================================*/
	$("#appr").jstree({
	  "plugins": ["wholerow","types","themes","html_data"],
	  "themes" : {            
	      'responsive' : true,
	      'themes' : ["classic"],
	  }

	}).bind('select_node.jstree',function(e,data){

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
		
		
 		MIN_NUM = 1;
		MAX_NUM = 5;
		var trArr = $('#finalList > tr');
		var cnt = 4; 
		
		
		for(var j = MIN_NUM; j <= MAX_NUM; j++) {
			if($('#memId_'+j).text()==memberId) {
				alert('이미 추가되어있는 결제자 입니다.');
				return;	
			}
			/* if(trArr[j-1].value != 'exist') {
				cnt--;
			} */ 
		}
		
		if(cnt==5) {
			alert('결제자가 모두 선택되었습니다. 삭제하고 다시 추가해주세요.');
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

				var result = data;
				rankKey = result.rankKey;
				deptName = result.deptName;
				memberName = result.memberName;
				
			}
		});

		if(rankKey == null) {
			rankKey = '입사대기';
		}
		if(deptName == null) {
			deptName = '발령대기';
		}

		for(var i=0; i<trArr.length; i++ ) {

			$('#memId_'+(i+1)+'').text(memberId);
			$('#dept_'+(i+1)+'').text(deptName);
			$('#name_'+(i+1)+'').text(memberName);
			$('#rank_'+(i+1)+'').text(rankKey);

			$('#del_'+(i+1)+'').html('<a class="xBtn" onclick="delLine('+(i+1)+')">[ X ]</a>');
			$('#order_'+(i+1)+'').html('&nbsp;<a class="upBtn" onclick="upBtn('+(i+1)+')">▲</a>&nbsp;<a class="dnBtn" onclick="dnBtn('+(i+1)+')">▼</a>&nbsp;')
			$('#'+(i+1)+'').val('exist');

			return;
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

	 /*=================================== 결제라인추가 script end ====================================*/
</script>


<jsp:include page="/WEB-INF/views/common/sbFooter.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>