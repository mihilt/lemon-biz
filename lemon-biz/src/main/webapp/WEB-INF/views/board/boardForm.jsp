<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType= "text/html; charset=UTF-8" pageEncoding= "UTF-8" %>
<!DOCTYPE html>
<html lang="kor">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>GroupWare</title>
<!-- Custom fonts for this template-->
<link href="${contextPath}/resources/bootstrap/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

<!-- Bootstrap core JavaScript-->
<script	src="${contextPath}/resources/bootstrap/vendor/jquery/jquery.min.js"></script>
<script	src="${contextPath}/resources/bootstrap/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="${contextPath}/resources/bootstrap/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="${contextPath}/resources/bootstrap/js/sb-admin-2.min.js"></script>

<!-- Page level plugins -->
<script src="${contextPath}/resources/bootstrap/vendor/chart.js/Chart.min.js"></script>

<!-- Page level custom scripts -->
<script src="${contextPath}/resources/bootstrap/js/demo/chart-area-demo.js"></script>
<script src="${contextPath}/resources/bootstrap/js/demo/chart-pie-demo.js"></script>

<!-- Custom styles for this template-->
<link href="${contextPath}/resources/bootstrap/css/sb-admin-2.min.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/fbd170e696.js"></script>

<!-- 썸머노트  -->

<!-- include summernote css/js-->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
<style type="text/css">
	#buttons button{
		margin: 5em;
		display: inline-block;
		margin-left: auto;
		margin-right: auto;
	}
	#buttons{
		display: inline-block;
		margin-left: auto;
		margin-right: auto;
		text-align: center;
	}
	.dropdown >span{
		size: 10px;
		margin: 1em;
	}
</style>
</head>
<body id="page-top">

	<!-- 메인레버 -->
	<div id="wrapper">
		<!-- 사이드바 -->
		
		<!-- 컨텐츠 영역 -->
		<div class="container-fluid">
				  <div class="card-body">
					  <h3 style="margin-bottom: 25px;" id="title">
					  <c:if test="${board.bType eq 'B'}">
					일반 공지
					</c:if>
					<c:if test="${board.bType eq 'I'}">
					중요 공지
					</c:if>
					  </h3>
					  <div class="card shadow mb-4">
                <!-- Card Header - Dropdown -->
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="m-0 font-weight-bold text-primary">${board.bTitle}</h6>
                  
                  <!--수정  -->
                  <div class="dropdown no-arrow">
                  	<span>게시일 : ${board.bDate}</span>
                  	<c:if test="${!empty board.modifyDate}">
                  		<span>수정일 : ${board.modifyDate}</span>
                  	</c:if>
                  	<span>조회수 : ${board.bCount}</span>
                  	<span>게시자 : ${board.empName}</span>
                    <c:if test="${loginEmp.empNo eq board.empNo}">
                    <a class="dropdown-toggle" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink" x-placement="bottom-end" style="position: absolute; transform: translate3d(-156px, 18px, 0px); top: 0px; left: 0px; will-change: transform;">
                      <c:url var="bUpdateView" value="bUpdateView.do">
                      	<c:param name="bNo" value="${board.bNo}"/>
                      	<c:param name="page" value="${ page }"/>
                      </c:url>
                      <a class="dropdown-item" onclick="location.href='${ bUpdateView }'">수정하기</a>
                      <a class="dropdown-item" onclick="changetType();">
                      <span id="status">
                      	<c:if test="${board.bType eq 'B'}">
                      	중요 공지로 변경
                      	</c:if>
                      	<c:if test="${board.bType eq 'I'}">
                      	일반 공지로 변경
                      	</c:if>
                      	</span>
                      </a>
                      <div class="dropdown-divider"></div>
                      <a class="dropdown-item" onclick="deleteFun();">삭제하기</a>
                    </div>
                    </c:if>
                  </div>
                  
                  
                </div>
                <!-- Card Body -->
                <div class="card-body" style="padding : 5rem;">
                 ${board.bContent}
                </div>
              </div>
					  <div class="row">
						  <div id="buttons">
							  	<c:url var="blist" value="notice.do">
									<c:param name="page" value="${ page }"/>
									<c:param name="cate" value="${cate}"/>
                			  		<c:param name="search" value="${search}"/>
								</c:url>
							  <button type="button" onclick="location.href='${ blist }'" class="btn btn-secondary">목록으로</button>
						  </div>
					  </div>
				 </div>


		</div>
	</div>
	<script type="text/javascript">
		function changetType(){
			if(confirm("공지 노출 상태를 병경하시겠습니까?")){
				var bNo = ${board.bNo};
				var bType = "${board.bType}";
				$.ajax({
					url:"changeType.do",
					data:{bNo:bNo,bType:bType},
					type:"post",
					success:function(data){
						if(data=='B'){
						$("#title").text("일반 공지");
						$("#status").text("중요 공지로 변경");
						}else if(data=='I'){
						$("#title").text("중요 공지");
						$("#status").text("일반 공지로 변경");
						}
						alert("게시판 노출 상태가 성공적으로 변경되었습니다.");
					}
				});
			}
		}
		
		function deleteFun(){
			if(confirm("정말로 삭제하시겠습니까?")){
				var bNo = ${board.bNo};
				var page = ${page};
				$.ajax({
					url:"bDelete.do",
					data:{bNo:bNo},
					type:"get",
					success:function(data){
						alert("게시글이 성공적으로 삭제되었습니다.");
						window.location.href="notice.do?page"+page;
					}
				});
			}
		}
	</script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false"></jsp:include>
	
</body>

</html>
