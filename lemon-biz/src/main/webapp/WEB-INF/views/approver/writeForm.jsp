<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<fmt:requestEncoding value="utf-8" /> <!-- 한글깨짐 방지  -->
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/sbHeader.jsp"/>



<div>
	<h2>일반결제 작성</h2>
	<div>
		<button class="btn" onclick="selectApproval()">결제라인 추가</button>
	</div>
	
	
	
	<!------------------------------------------모달--------------------------------------->
	
	<div class="modal fade" id="selectApprovalModal" tabindex="-1" role="dialog" aria-labelledby="deleteMemoModalTitle" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
		    <div class="modal-header">
		      <h5 class="modal-title" id="selectApprovalModalTitle">결제라인 추가</h5>
		      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		        <span aria-hidden="true">&times;</span>
		        <div class="container col-4" style="margin: 0px; padding: 0px; width:200px; ">
				    <div class="easyui-panel" style="margin: 0px; width: 300px; height: 400px;">
				        <ul id="tt" class="easyui-tree">
							<li><span>lemonbiz</span>
								<ul>
									<c:forEach items="${deptList}" var="dept">
										<li data-options="state:'closed'"><span>${dept.department_id}) ${dept.department_name}</span>
											<ul>
	 											<c:forEach items="${memList}" var="mem">
													<c:if test="${dept.department_id eq mem.member_department}">
													<c:if test="${mem.rank_name == null}"> ${ mem.rank_name = "입사대기" }</c:if>
														<li>${mem.rank_name}|${mem.member_id}|${mem.member_name}</li> 
													</c:if>
												</c:forEach>
											</ul>
										</li>
									</c:forEach>
								</ul>
							</li>
				        </ul>
				    </div>
				    </div>
		      </button>
		    </div>
		  </div>
	  </div>
	</div> 

</div>

<script>
 function selectApproval(){
	$("#selectApprovalModal").modal()
} 


/* $('#tt').tree({
	onClick: function(node){
		
		console.log(node);
		console.log(node.text);
		
			$.ajax({
                type: 'POST',
                async: false,
                url: "${ pageContext.request.contextPath }/approval/getMemList",
                success: function(data) {

  					var obj = JSON.parse(data);
  					
  					$('#tbody').empty();
  					
  					printList(obj);
					console.log('in if KITWARE')
					return;
				}
			});
	} // if end
}); */

</script>





<jsp:include page="/WEB-INF/views/common/sbFooter.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>