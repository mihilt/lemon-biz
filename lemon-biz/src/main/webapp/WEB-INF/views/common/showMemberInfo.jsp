<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>

<!-- Modal -->
<div class="modal fade bd-example-modal-lg" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">사원 정보</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body pb-5">
      	
		<div id="modalProfileImg"class="m-5 mx-auto" 
			 style="
			 	width: 200px;
			 	height: 200px;
			 	background-size: 200px 200px;
		 	    border-radius: 70%;
		 	    border:solid 2px;
		 	    border-color: #d1d3e2;
   				overflow: hidden;
			 ">
		</div>
      	
		<div class="mb-1 row mx-5">
			<div class="col-2 pt-2 text-right">이름 :</div>
			<div id="modalMemberName" class="col-10 form-control"></div>
		</div>
		<div class="mb-1 row mx-5">
			<div class="col-2 pt-2 text-right">부서 :</div>
			<div id="modalDeptName" class="col-10 form-control"></div>
		</div>
		<div class="mb-1 row mx-5">
			<div class="col-2 pt-2 text-right">직급 :</div>
			<div id="modalRankName" class="col-10 form-control"></div>
		</div>
		<br />
		<div class="mb-1 row mx-5">
			<div class="col-2 pt-2 text-right">전화번호 :</div>
			<div id="modalTelNum" class="col-10 form-control"></div>
		</div>
		<div class="mb-1 row mx-5">
			<div class="col-2 pt-2 text-right">주소 :</div>
			<div id="modalAddress" class="col-10 form-control"></div>
		</div>
		<br />
		<div class="mb-1 row mx-5">
			<div class="col-2 pt-2 text-right">이메일 :</div>
			<div id="modalEmail" class="col-10 form-control"></div>
		</div>


      </div>
    </div>
  </div>
</div>

<script>

	function memberInfo(memberId){
		$.ajax({
			url : "${ pageContext.request.contextPath }/member/selectOneMemberAjax.do?memberId="+memberId,
			data : {

			},
			dataType : "json",
			success : function(data){
				console.log(data);
				console.table(data.address);
				
				data.name == undefined ? $("#modalMemberName").text("") : $("#modalMemberName").text(data.name);
				data.deptName == undefined ? $("#modalDeptName").text("") : $("#modalDeptName").text(data.deptName);
				data.rankName == undefined ? $("#modalRankName").text("") : $("#modalRankName").text(data.rankName);
				data.telNum == undefined ? $("#modalTelNum").text("") : $("#modalTelNum").text(data.telNum);
				data.address == undefined ? $("#modalAddress").text("") : $("#modalAddress").text(data.address);
				data.email == undefined ? $("#modalEmail").text("") : $("#modalEmail").text(data.email);

				let image = new Image();
				image.src = '${pageContext.request.contextPath }/resources/upload/profile_images/' + data.memberId + '.png';
				
				image.onload=function(){
					$("#modalProfileImg").css({
						"background-image":"url(${pageContext.request.contextPath }/resources/upload/profile_images/"+data.memberId+".png)"});
			    }

				image.onerror=function(){
					$("#modalProfileImg").css({
							"background-image":"url(${pageContext.request.contextPath }/resources/images/default-image.png)"});
			    }

			},
			error : function(xhr, status, err){
				console.log(xhr, status, err);
			},
			complete : function(){
				$('#exampleModal').modal('show')
			}
			
		});
	}
	
</script>