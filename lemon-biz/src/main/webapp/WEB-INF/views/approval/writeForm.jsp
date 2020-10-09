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
  <div class="modal-dialog modal-lg" role="document">
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
        
        <!-- selectMember Form -->
      
		<div class="container col-5" style="height:400px; margin: 0px; overflow-y:auto;">
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
      	<!-- selectMember Form end-->
    

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
	
	
	

</div>

<script>
/* tree script */
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

				/* var obj = JSON.stringify(data);
				// JSON.stringify은 json문자열을 String문자열로 변환시켜줌.
				반대로 JSON.parse 는 json문자열로 변경시킴*/

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
				data.memberList[i].deptName="발령대기"
			}
			if(data.memberList[i].memberId==null) {
				data.memberList[i].deptName="입사대기"}
			$('<tr></tr>').css('cursor','pointer').attr('class','memberList')
						  .attr('onclick','selectMember('+data.memberList[i].memberId+')')
						  .attr('id',data.memberList[i].memberId).appendTo('#tbody');
			$('<td></td>').text(data.memberList[i].deptName).appendTo('#'+data.memberList[i].memberId);
			$('<td></td>').text(data.memberList[i].name).appendTo('#'+data.memberList[i].memberId);
			$('<td></td>').text(data.memberList[i].rankKey).appendTo('#'+data.memberList[i].memberId);
			$('<td></td>').text(data.memberList[i].memberId).appendTo('#'+data.memberList[i].memberId);
		}
	}
	

		
/* tree end */
</script>


<jsp:include page="/WEB-INF/views/common/sbFooter.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>